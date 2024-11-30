import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isCameraInitialized = false;
  bool isRecording = false;

  int selectedCameraIndex = 1;

  @override
  void initState() {
    super.initState();
    initializeCamera(selectedCameraIndex);
  }

  Future<void> initializeCamera(int cameraIndex) async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[cameraIndex],
          ResolutionPreset.high,
        );
        await cameraController.initialize();
        setState(() {
          isCameraInitialized = true;
        });
      } else {
        print("No cameras available");
      }
    } catch (e) {
      print("Camera initialization error: $e");
    }
  }

  void switchCamera() async {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    await cameraController.dispose();
    initializeCamera(selectedCameraIndex);
  }

  void startRecording() async {
    if (!cameraController.value.isRecordingVideo) {
      try {
        await cameraController.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      } catch (e) {
        print("Error starting video recording: $e");
      }
    }
  }

  void stopRecording() async {
    if (cameraController.value.isRecordingVideo) {
      try {
        final file = await cameraController.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        print('Video recorded to: ${file.path}');
      } catch (e) {
        print("Error stopping video recording: $e");
      }
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: switchCamera,
          ),
        ],
      ),
      body: isCameraInitialized
          ? Stack(
              children: [
                Transform(alignment: Alignment.topCenter, transform: Matrix4.rotationY(GetPlatform.isAndroid ? pi : 0), child: CameraPreview(cameraController)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Start/Pause Recording Button
                        FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: isRecording ? stopRecording : startRecording,
                          child: Icon(
                            isRecording ? Icons.pause : Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

void main() => runApp(const MaterialApp(home: CameraApp()));
