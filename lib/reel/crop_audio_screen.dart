

import 'package:just_audio/just_audio.dart';

import 'common_import.dart';
import 'create_reel_controller.dart';

class CropAudioScreen extends StatefulWidget {
  final ReelMusicModel reelMusicModel;
  final int duration;

  const CropAudioScreen({super.key, required this.reelMusicModel, required this.duration});

  @override
  State<StatefulWidget> createState() {
    return _CropAudioState();
  }
}

class _CropAudioState extends State<CropAudioScreen> {
  final CreateReelController _createReelController = Get.find();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  final double maxTrimDuration = 30.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAudioFileUntil(
        widget.reelMusicModel,
        _createReelController.audioStartTime ?? 0,
        _createReelController.audioEndTime ?? widget.duration.toDouble(),
      );
    });

    _createReelController.setAudioCropperTime(0, widget.duration.toDouble());

    _audioPlayer.positionStream.listen((Duration position) {
      setState(() {
        currentPosition = position;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudioFileUntil(ReelMusicModel model, double startTime, double endTime) async {
    await _audioPlayer.setUrl(model.url); // Assuming audioUrl is a property in ReelMusicModel
    _audioPlayer.seek(Duration(seconds: startTime.toInt()));
    _audioPlayer.play();
    await Future.delayed(Duration(seconds: (endTime - startTime).toInt()));
    _audioPlayer.pause();
  }

  Future<void> _playTrimmedAudio(double startTime, double endTime) async {
    if ((endTime - startTime) > maxTrimDuration) {
      endTime = startTime + maxTrimDuration;
    }
    await _audioPlayer.setUrl(widget.reelMusicModel.url);
    await _audioPlayer.seek(Duration(seconds: startTime.toInt()));
    _audioPlayer.play();
    await Future.delayed(Duration(seconds: (endTime - startTime).toInt()));
    _audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(children: [
        Row(
          children: [
            const ThemeIconWidget(
              ThemeIcon.backArrow,
              size: 25,
            ).ripple(() {
              _audioPlayer.stop();
              Get.back();
            }),
            const SizedBox(width: 10),
          ],
        ).setPadding(left: DesignConstants.horizontalPadding, right: DesignConstants.horizontalPadding, top:5, bottom:0),
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              const Text('Start Time', style: TextStyle(color: Colors.white)),
              Slider(
                value: _createReelController.audioStartTime!.toDouble(),
                min: 0,
                max: widget.reelMusicModel.duration.toDouble(),
                onChanged: (value) {
                  double endTime = _createReelController.audioEndTime!.toDouble();
                  if (value >= endTime) {
                    endTime = value + 1;
                  }
                  if ((endTime - value) > maxTrimDuration) {
                    endTime = value + maxTrimDuration;
                  }
                  setState(() {
                    _createReelController.audioStartTime = value;
                    _createReelController.audioEndTime = endTime;
                    _playTrimmedAudio(value, endTime);
                  });
                },
              ),
              const Text('End Time', style: TextStyle(color: Colors.white)),
              Slider(
                value: _createReelController.audioEndTime!.toDouble(),
                min: 0,
                max: widget.reelMusicModel.duration.toDouble(),
                onChanged: (value) {
                  double startTime = _createReelController.audioStartTime!.toDouble();
                  if (value <= startTime) {
                    startTime = value - 1;
                  }
                  if ((value - startTime) > maxTrimDuration) {
                    startTime = value - maxTrimDuration;
                  }
                  setState(() {
                    _createReelController.audioEndTime = value;
                    _createReelController.audioStartTime = startTime;
                    _playTrimmedAudio(startTime, value);
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('Current Position: ${currentPosition.inSeconds} seconds', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            color: AppColorConstants.red,
            child: const Text('Trim Audio',style: TextStyle(color: Colors.white),).p8,
          ).circular.ripple(() {
            _createReelController.trimAudio();
          }),
        ),
      ]),
    );
  }
}








