// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../HomePage/homepage.dart';
// import '../constant/constant.dart';
//
// class Call extends StatefulWidget {
//   final String channelName;
//
//   const Call({Key? key, required this.channelName}) : super(key: key);
//
//   @override
//   State<Call> createState() => _CallState();
// }
//
// class _CallState extends State<Call> {
//   late RtcEngine _engine;
//   late int streamId;
//   bool muted = false;
//   bool loading = false;
//   int _remoteUid = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     initializeAgora();
//   }
//
//   Future<void> initializeAgora() async {
//     setState(() {
//       loading = true;
//     });
//
//     // Create and initialize the Agora engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileCommunication,
//     ));
//
//     // Enable video
//     await _engine.enableVideo();
//
//     // Create a data stream
//     streamId = (await _engine.createDataStream(
//       const DataStreamConfig(),
//     ));
//
//     // Register event handlers
//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         print("onJoinChannel: ${connection.channelId}, uid: ${connection.localUid}");
//       },
//       onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//         print("UserJoined: $uid");
//         setState(() {
//           _remoteUid = uid;
//         });
//       },
//       onUserOffline: (RtcConnection connection, int uid, UserOfflineReasonType reason) {
//         print("UserOffline: $uid");
//         setState(() {
//           _remoteUid = 0;
//         });
//       },
//     ));
//
//     // Join the channel
//     await _engine.joinChannel(
//       token: '', // Add your token if required
//       channelId: widget.channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Center(child: _renderRemoteView()),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 100,
//                 height: 130,
//                 margin: const EdgeInsets.only(left: 15, top: 15),
//                 child: _renderLocalView(),
//               ),
//             ),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _renderLocalView() {
//     return AgoraVideoView(
//       controller: VideoViewController(
//         rtcEngine: _engine,
//         canvas: const VideoCanvas(uid: 0),
//       ),
//     );
//   }
//
//   Widget _renderRemoteView() {
//     if (_remoteUid != 0) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: RtcConnection(channelId: widget.channelName),
//         ),
//       );
//     } else {
//       return const Center(child: Text("Waiting for other user to join"));
//     }
//   }
//
//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       margin: const EdgeInsets.only(bottom: 30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _toolbarButton(
//             onPressed: _onToggleMute,
//             icon: muted ? Icons.mic_off : Icons.mic,
//             color: muted ? Colors.blue : Colors.white,
//             iconColor: muted ? Colors.white : Colors.blue,
//           ),
//           _toolbarButton(
//             onPressed: _onCallEnd,
//             icon: Icons.call_end,
//             color: Colors.redAccent,
//             iconColor: Colors.white,
//             iconSize: 50,
//           ),
//           _toolbarButton(
//             onPressed: _onSwitchCamera,
//             icon: Icons.switch_camera,
//             color: Colors.white,
//             iconColor: Colors.blue,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _toolbarButton({
//     required VoidCallback onPressed,
//     required IconData icon,
//     required Color color,
//     Color iconColor = Colors.blue,
//     double iconSize = 40,
//   }) {
//     return RawMaterialButton(
//       onPressed: onPressed,
//       shape: const CircleBorder(),
//       padding: const EdgeInsets.all(5),
//       elevation: 2.0,
//       fillColor: color,
//       child: Icon(icon, color: iconColor, size: iconSize),
//     );
//   }
//
//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }
//
//   void _onCallEnd() {
//     _engine.leaveChannel().then((_) {
//       Get.offAll(() => const HomePage());
//     });
//   }
//
//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }
//
//   @override
//   void dispose() {
//     _engine.leaveChannel();
//     _engine.release();
//     super.dispose();
//   }
// }
