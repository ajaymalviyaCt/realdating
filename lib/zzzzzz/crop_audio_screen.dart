import 'package:realdating/zzzzzz/common_import.dart';
import 'package:realdating/zzzzzz/wave_slider.dart';

import '../reel/reel_music_model.dart';
import 'colors_file.dart';
import 'create_reel_controller.dart';

class CropAudioScreen extends StatefulWidget {
  final ReelMusicModel reelMusicModel;

  const CropAudioScreen({Key? key, required this.reelMusicModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CropAudioState();
  }
}

class _CropAudioState extends State<CropAudioScreen> {
  final CreateReelController _createReelController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createReelController.playAudioFileUntil(widget.reelMusicModel, _createReelController.audioStartTime ?? 0, _createReelController.audioEndTime ?? 0);
    });

    super.initState();
  }

  @override
  void dispose() {
    _createReelController.stopPlayingAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(children: [
        Row(
          children: [
            ThemeIconWidget(
              ThemeIcon.backArrow,
              size: 25,
            ).ripple(() {
              _createReelController.stopPlayingAudio();
              Get.back();
            }),
            const SizedBox(
              width: 10,
            ),
          ],
        ).setPadding(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Obx(
            () => SizedBox(
              height: 80,
              width: Get.width * 0.8,
              child: WaveSlider(
                positionTextColor: AppColorConstants.themeColor,
                backgroundColor: Colors.transparent,
                heightWaveSlider: 30,
                widthWaveSlider: Get.width * 0.8,
                sliderColor: Colors.cyan,
                duration: widget.reelMusicModel.duration.toDouble(),
                cutterDuration: _createReelController.recordingLength.toDouble(),
                callbackEnd: (startDuration, endDuration) {
                  debugPrint("Start $startDuration End  $endDuration");
                  _createReelController.setAudioCropperTime(startDuration, endDuration);
                  // this.startDuration = startDuration;
                  // this.endDuration = endDuration;
                  _createReelController.stopPlayingAudio();
                  _createReelController.playAudioFileUntil(widget.reelMusicModel, startDuration, endDuration);
                },
                callbackStart: (double duration, double endDuration) {},
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: Container(
            height: 40,
                  width:60,
                  color: AppColorConstants.themeColor,
                  child: Center(
                    child: Text(
                      "Use",
                      style: TextStyle(fontSize: FontSizes.b2,color: Colors.white),
                    ).p8,
                  ))
              .circular
              .ripple(() {
            _createReelController.trimAudio();
          }),
        )
      ]),
    );
  }
}
