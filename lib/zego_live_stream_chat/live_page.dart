// Flutter imports:
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'common.dart';


class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String userName;
  final String userId;

  const LivePage({
    Key? key,
    required this.liveID,
    required this.userName,
    required this.userId,
    this.isHost = false,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 426171095,
        appSign: '02d978a9a7bda152641751dd6629f656e5c7412f238903b87b36155f0fd3474f' /*input your AppSign*/,
        userID: widget.userId,
        userName: 'user_${widget.userName}',
        liveID: widget.liveID,
        config: (widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
          ..avatarBuilder = customAvatarBuilder,
      ),
    );
  }
}