// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import '../reel/common_import.dart';
import 'common.dart';
import 'constatent.dart';

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;
  final String userNmae;
  final String userId;
  final String? image;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.userId,
    required this.userNmae,
    this.image
  });

  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print('profile------------_>${widget.image}');

  }

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
          appSign: '02d978a9a7bda152641751dd6629f656e5c7412f238903b87b36155f0fd3474f' /*input your AppSign*/,
          userID: localUserID,
          userName: widget.userNmae,
          liveID: widget.liveID,
          config: (widget.isHost ? ZegoUIKitPrebuiltLiveStreamingConfig.host() : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
            ..avatarBuilder = (context, size, user, extraInfo) {
              extraInfo['isHost'] = widget.isHost;
              extraInfo['hostImage'] = widget.image; // Pass the host's image
              return customUserPhotoBuilder(context, size, user, extraInfo);
            },

        ),
      ),
    );
  }
}




CachedNetworkImage customUserPhotoBuilder(
    BuildContext context,
    Size size,
    ZegoUIKitUser ? user,
    Map<String, dynamic> extraInfo,
    ) {
  // Check if the user is the host
  final isHost = extraInfo['isHost'] ?? false;
  final imageUrl = isHost ? extraInfo['hostImage'] : (extraInfo['profileImage'] ?? 'https://robohash.org/${user?.id}.png');

  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) {
      return ZegoAvatar(user: user, avatarSize: size); // Default avatar fallback
    },
  );
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


