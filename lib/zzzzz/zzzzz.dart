import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  MyApp({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecordRealPage(cameras: cameras),
    );
  }
}

class RecordRealPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  RecordRealPage({required this.cameras});

  @override
  _RecordRealPageState createState() => _RecordRealPageState();
}

class _RecordRealPageState extends State<RecordRealPage> {
  CameraController? _cameraController;
  bool isRecording = false;
  int duration = 15; // Default duration to 15 seconds
  int remainingTime = 0;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);
    await _cameraController!.initialize();
    setState(() {});
  }

  void startCountdown(int durationInSeconds) {
    setState(() => remainingTime = durationInSeconds);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() => remainingTime--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> startRecording() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      await _cameraController!.startVideoRecording();
      setState(() {
        isRecording = true;
        remainingTime = duration;
      });

      // Start countdown timer
      startCountdown(duration);

      // Automatically stop after the selected duration
      Future.delayed(Duration(seconds: duration), () async {
        if (isRecording) await stopRecordingAndMerge();
      });
    }
  }

  Future<void> stopRecordingAndMerge() async {
    if (_cameraController != null && _cameraController!.value.isRecordingVideo) {
      final video = await _cameraController!.stopVideoRecording();
      setState(() {
        isRecording = false;
        countdownTimer?.cancel();
        remainingTime = 0;
      });

      // Merge the video with audio from URL
      const audioUrl = "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";
      final outputPath = await mergeAudioVideo(video.path, audioUrl);

      // Navigate to the preview page with the merged video
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewPage(videoPath: outputPath),
        ),
      );
    }
  }

  Future<String> mergeAudioVideo(String videoPath, String audioUrl) async {
    try {
      // Download the audio file from the URL
      final audioPath = await downloadAudio(audioUrl);

      // Output file path
      final directory = await getTemporaryDirectory();
      final outputPath = "${directory.path}/output_video.mp4";

      // FFmpeg command to merge video and audio
      final command = "-i $videoPath -i $audioPath -c:v copy -c:a aac -strict experimental $outputPath";

      // Execute FFmpeg
      await FFmpegKit.execute(command);

      print("Merged video and audio saved to: $outputPath");
      return outputPath;
    } catch (e) {
      print("Error merging video and audio: $e");
      throw e;
    }
  }

  Future<String> downloadAudio(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final filePath = "${directory.path}/audio.mp3";
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath; // Return the path of the downloaded audio file
    } else {
      throw Exception("Failed to download audio");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Record Real")),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => setState(() => duration = 15),
                    style: FilledButton.styleFrom(
                      backgroundColor: duration == 15 ? Colors.blue : Colors.grey,
                    ),
                    child: const Text("15 sec"),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () => setState(() => duration = 30),
                    style: FilledButton.styleFrom(
                      backgroundColor: duration == 30 ? Colors.blue : Colors.grey,
                    ),
                    child: const Text("30 sec"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              isRecording
                  ? FilledButton(
                      onPressed: stopRecordingAndMerge,
                      child: const Text("Stop"),
                    )
                  : FilledButton(
                      onPressed: startRecording,
                      child: const Text("Record"),
                    ),
            ],
          ),
          if (isRecording && remainingTime > 0)
            Center(
              child: Text(
                "$remainingTime",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class VideoPreviewPage extends StatefulWidget {
  final String videoPath;

  VideoPreviewPage({required this.videoPath});

  @override
  _VideoPreviewPageState createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Video")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
