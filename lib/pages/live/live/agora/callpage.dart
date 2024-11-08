import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:get/get.dart';
import '../HomePage/homepage.dart';
import '../constant/constant.dart';

class Call extends StatefulWidget {
  final String channelName;

  const Call({Key? key, required this.channelName}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  late RtcEngine _engine;
  late int streamId;
  bool muted = false;
  bool loading = false;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    setState(() {
      loading = true;
    });

    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId)); // Reference appId in constant.dart
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);

    streamId = (await _engine.createDataStream(false, false))!;

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (kDebugMode) {
          print("onJoinChannel: $channel, uid: $uid");
        }
      },
      userJoined: (uid, elapsed) {
        if (kDebugMode) {
          print("UserJoined: $uid");
        }
        setState(() {
          _remoteUid = uid;
        });
      },
      userOffline: (uid, elapsed) {
        if (kDebugMode) {
          print("UserOffline: $uid");
        }
        setState(() {
          _remoteUid = 0;
        });
      },
    ));

    await _engine.joinChannel(null, widget.channelName, null, 0);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: _renderRemoteView()),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 130,
                margin: const EdgeInsets.only(left: 15, top: 15),
                child: _renderLocalView(),
              ),
            ),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _renderLocalView() {
    return const RtcLocalView.SurfaceView();
  }

  Widget _renderRemoteView() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: widget.channelName,
      );
    } else {
      return const Center(child: Text("Waiting for other user to join"));
    }
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _toolbarButton(
            onPressed: _onToggleMute,
            icon: muted ? Icons.mic_off : Icons.mic,
            color: muted ? Colors.blue : Colors.white,
            iconColor: muted ? Colors.white : Colors.blue,
          ),
          _toolbarButton(
            onPressed: _onCallEnd,
            icon: Icons.call_end,
            color: Colors.redAccent,
            iconColor: Colors.white,
            iconSize: 50,
          ),
          _toolbarButton(
            onPressed: _onSwitchCamera,
            icon: Icons.switch_camera,
            color: Colors.white,
            iconColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _toolbarButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    Color iconColor = Colors.blue,
    double iconSize = 40,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(5),
      elevation: 2.0,
      fillColor: color,
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onCallEnd() {
    _engine.leaveChannel().then((_) {
      Get.offAll(() => const HomePage());
    });
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }
}
