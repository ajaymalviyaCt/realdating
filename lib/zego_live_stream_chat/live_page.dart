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
  final String userName;
  final String userId;
  final String? image;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
    required this.userId,
    required this.userName,
    this.image,
  });

  @override
  State<StatefulWidget> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('Profile Image: ${widget.image}');
  }

  Future<void> removeAllLiveUsers() async {
    try {
      final liveUsersSnapshot =
      await FirebaseFirestore.instance.collection("Liveusers").get();

      for (var doc in liveUsersSnapshot.docs) {
        await doc.reference.delete();
      }
      debugPrint("All live user data removed successfully.");
    } catch (e) {
      debugPrint("Error removing live users: $e");
    }
  }

  Future<void> _endLiveSession() async {
    await removeAllLiveUsers();
  }

  @override
  void dispose() {
    if (widget.isHost) {
      _endLiveSession();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreamingMiniPopScope(
        onPopInvoked: (result) async {
          if (widget.isHost) {
            await _endLiveSession();
          }
        },
        child: ZegoUIKitPrebuiltLiveStreaming(
          events: ZegoUIKitPrebuiltLiveStreamingEvents(
            onEnded: (event, defaultAction) {
              if (!widget.isHost) {
                _showLiveEndedPopup();
              } else {
                Get.back();
              }
            },
          ),
          appID: 426171095,
          appSign:
          '02d978a9a7bda152641751dd6629f656e5c7412f238903b87b36155f0fd3474f', // Replace with your AppSign
          userID: widget.userId,
          userName: widget.userName,
          liveID: widget.liveID,
          config: (widget.isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
            ..avatarBuilder = (context, size, user, extraInfo) {
              extraInfo['isHost'] = widget.isHost;
              extraInfo['hostImage'] = widget.image;
              return customUserPhotoBuilder(context, size, user, extraInfo);
            },
        ),
      ),
    );
  }

  void _showLiveEndedPopup() {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
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
                Get.back(); // Close the dialog
                Get.back(); // Navigate back
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

CachedNetworkImage customUserPhotoBuilder(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
    ) {
  final isHost = extraInfo['isHost'] ?? false;
  final imageUrl = isHost
      ? extraInfo['hostImage']
      : (extraInfo['profileImage'] ?? 'https://robohash.org/${user?.id}.png');

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
      return ZegoAvatar(user: user, avatarSize: size);
    },
  );
}



