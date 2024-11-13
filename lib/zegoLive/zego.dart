import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../pages/live/live/HomePage/homepage.dart';
import 'config_zego.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;
  final String userName;
  final String userId;

  const LivePage({
    Key? key,
    required this.liveID,
    required this.isHost,
    required this.userName,
    required this.userId,
  }) : super(key: key);



  Future<bool> _onWillPop(BuildContext context) async {
    print("Stopping live stream...");

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return await _onWillPop(context);
        },
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID: ConfigZego.appId,
          appSign: ConfigZego.appSign,
          userID: userId,
          userName: userName,
          liveID: liveID,
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onLeaveConfirmation: (
              ZegoLiveStreamingLeaveConfirmationEvent event,
              Future<bool> Function() defaultAction,
            ) async {
              return await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                    title: const Text("This is your custom dialog",
                        style: TextStyle(color: Colors.white70)),
                    content: const Text(
                        "You can customize this dialog as you like",
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      ElevatedButton(
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      ElevatedButton(
                        child: const Text("Exit"),
                        onPressed: () {
                          Get.offAll(() => const HomePage());
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          config: isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
            // ..audioVideoView.foregroundBuilder =
            //     (context, size, user, extraInfo) {
            //   // Here is the full-screen mode button.
            //   return Container(
            //     child: OutlinedButton(
            //         onPressed: () {
            //           isFullscreen = !isFullscreen;
            //           ZegoUIKitPrebuiltLiveStreamingController()
            //               .screenSharing
            //               .showViewInFullscreenMode(
            //                 user?.id ?? '',
            //                 isFullscreen,
            //               ); // Call this to decide whether to
            //           // show the shared screen in full-screen mode.
            //         },
            //         child: const Text('full screen')),
            //   );
            // },
        ),
      ),
    );
  }
}
