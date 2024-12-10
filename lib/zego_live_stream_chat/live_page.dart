// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import '../reel/common_import.dart';

import 'constatent.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String userName;
  final String userId;
  final String? image;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.userId,
    required this.userName,
    this.image
  });

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
        onPopInvoked: (result) async {
          if (widget.isHost) {
            await _endLiveSession();
          }
          return;
        },
        child: ZegoUIKitPrebuiltLiveStreaming(
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onEnded: (event, defaultAction) {
              if (widget.isHost == false) {
                _showLiveEndedPopup();
              } else {
                Get.back();
              }
              print("line 65");
            },
          ),
          appID: 426171095,
          appSign: '02d978a9a7bda152641751dd6629f656e5c7412f238903b87b36155f0fd3474f',
          userID: localUserID,
          userName: widget.userName,
          liveID: widget.liveID,
          config: (widget.isHost ? ZegoUIKitPrebuiltLiveStreamingConfig.host() : ZegoUIKitPrebuiltLiveStreamingConfig.audience())

        ),
      ),
    );
  }
}


void _showLiveEndedPopup() {
  Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Live Stream Ended',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Thank you for watching! The live stream has ended. Please check back later for more content.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('Close'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //    Get.back();
            //    Get.back();
            //     // Add any additional actions here
            //   },
            //   child: const Text('Go to Home'),
            // ),
          ],
        ),
      ));
}


// ..avatarBuilder = (context, size, user, extraInfo) {
// if (widget.isHost || !widget.isHost) {
// return null;
// }
// return null;
// },