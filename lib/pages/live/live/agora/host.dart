// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:realdating/chat/api/apis.dart';
// import 'package:realdating/pages/live/live/constant/constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../home_page_new/home_page_user.dart';
// import '../../../../reel/common_import.dart';
//
// class Host extends StatefulWidget {
//   final String channelName;
//   final String? userId;
//
//   const Host({Key? key, required this.channelName, required this.userId}) : super(key: key);
//
//   @override
//   State<Host> createState() => _HostState();
// }
//
// class _HostState extends State<Host> {
//   late RtcEngine _engine;
//   bool muted = false;
//   bool loading = false;
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   User? user = FirebaseAuth.instance.currentUser;
//   String? userName = '';
//   String? token;
//
//   @override
//   void initState() {
//     super.initState();
//     print('User data 0 --------: $user');
//     getToken();
//     initializeAgora();
//     _updateFirestore();
//   }
//
//   @override
//   void dispose() {
//     _disposeAgora();
//     super.dispose();
//   }
//
//   Future<void> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token') ?? '';
//   }
//
//   Future<void> initializeAgora() async {
//     userName = user?.displayName;
//
//     setState(() => loading = true);
//
//     await [Permission.microphone, Permission.camera].request();
//     _engine = await createAgoraRtcEngine();
//
//     await _engine.initialize(
//       const RtcEngineContext(
//         appId: appId,
//         channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//       ),
//     );
//
//     await _engine.enableVideo();
//     await _engine.startPreview();
//
//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           if (mounted) {
//             setState(() {
//               _localUserJoined = true;
//             });
//           }
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           if (mounted) {
//             setState(() {
//               _remoteUid = remoteUid;
//             });
//           }
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           if (mounted) {
//             setState(() {
//               _remoteUid = null;
//             });
//           }
//         },
//       ),
//     );
//
//     await _engine.joinChannel(
//       token: '',
//       channelId: widget.channelName,
//       options: const ChannelMediaOptions(
//         autoSubscribeVideo: true,
//         autoSubscribeAudio: true,
//         publishCameraTrack: true,
//         publishMicrophoneTrack: true,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//       uid: 0,
//     );
//
//     if (mounted) {
//       setState(() => loading = false);
//     }
//   }
//
//
//   Future<void> _updateFirestore() async {
//     print('User data 1--------: $user');
//     if (user != null) {
//       await FirebaseFirestore.instance.collection("Liveusers").doc(user_uid).set({
//         "channelname": widget.channelName,
//         "username": userName,
//         "userid":user_uid,
//         "userimage": user?.photoURL,
//       });
//
//     }
//   }
//
//   Future<void> _disposeAgora() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//
//     try {
//       if (user != null) {
//         await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).delete();
//       }
//     } catch (e) {
//       debugPrint("Error removing user from Firestore: $e");
//     }
//
//     if (mounted) setState(() {});
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop:false,
//       onPopInvokedWithResult: (didPop, result) => _showExitDialog(),
//       child: Scaffold(
//         body: Center(
//           child: loading
//               ? const CircularProgressIndicator()
//               : Stack(
//             children: [
//               _broadcastView(),
//               if (_remoteUid != null) _remoteVideo(),
//               _toolbar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _broadcastView() {
//     return _localUserJoined
//         ? AgoraVideoView(
//       controller: VideoViewController(
//         rtcEngine: _engine,
//         canvas: const VideoCanvas(uid: 0),
//       ),
//     )
//         : const Center(child: CircularProgressIndicator());
//   }
//
//   Widget _remoteVideo() {
//     return _remoteUid != null
//         ? AgoraVideoView(
//       controller: VideoViewController.remote(
//         rtcEngine: _engine,
//         canvas: VideoCanvas(uid: _remoteUid!),
//         connection: RtcConnection(channelId: widget.channelName),
//       ),
//     )
//         : const Text(
//       'Please wait for remote user to join',
//       textAlign: TextAlign.center,
//     );
//   }
//
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       margin: const EdgeInsets.only(bottom: 30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _toolbarButton(_toggleMute, muted ? Icons.mic_off : Icons.mic, muted ? Colors.blue : Colors.white),
//           _toolbarButton(_onCallEnd, Icons.call_end, Colors.redAccent),
//           _toolbarButton(_engine.switchCamera, Icons.switch_camera, Colors.white),
//         ],
//       ),
//     );
//   }
//
//   Widget _toolbarButton(VoidCallback onPressed, IconData icon, Color color) {
//     return RawMaterialButton(
//       onPressed: onPressed,
//       shape: const CircleBorder(),
//       padding: const EdgeInsets.all(5),
//       elevation: 2.0,
//       fillColor: color,
//       child: Icon(icon, color: Colors.blue, size: 40),
//     );
//   }
//
//   void _toggleMute() {
//     setState(() => muted = !muted);
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   Future<void> _onCallEnd() async {
//     try {
//       // Leave the Agora channel
//       await _engine.leaveChannel();
//
//       // Remove user entry from Firestore if user is authenticated
//       if (user != null) {
//         await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).delete();
//       }
//
//       // Pop the current screen and go back
//       if (mounted) {
//         Get.to(const HomePageUser());
//       }
//     } catch (e) {
//       debugPrint("Error ending call: $e");
//
//       // Optional: Show an error message if needed
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error ending call: $e")),
//       );
//     }
//   }
//
//
//   Future<bool> _showExitDialog() async {
//     return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: const Text("Do you want to exit?"),
//         actions: [
//           TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("No")),
//           TextButton(
//             onPressed: () async {
//               await _onCallEnd();
//               Navigator.of(context).pop(true); // Return true to close the dialog and dispose.
//             },
//             child: const Text("Yes"),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//
