import 'dart:async';
import 'dart:math' as math;

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';

import '../HomePage/homepage.dart';
import '../constant/constant.dart';
import '../constant/heartanim.dart';

class Audience extends StatefulWidget {
  final String channelName;
  final String userId;

  const Audience({Key? key, required this.channelName, required this.userId}) : super(key: key);

  @override
  State<Audience> createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  late RtcEngine _engine;
  late AgoraRtmClient _client;
  late AgoraRtmChannel _channel;

  final List<int> _users = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> messages = ["first message"];
  final List<String> names = ["Muhammad"];
  final List<String> images = ["image123"];

  bool heart = false;
  final math.Random _random = math.Random();
  late Timer _timer;
  double height = 0.5;

  @override
  void initState() {
    super.initState();
    initializeAgora();
    _createClient();
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.destroy();
    _timer.cancel();
    super.dispose();
  }

  Future<void> initializeAgora() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));



    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Audience);

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (kDebugMode) {
          print("Joined Channel: $channel, uid: $uid");
        }
      },
      leaveChannel: (stats) {
        if (kDebugMode) {
          print("Channel left");
        }
        setState(() {
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        if (kDebugMode) {
          print("User Joined: $uid");
        }
        setState(() {
          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        if (kDebugMode) {
          print("User Offline: $uid");
        }
        setState(() {
          _users.remove(uid);
        });
      },
    ));

    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  void _onScrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _broadcastView(),
          leaveChannelText(),
          names.isEmpty
              ? Container()
              : Container(
            width: w,
            height: h * 0.5,
            margin: EdgeInsets.only(top: h * 0.5, bottom: h * 0.09),
            child: ListView.builder(
              itemCount: names.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(images[index]),
                  ),
                  subtitle: Text(messages[index]),
                  title: Text(names[index]),
                );
              },
            ),
          ),
          sendTextfield(),
          if (heart)
            Container(
              width: w,
              height: h * 0.5,
              margin: EdgeInsets.only(top: h * 0.55, left: w * 0.65),
              child: Column(
                children: heartPop(),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _getRenderViews() {
    return _users.map((uid) => RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName)).toList();
  }

  Widget _broadcastView() {
    final views = _getRenderViews();
    return Column(
      children: views.map((view) => Expanded(child: view)).toList(),
    );
  }

  Widget leaveChannelText() {
    return InkWell(
      onTap: _onCallEnd,
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 20),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20),
          color: Colors.redAccent,
        ),
        child: const Text(
          "Leave",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void _onCallEnd() {
    _engine.leaveChannel().then((_) {
      Get.to(() => const HomePage());
    });
  }

  Widget sendTextfield() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    String imgLink = "https://firebasestorage.googleapis.com/v0/b/mooapp...";
                    String msg = "${_controller.text.trim()}passWORD123$imgLink";
                    _sendMessage(msg);
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.blueAccent),
                ),
                hintText: "Comment",
                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              await _channel.sendMessage(AgoraRtmMessage.fromText("a1w3e3rt4YRTY"));
              popUp();
            },
            child: const Icon(Icons.favorite, color: Colors.lightBlueAccent, size: 30),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    String img = text.split("passWORD123").last;
    String msg = text.split("passWORD123").first;
    setState(() {
      names.add(widget.userId);
      messages.add(msg);
      images.add(img);
    });
    _onScrollDown();
    await _channel.sendMessage(AgoraRtmMessage.fromText(text));
    _controller.clear();
  }

  Future<void> _createClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client.logout();
      }
    };
    await _client.login(null, widget.userId);
    _channel = await _createChannel(widget.channelName);
    await _channel.join();
    _channel.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) {
      if (message.text.contains("a1w3e3rt4YRTY")) {
        popUp();
      } else {
        String img = message.text.split("passWORD123").last;
        String msg = message.text.split("passWORD123").first;
        setState(() {
          names.add(member.userId);
          messages.add(msg);
          images.add(img);
        });
        _onScrollDown();
      }
    };
  }

  Future<AgoraRtmChannel> _createChannel(String channelName) async {
    AgoraRtmChannel? channel = await _client.createChannel(channelName);
    channel!.onMemberJoined = (AgoraRtmMember member) {
      if (kDebugMode) print("Member joined: ${member.userId}");
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      if (kDebugMode) print("Member left: ${member.userId}");
    };
    return channel;
  }

  void popUp() {
    setState(() {
      heart = true;
    });
    Timer(const Duration(seconds: 3), () {
      _timer.cancel();
      setState(() {
        heart = false;
      });
    });
    _timer = Timer.periodic(const Duration(milliseconds: 125), (Timer t) {
      setState(() {
        height += _random.nextInt(20);
      });
    });
  }

  List<Widget> heartPop() {
    final size = MediaQuery.of(context).size;
    return List<Widget>.generate(10, (i) {
      final h = _random.nextInt(size.height.floor());
      final w = _random.nextInt(70) + 20;
      return HeartAnim(top: h % 200.0, left: w.toDouble(), opacity: 0.5);
    });
  }
}
