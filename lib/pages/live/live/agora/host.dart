import 'dart:async';
import 'dart:math' as math;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/live/live/HomePage/homepage.dart';
import 'package:realdating/pages/profile/profile_controller.dart';

import '../constant/constant.dart';
import '../constant/heartanim.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;

class Host extends StatefulWidget {
  final String channelName;
  final String? userId;

  const Host({Key? key, required this.channelName, required this.userId}) : super(key: key);

  @override
  State<Host> createState() => _HostState();
}

class _HostState extends State<Host> {





  RtcEngine? _engine;
  late AgoraRtmClient _client;
  late AgoraRtmChannel _channel;
  final ProfileController profileController = Get.put(ProfileController());
  final ScrollController _scrollController = ScrollController();
  final _random = math.Random();

  bool muted = false;
  bool loading = false;
  bool heart = false;
  List<String> messages = ["message"];
  List<String> names = ["name"];
  List<String> images = ["image123"];
  double heartAnimationHeight = 0.5;
  int? streamId;
  User? user = FirebaseAuth.instance.currentUser;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initializeAgora();
    initializeRtmClient();
  }

  @override
  void dispose() {
    _engine?.leaveChannel();
    _engine?.destroy();
    super.dispose();
  }

  Future<void> initializeAgora() async {
    setState(() => loading = true);

    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    await _engine?.enableVideo();
    await _engine?.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine?.setClientRole(ClientRole.Broadcaster);

    streamId = await _engine?.createDataStream(false, false);
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (kDebugMode) print("onJoinChannel: $channel, uid: $uid");
      },
      leaveChannel: (stats) {
        if (kDebugMode) print("channel left");
      },
      userJoined: (uid, elapsed) {
        if (kDebugMode) print("UserJoined: $uid");
      },
      userOffline: (uid, elapsed) {
        if (kDebugMode) print("Useroffline: $uid");
      },
    ));

    await _engine?.joinChannel(null, widget.channelName, null, 0);
    await _updateFirestore();
  }

  Future<void> _updateFirestore() async {
    await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).set({
      "channelname": widget.channelName,
      "username": user!.displayName,
      "userid": user!.uid,
      "userimage": user!.photoURL,

    });

    setState(() => loading = false);
  }

  Future<void> initializeRtmClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged = (state, reason) {
      if (state == 5) _client.logout();
    };

    await _client.login(null, widget.userId!);
    _channel = (await _client.createChannel(widget.channelName))!;
    await _channel.join();

    _channel.onMessageReceived = (message, member) {
      if (message.text.contains("a1w3e3rt4YRTY")) {
        _triggerHeartAnimation();
      } else {
        _handleMessage(message.text, member.userId);
      }
    };

    if (kDebugMode) print("RTM Channel joined successfully by: ${widget.channelName}");
  }

  void _handleMessage(String message, String userId) {
    final messageParts = message.split("passWORD123");
    setState(() {
      names.add(userId);
      messages.add(messageParts[0]);
      images.add(messageParts[1]);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<bool> _showExitDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Do you want to exit?"),
              const SizedBox(height: 20),
              Row(
                children: [
                  _exitDialogButton("Yes", Colors.red, _onCallEnd),
                  _exitDialogButton("No", Colors.white, Get.back),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _exitDialogButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(label, style: TextStyle(color: color == Colors.white ? Colors.black87 : Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitDialog(),
      child: Scaffold(
        body: Center(
          child:
          // loading
          //     ? const CircularProgressIndicator()
          //     :
          Stack(
            children: [
              _broadcastView(),
              if (names.isNotEmpty) _messageListView(),
              if (heart) _heartAnimation(),
              _toolbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _broadcastView() {
    return const RtcLocalView.SurfaceView();
  }

  Widget _messageListView() {
    return Container(
      margin: const EdgeInsets.only(top: 0.5),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profileController.profileImage.value),
            ),
            title: Text(names[index]),
            subtitle: Text(messages[index]),
          );
        },
      ),
    );
  }

  Widget _heartAnimation() {
    final size = MediaQuery.of(context).size;
    final hearts = List.generate(10, (_) => HeartAnim(
      top: _random.nextInt(size.height.floor()).toDouble() % 200,
      left: (_random.nextInt(70) + 20).toDouble(),
      opacity: 0.5,
    ));
    return Container(
      margin: EdgeInsets.only(top: 0.55, left: 0.65),
      child: Column(children: hearts),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _toolbarButton(_toggleMute, muted ? Icons.mic_off : Icons.mic, muted ? Colors.blue : Colors.white),
          _toolbarButton(_onCallEnd, Icons.call_end, Colors.redAccent),
          _toolbarButton(_engine!.switchCamera, Icons.switch_camera, Colors.white),
        ],
      ),
    );
  }

  Widget _toolbarButton(VoidCallback onPressed, IconData icon, Color color) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(5),
      elevation: 2.0,
      fillColor: color,
      child: Icon(icon, color: Colors.blue, size: 40),
    );
  }

  void _toggleMute() {
    setState(() => muted = !muted);
    _engine?.muteLocalAudioStream(muted);
  }

  Future<void> _onCallEnd() async {
    await _engine?.leaveChannel();
    await _checkUserExistence();
  }

  Future<void> _checkUserExistence() async {
    final doc = await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).get();
    if (doc.exists) {
      await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).delete();
    }
    Get.offAll(() => const HomePage());
  }

  void _triggerHeartAnimation() {
    setState(() => heart = true);
    _timer = Timer.periodic(const Duration(milliseconds: 125), (_) {
      setState(() => heartAnimationHeight += _random.nextInt(20));
    });
    Timer(const Duration(seconds: 3), () {
      _timer.cancel();
      setState(() => heart = false);
    });
  }
}
