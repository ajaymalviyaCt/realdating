import 'package:flutter/material.dart';
import 'package:realdating/pages/video_screen/video_controller.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/video_screen/video_player_iten.dart';

import '../../consts/app_colors.dart';
import '../../widgets/custom_text_styles.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    videoController.watchReels();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              print("Go back");
              // Get.back();
              Navigator.pop(context);
              // Get.to(() => const DashboardPage());
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: const Color(0xFFE8E6EA),
                  // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                  width: 1.0, // Border width
                ),
                color: const Color(0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
              ),
              child: const Icon(Icons.arrow_back_ios_outlined, color: colors.primary, size: 18),
            ),
          ),
          title: customTextCommon(
            text: 'Watch Reels',
            fSize: 24,
            fWeight: FontWeight.w600,
            lineHeight: 24,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await videoController.watchReels();
          },
          child: Obx(() => videoController.isLoadig.value
              ? const Center(child: CircularProgressIndicator())
              : videoController.reels.isNotEmpty
                  ? PageView.builder(
                      itemCount: videoController.reels.length,
                      controller: PageController(initialPage: 0, viewportFraction: 1),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Scaffold(
                            body: RefreshIndicator(
                          onRefresh: () async {
                            await videoController.watchReels();
                            videoController.refresh();
                          },
                          child: Obx(() => videoController.isLoadig.value
                              ? const Center(child: CircularProgressIndicator())
                              : videoController.reels.isNotEmpty
                                  ? PageView.builder(
                                      itemCount: videoController.reels.length,
                                      controller: PageController(initialPage: 0, viewportFraction: 1),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Scaffold(
                                            body: Center(
                                          child: Stack(
                                            children: [
                                              VideoPlayerItem(videoUrl: "${videoController.reels[index].reel}"),
                                              Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 65.0, left: 15),
                                                    child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                                      child: Text(
                                                        videoController.getReelModel?.reels[index].userInfo[0].firstName ?? "UserName",
                                                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                                      ),
                                                    ),
                                                  )),
                                              Positioned(
                                                left: 15,
                                                right: 0,
                                                bottom: 10,
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                                  child: Text(
                                                    videoController.getReelModel?.reels[index].caption ?? "Not Found",
                                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                      },
                                    )
                                  : const Center(child: Text("No Reels Found !!"))),
                        ));
                      },
                    )
                  : const Center(child: Text("No Reels Found !!"))),
        ));
  }
}
