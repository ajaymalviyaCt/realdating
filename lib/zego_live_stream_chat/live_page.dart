// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'common.dart';
import 'constatent.dart';


class LivePage extends StatefulWidget {

  final String liveID;
  final bool isHost;
  final String userNmae;
  final String userId;

  const LivePage({
    Key? key,
    required this.liveID,
    this.isHost = false,
    required this.userId,
    required this.userNmae,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {

  Future<void> removeAllLiveUsers() async {
    try {

      final liveUsersSnapshot = await FirebaseFirestore.instance.collection("Liveusers").get();


      for (var doc in liveUsersSnapshot.docs) {
        await doc.reference.delete();
      }
      print("All live user data removed successfully.");
    } catch (e) {
      print("Error removing live users: $e");
    }
  }

  @override
  void dispose() {
    if (widget.isHost) {
      _endLiveSession();
    }
    super.dispose();
  }

  Future<void> _endLiveSession() async {
    await removeAllLiveUsers();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreamingMiniPopScope(
        onPopInvoked:(result) async {
    if (widget.isHost) {

    await _endLiveSession();
    }
    return;
    },
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID: 426171095,
          appSign: '02d978a9a7bda152641751dd6629f656e5c7412f238903b87b36155f0fd3474f' /*input your AppSign*/,
          userID: localUserID,
          userName: widget.userNmae,
          liveID: widget.liveID,
          config: (widget.isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
            ..avatarBuilder = customAvatarBuilder,
        ),
      ),
    );
  }
}