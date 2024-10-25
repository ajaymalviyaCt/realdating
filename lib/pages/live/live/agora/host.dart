import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:get/get.dart';
import 'package:realdating/pages/live/live/HomePage/homepage.dart';
import 'package:realdating/pages/profile/profile_controller.dart';
import '../constant/constant.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'dart:math' as math;
import '../constant/heartanim.dart';

class Host extends StatefulWidget {
  final String channelName;
  final String? userId;

  const Host({Key? key, required this.channelName, required this.userId})
      : super(key: key);

  @override
  State<Host> createState() => _HostState();
}

class _HostState extends State<Host> {
  late RtcEngine _engine;
  late int streamId;
  bool muted = false;
  late AgoraRtmClient _client;
  late AgoraRtmChannel _channel;
  List messages = ["message"];
  List names = ["name"];
  List images = ["image123"];
  final ScrollController _scrollController = ScrollController();
  bool heart = false;
  final _random = math.Random();
  late Timer _timer;
  double height = 0.5;
  User? user = FirebaseAuth.instance.currentUser;
  bool loading = false;
  ProfileController profileController = Get.put(ProfileController());
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
    super.dispose();
  }

  Future<void> initializeAgora() async {
    setState(() {
      loading = true;
    });
    _engine = await RtcEngine.createWithContext(
        RtcEngineContext(appId)); //goto constant.dart file
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    streamId = (await _engine.createDataStream(false, false))!;
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (kDebugMode) {
          print("onJoinChannel: $channel, uid: $uid");
        }
      },
      leaveChannel: (stats) {
        if (kDebugMode) {
          print("channel left");
        }
      },
      userJoined: (uid, elapsed) {
        print("UserJoined: $uid");
      },
      userOffline: (uid, elapsed) {
        if (kDebugMode) {
          print("Useroffline: $uid");
        }
      },
    ));
    await _engine
        .joinChannel(null, widget.channelName, null, 0)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("Liveusers")
          .doc(user!.uid)
          .set({
        "channelname": widget.channelName,
        "username": user!.displayName,
        "userid": user!.uid,
        "userimage": user!.photoURL
      }).then((value) {
        setState(() {
          loading = false;
        });
      });
    });
  }

  void _onScrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  Future<bool> _onWillPop(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          checkExist();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("Yes"),
                      )),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Center(
          child: (loading)
              ? const CircularProgressIndicator()
              : Stack(
                  children: [
                    _broadcastView(),
                    (names.isEmpty)
                        ? Container()
                        : Container(
                            width: w,
                            height: h * 0.5,
                            margin: EdgeInsets.only(top: h * 0.5),
                            child: ListView.builder(
                                itemCount: names.length,
                                controller: _scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(profileController.profileImage.value),
                                    ),
                                    subtitle: Text(messages[index]),
                                    title: Text(names[index]),
                                  );
                                }),
                          ),
                    if (heart == true)
                      Container(
                        width: w,
                        height: h * 0.5,
                        margin: EdgeInsets.only(top: h * 0.55, left: w * 0.65),
                        child: Column(
                          children: heartPop(),
                        ),
                      ),
                    _toolbar(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              _onToggleMute();
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(5),
            elevation: 2.0,
            fillColor: (muted) ? Colors.blue : Colors.white,
            child: Icon(
              (muted) ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blue,
              size: 40,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _onCallEnd();
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(5),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 50,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _onSwitchCamera();
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(5),
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blue,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  Widget _broadcastView() {
    return const RtcLocalView.SurfaceView();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onCallEnd() {
    _engine.leaveChannel().then((value) {
      checkExist();
    });
  }

  void checkExist() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .collection("Liveusers")
          .doc(user!.uid)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      if (exist) {
        FirebaseFirestore.instance
            .collection("Liveusers")
            .doc(user!.uid)
            .delete()
            .then((value) {
          Get.offAll(() => const HomePage());
        });
      } else {
        Get.offAll(() => const HomePage());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client.logout();
      }
    };
    await _client.login(null, widget.userId!);
    _channel = await _createChannel(widget.channelName);
    await _channel.join();
    if (kDebugMode) {
      print("RTM Channel joined successfully by: ${widget.channelName}#");
    }
    _channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print("Message received: ${message.text}");
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
        if (kDebugMode) {
          print("Message received: $msg");
        }
      }
    };
  }

  Future<AgoraRtmChannel> _createChannel(String channelName) async {
    AgoraRtmChannel? channel = await _client.createChannel(channelName);
    channel!.onMemberJoined = (AgoraRtmMember member) {
      if (kDebugMode) {
        print("Member joined: ${member.userId}");
      }
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      if (kDebugMode) {
        print("Member left: ${member.userId}");
      }
    };
    return channel;
  }

  void popUp() {
    setState(() {
      heart = true;
    });
    Timer(
        const Duration(seconds: 3),
        () => {
              _timer.cancel(),
              setState(() {
                heart = false;
              })
            });
    _timer = Timer.periodic(const Duration(milliseconds: 125), (Timer t) {
      setState(() {
        height += _random.nextInt(20);
      });
    });
  }

  List<Widget> heartPop() {
    final size = MediaQuery.of(context).size;
    final hearts = <Widget>[];
    for (int i = 0; i < 10; i++) {
      final h = _random.nextInt(size.height.floor());
      final w = _random.nextInt(70) + 20;
      hearts.add(HeartAnim(
        top: h % 200.0,
        left: w.toDouble(),
        opacity: 0.5,
      ));
    }
    return hearts;
  }
}
