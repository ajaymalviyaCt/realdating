import 'dart:io';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:realdating/consts/app_colors.dart';
import 'package:realdating/reel/common_import.dart';

import 'audio_tile.dart';
import 'create_reel_controller.dart';
import 'crop_audio_screen.dart';

class SelectMusic extends StatefulWidget {
  final int duration;
  final Function(File, ReelMusicModel) selectedAudioCallback;

  const SelectMusic({super.key, required this.selectedAudioCallback, required this.duration});

  @override
  State<SelectMusic> createState() => _SelectMusicState();
}

class _SelectMusicState extends State<SelectMusic> {
  final CreateReelController _createReelController = Get.find();
  final PlayerManager _playerManager = Get.find();

  @override
  void initState() {
    super.initState();
    _createReelController.getReelCategories();
  }

  @override
  void didUpdateWidget(covariant SelectMusic oldWidget) {

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _createReelController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: KeyboardDismissOnTap(
          child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              const ThemeIconWidget(
                ThemeIcon.backArrow,
                size: 25,
              ).ripple(() {
                Get.back();
              }),
              const Spacer(),
              segmentView(),
              const Spacer(),
              const SizedBox(
                width: 25,
              )
            ],
          ).setPadding(left: DesignConstants.horizontalPadding, right: DesignConstants.horizontalPadding, top: 25, bottom: 0),
          GetBuilder<CreateReelController>(
              init: _createReelController,
              builder: (ctx) {
                return Expanded(
                  child: Column(
                    children: [
                      // const SizedBox(height: 20),
                      // segmentView(),
                      divider(height: 0.2).tP25,
                      musicListView()
                      // searchedResult(segment: exploreController.selectedSegment),
                    ],
                  ),
                );
              })
        ],
      )),
    );
  }

  Widget segmentView() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: colors.primary),
      child: const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: Text(
          "All Songs",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget musicListView() {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!_createReelController.isLoadingAudios.value) {
          // _createReelController.getReelAudios();
        }
      }
    });

    return _createReelController.isLoadingAudios.value
        ? Expanded(child: const ShimmerUsers().hp(DesignConstants.horizontalPadding))
        : _createReelController.audios.isNotEmpty
        ? Expanded(
      child: ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(top: 20, bottom: 50, left: DesignConstants.horizontalPadding, right: DesignConstants.horizontalPadding),
          itemCount: _createReelController.audios.length,
          itemBuilder: (BuildContext ctx, int index) {
            ReelMusicModel audio = _createReelController.audios[index];
            return Obx(() {
              return AudioTile(
                audio: audio,
                isPlaying: _playerManager.currentlyPlayingAudio.value?.id == audio.id.toString(),
                playCallBack: () {
                  _createReelController.playAudio(audio);
                },
                stopBack: () {
                  _createReelController.stopPlayingAudio();
                },
                useAudioBack: () {
                  if (_createReelController.recordingLength.value > audio.duration) {
                    AppUtil.showToast(message: 'Audio is shorter than ${_createReelController.recordingLength}seconds', isSuccess: false);
                    return;
                  }
                  openCropAudio(audio);
                },
              );
            });
          },
          separatorBuilder: (BuildContext ctx, int index) {
            return const SizedBox(
              height: 20,
            );
          }),
    )
        : emptyData(
      title: noAudioFound.tr,
      subTitle: searchAnotherAudio.tr,
    );
  }

  void openCropAudio(ReelMusicModel audio) async {
    print('reel duration---------------${widget.duration}');
    _createReelController.selectReelAudio(audio);
    File audioFile = await Get.bottomSheet(FractionallySizedBox(
        heightFactor: 0.7,
        child: CropAudioScreen(
          reelMusicModel: audio,
          duration: widget.duration,
        )));
    print('audioFile $audioFile');
    widget.selectedAudioCallback(audioFile, audio);
    Get.back();
  }
}


