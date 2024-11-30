import 'dart:math';

import 'package:camera/camera.dart';
import 'package:realdating/reel/select_music.dart';

import '../main.dart';
import 'common_import.dart';
import 'create_reel_controller.dart';

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({Key? key}) : super(key: key);

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen>
    with TickerProviderStateMixin {
  CameraController? controller;
  CameraLensDirection lensDirection = CameraLensDirection.back;
  final CreateReelController _createReelController =
  Get.put(CreateReelController());
  bool _isInitializingCamera = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    _createReelController.clear();
    super.dispose();
  }


  void _initCamera() async {
    if (_isInitializingCamera) return; // Skip if already initializing
    _isInitializingCamera = true;

    if (controller != null) {
      await controller!.dispose();
      controller = null;
      if (mounted) setState(() {});
    }

    final camera = cameras?.firstWhere(
          (cam) => cam.lensDirection == lensDirection,
      orElse: () => cameras!.first,
    );

    if (camera == null) {
      _isInitializingCamera = false;
      return;
    }

    controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: _createReelController.croppedAudioFile == null,
    );

    try {
      await controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    } finally {
      _isInitializingCamera = false;
    }
  }


  void _toggleCameraDirection() {
    setState(() {
      lensDirection = lensDirection == CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;
    });
    _initCamera();
  }


  Future<void> _toggleFlashMode() async {
    if (controller == null || !controller!.value.isInitialized) {
      print('Camera controller is not initialized');
      return;
    }

    try {
      final currentFlashMode = controller!.value.flashMode;
      print('Current Flash Mode: $currentFlashMode');

      final newFlashMode =
      currentFlashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;

      await controller!.setFlashMode(newFlashMode);
      print('Flash mode toggled to: $newFlashMode');

      // Update the UI state
      _createReelController.flashSetting.value =
          newFlashMode == FlashMode.torch; // true for torch, false for off
    } catch (e) {
      print('Error toggling flash mode: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (controller != null && controller!.value.isInitialized)
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child:
                    controller?.description.lensDirection == CameraLensDirection.back
                        ? CameraPreview(controller!):
                    Transform(
                        alignment: Alignment.topCenter,
                        transform:
                        Matrix4.rotationY(GetPlatform.isAndroid ? pi : 0),
                        child: CameraPreview(controller!)),
                  ),
                Positioned(
                  top: 25,
                  left: 16,
                  right: 16,
                  child: _buildTopControls(),
                ),
                Positioned(
                  top: 140,
                  left: 16,
                  child: _buildSideControls(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _recordVideo,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColorConstants.themeColor),
                    ),
                  ),
                  Obx(() =>
                  Container(
                    height: 50,
                    width: 50,
                    color: AppColorConstants.themeColor,
                    child: ThemeIconWidget(
                      _createReelController.isRecording.value
                          ? ThemeIcon.pause
                          : ThemeIcon.play,
                      size: 30,
                    ),
                  ).circular),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(
          onPressed: () => Get.back(),
          icon: Icons.close,
        ),
        Obx(() =>
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  SelectMusic(
                    selectedAudioCallback: (croppedAudio, music) {
                      _createReelController.setCroppedAudio(croppedAudio);
                      _initCamera();
                    },
                    duration: _createReelController.recordingLength.value,
                  ),
                  isScrollControlled: true,
                  ignoreSafeArea: true,
                );
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColorConstants.themeColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_createReelController.selectedAudio.value != null)
                        Icon(Icons.music_note_outlined,
                            color: AppColorConstants.mainTextColor),
                      Text(
                        _createReelController.selectedAudio.value?.name ??
                            selectMusicString.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildSideControls() {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleCameraDirection,
          child: Icon(Icons.cameraswitch_outlined,
              size: 30, color: AppColorConstants.themeColor),
        ),
        const SizedBox(height: 25),
        GestureDetector(
          onTap: _toggleFlashMode,
          child: Obx(() =>
              Icon(
                _createReelController.flashSetting.value
                    ? Icons.flash_on
                    : Icons.flash_off,
                size: 30,
                color: AppColorConstants.themeColor,
              )),
        ),

        const SizedBox(height: 25),
        _buildDurationButton(15),
        const SizedBox(height: 25),
        _buildDurationButton(30),
      ],
    ).setPadding(left: 8, right: 8, top: 12, bottom: 12);
  }

  Widget _buildDurationButton(int duration) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          _createReelController.updateRecordingLength(duration);
          print(
              'selected duration-----${_createReelController.recordingLength
                  .value}');
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _createReelController.recordingLength.value == duration
                  ? AppColorConstants.themeColor
                  : AppColorConstants.backgroundColor),
          child: Center(child: BodySmallText('${duration}s')),
        ),
      );
    });
  }

  void _recordVideo() async {
    if (_createReelController.isRecording.value) {
      _stopRecording();
    } else {
      await startRecording();
    }
  }

  void _stopRecording() async {
    final file = await controller!.stopVideoRecording();
    _createReelController.stopRecording();
    _createReelController.createReel(
        _createReelController.croppedAudioFile, file);
  }

  Future<void> startRecording() async {
    await controller!.prepareForVideoRecording();
    await controller!.startVideoRecording();
    _createReelController.startRecording();
    if (_createReelController.croppedAudioFile != null) {
      _createReelController
          .playAudioFile(_createReelController.croppedAudioFile!);
    }
  }

  Widget _buildIconButton(
      {required VoidCallback onPressed, required IconData icon}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: AppColorConstants.themeColor,
        padding: const EdgeInsets.all(4),
        child: Icon(icon, color: Colors.white),
      ).circular,
    );
  }
}


///----------------------------------------------------------

// class CreateReelScreen extends StatefulWidget {
//   const CreateReelScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CreateReelScreen> createState() => _CreateReelScreenState();
// }
//
// class _CreateReelScreenState extends State<CreateReelScreen>
//     with TickerProviderStateMixin {
//   CameraController? controller;
//   CameraLensDirection lensDirection = CameraLensDirection.back;
//   final CreateReelController _createReelController =
//   Get.put(CreateReelController());
//   late AnimationController animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//     _initAnimation();
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     animationController.dispose();
//     _createReelController.clear();
//     super.dispose();
//   }
//
//   /// Initialize the animation controller for the recording timer
//   void _initAnimation() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: _createReelController.recordingLength.value),
//     )
//       ..addListener(() {
//         if (mounted) setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _stopRecording();
//         }
//       });
//   }
//
//   /// Initialize the camera with the selected lens direction
//   Future<void> _initCamera() async {
//     if (controller != null) {
//       await controller!.dispose();
//     }
//
//     final camera = cameras?.firstWhere(
//           (cam) => cam.lensDirection == lensDirection,
//       orElse: () => cameras!.first,
//     );
//
//     if (camera == null) return;
//
//     controller = CameraController(
//       camera,
//       ResolutionPreset.max,
//       enableAudio: _createReelController.croppedAudioFile == null,
//     );
//
//     try {
//       await controller!.initialize();
//       if (mounted) setState(() {});
//     } catch (e) {
//       if (e is CameraException && e.code == 'CameraAccessDenied') {
//         // Handle camera permission errors
//       }
//     }
//   }
//
//   /// Toggle between front and back cameras
//   void _toggleCameraDirection() {
//     setState(() {
//       lensDirection = lensDirection == CameraLensDirection.back
//           ? CameraLensDirection.front
//           : CameraLensDirection.back;
//     });
//     _initCamera();
//   }
//
//   /// Toggle the flash mode
//   void _toggleFlashMode() async {
//     if (controller == null) return;
//
//     final currentFlashMode = controller!.value.flashMode;
//     final newFlashMode =
//     currentFlashMode == FlashMode.off ? FlashMode.always : FlashMode.off;
//
//     try {
//       await controller!.setFlashMode(newFlashMode);
//       _createReelController.toggleFlash();
//     } catch (e) {
//       // Handle flash mode errors
//     }
//   }
//
//   /// Start or stop video recording
//   void _recordVideo() async {
//     if (_createReelController.isRecording.value) {
//       await _stopRecording();
//     } else {
//       await startRecording();
//     }
//   }
//
//   /// Stop video recording
//   Future<void> _stopRecording() async {
//     animationController.reset();
//
//     try {
//       final XFile xFile = await controller!.stopVideoRecording();
//       _createReelController.stopRecording();
//
//       final File file = File(xFile.path);
//       _createReelController.createReel(
//           _createReelController.croppedAudioFile, file);
//     } catch (e) {
//       // Handle errors during stop recording
//     }
//   }
//
//   /// Start video recording
//   Future<void> startRecording() async {
//     try {
//       await controller!.prepareForVideoRecording();
//       await controller!.startVideoRecording();
//       _createReelController.startRecording();
//
//       if (_createReelController.croppedAudioFile != null) {
//         _createReelController
//             .playAudioFile(_createReelController.croppedAudioFile!);
//       }
//     } catch (e) {
//       // Handle errors during start recording
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 if (controller != null && controller!.value.isInitialized)
//                   AspectRatio(
//                     aspectRatio: 9 / 16,
//                     child: Transform(
//                       alignment: Alignment.topCenter,
//                       transform:
//                       Matrix4.rotationY(GetPlatform.isAndroid ? pi : 0),
//                       child: CameraPreview(controller!),
//                     ),
//                   ),
//                 Positioned(
//                   top: 25,
//                   left: 16,
//                   right: 16,
//                   child: _buildTopControls(),
//                 ),
//                 Positioned(
//                   top: 140,
//                   left: 16,
//                   child: _buildSideControls(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 animationController.forward();
//                 _recordVideo();
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     height: 60,
//                     width: 60,
//                     child: CircularProgressIndicator(
//                       value: animationController.value,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                           AppColorConstants.themeColor),
//                     ),
//                   ),
//                   Obx(() => Container(
//                     height: 50,
//                     width: 50,
//                     color: AppColorConstants.themeColor,
//                     child: ThemeIconWidget(
//                       _createReelController.isRecording.value
//                           ? ThemeIcon.pause
//                           : ThemeIcon.play,
//                       size: 30,
//                     ),
//                   ).circular),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTopControls() {
//     // Same implementation
//   }
//
//   Widget _buildSideControls() {
//     // Same implementation
//   }
//
//   Widget _buildDurationButton(int duration) {
//     // Same implementation
//   }
//
//   Widget _buildIconButton(
//       {required VoidCallback onPressed, required IconData icon}) {
//     // Same implementation
//   }
// }


///-----------------------------------------------------------------------------

// class CreateReelScreen extends StatefulWidget {
//   const CreateReelScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CreateReelScreen> createState() => _CreateReelScreenState();
// }
//
// class _CreateReelScreenState extends State<CreateReelScreen>
//     with TickerProviderStateMixin {
//   CameraController? controller;
//
//   CameraLensDirection lensDirection = CameraLensDirection.back;
//   final CreateReelController _createReelController =
//   Get.put(CreateReelController());
//   AnimationController? animationController;
//
//   @override
//   void initState() {
//     _initCamera();
//     _initAnimation();
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(covariant CreateReelScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _initCamera();
//     _initAnimation();
//   }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     _createReelController.clear();
//     super.dispose();
//   }
//
//   _initAnimation() {
//     /// Set animation based on selected recording length
//     animationController = AnimationController(
//         vsync: this,
//         duration: Duration(seconds: _createReelController.recordingLength.value));
//     animationController!.addListener(() {
//       setState(() {});
//     });
//     animationController!.addStatusListener((status) async {
//       if (status == AnimationStatus.completed) {
//         await stopRecording(); // Stop recording and upload
//       }
//     });
//   }
//
//   _recordVideo() async {
//     if (_createReelController.isRecording.value) {
//       await _createReelController.stopRecording(); // Stop recording if it's already in progress
//     } else {
//       startRecording(); // Start recording and begin the animation
//       animationController!.forward(); // Start the progress animation
//     }
//   }
//
//   stopRecording() async {
//     animationController?.reset();
//
//     final file = await controller!.stopVideoRecording();
//     _createReelController.stopRecording();
//
//     /// Upload the recorded video
//     await uploadVideo(File(file.path));
//   }
//   void startRecording() async {
//     await controller!.prepareForVideoRecording();
//     await controller!.startVideoRecording();
//     _createReelController.startRecording();
//
//     /// Start playing audio if selected
//     if (_createReelController.croppedAudioFile != null) {
//       _createReelController.playAudioFile(_createReelController.croppedAudioFile!);
//     }
//   }
//
//
//   _initCamera() async {
//     final front =
//     cameras?.firstWhere((camera) => camera.lensDirection == lensDirection);
//
//     controller = CameraController(front!, ResolutionPreset.max,
//         enableAudio: _createReelController.croppedAudioFile == null);
//     controller!.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//           // Handle access errors here.
//             break;
//           default:
//           // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 controller == null
//                     ? Container()
//                     : AspectRatio(
//                   aspectRatio: 9 / 16,
//                   child: CameraPreview(
//                     controller!,
//                   ).round(20),
//                 ),
//                 Positioned(
//                   left: DesignConstants.horizontalPadding,
//                   right: DesignConstants.horizontalPadding,
//                   top: 25,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               color: AppColorConstants.themeColor,
//                               child: const ThemeIconWidget(ThemeIcon.close).p4).circular.ripple(() {
//                                Get.back();
//                           }),
//                           Obx(() => Container(
//                               color: AppColorConstants.themeColor,
//                               child: Row(
//                                 children: [
//                                   if (_createReelController.selectedAudio.value != null)
//                                     ThemeIconWidget(ThemeIcon.music, color: AppColorConstants.mainTextColor),
//                                   BodyLargeText(
//                                     _createReelController.selectedAudio.value != null
//                                         ? _createReelController.selectedAudio.value!.name : selectMusicString.tr,
//                                     weight: TextWeight.bold,
//                                   ),
//                                 ],
//                               ).setPadding(
//                                   left: DesignConstants.horizontalPadding,
//                                   right: DesignConstants.horizontalPadding,
//                                   top: 8,
//                                   bottom: 8)).circular).ripple(() {
//                             Get.bottomSheet(
//                               SelectMusic(
//                                 selectedAudioCallback: (croppedAudio, music) {
//                                   _createReelController.setCroppedAudio(croppedAudio);
//                                   _initCamera();
//                                 },
//                                 duration:
//                                 _createReelController.recordingLength.value,
//                               ),
//                               isScrollControlled: true,
//                               ignoreSafeArea: true,
//                             );
//                           }),
//                           const SizedBox(width: 20),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: DesignConstants.horizontalPadding,
//                   top: 140,
//                   child: Container(
//                     color: AppColorConstants.cardColor.withOpacity(0.5),
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             if (controller == null) {
//                               return;
//                             }
//                             if (controller!.description.lensDirection ==
//                                 CameraLensDirection.back) {
//                               lensDirection = CameraLensDirection.front;
//                               _initCamera();
//                             } else {
//                               lensDirection = CameraLensDirection.back;
//                               _initCamera();
//                             }
//                           },
//                           child: Icon(
//                             Icons.cameraswitch_outlined,
//                             size: 30,
//                             color: AppColorConstants.themeColor,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Obx(() => GestureDetector(
//                           onTap: () {
//                             if (controller == null) {
//                               return;
//                             }
//                             if (_createReelController.flashSetting.value) {
//                               controller!.setFlashMode(FlashMode.off);
//                               _createReelController.turnOffFlash();
//                             } else {
//                               controller!.setFlashMode(FlashMode.always);
//                               _createReelController.turnOnFlash();
//                             }
//                           },
//                           child: Icon(
//                             _createReelController.flashSetting.value
//                                 ? Icons.flash_on : Icons.flash_off,
//                             size: 30, color: AppColorConstants.themeColor,
//                           ),
//                         )),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Obx(() => GestureDetector(
//                           onTap: () {
//                             _createReelController.updateRecordingLength(15);
//                             _initAnimation();
//                           },
//                           child: Container(
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: _createReelController.recordingLength.value ==
//                                     15 ? AppColorConstants.themeColor
//                                     : AppColorConstants.backgroundColor),
//                             child: const Center(child: BodySmallText('15s')),
//                           ),
//                         )),
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Obx(() => GestureDetector(
//                           onTap: () {
//                             _createReelController.updateRecordingLength(30);
//                             _initAnimation();
//                           },
//                           child: Container(
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: _createReelController
//                                     .recordingLength.value ==
//                                     30
//                                     ? AppColorConstants.themeColor
//                                     : AppColorConstants.backgroundColor),
//                             child: const Center(child: BodySmallText('30s')),
//                           ),
//                         ))
//                       ],
//                     ).setPadding(left: 8, right: 8, top: 12, bottom: 12),
//                   ).round(20),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 animationController!.forward();
//                 _recordVideo();
//                 // _recordVideo();
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 60,
//                     width: 60,
//                     child: CircularProgressIndicator(
//                       value: animationController!.value,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                           AppColorConstants.themeColor),
//                     ),
//                   ),
//                   Obx(() => Container(
//                     height: 50,
//                     width: 50,
//                     color: AppColorConstants.themeColor,
//                     child: ThemeIconWidget(
//                       _createReelController.isRecording.value
//                           ? ThemeIcon.pause
//                           : ThemeIcon.play,
//                       size: 30,
//                     ),
//                   ).circular)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//   // _recordVideo() async {
//   //   if (_createReelController.isRecording.value) {
//   //     ////todo 0000000000000
//   //     //   stopRecording();
//   //   } else {
//   //     startRecording();
//   //   }
//   // }
//
//   ////todo 0000000000000
//
//   // void stopRecording() async {
//   //   animationController?.reset();
//   //
//   //   final file = await controller!.stopVideoRecording();
//   //  // final videoInfo = FlutterVideoInfo();
//   // ////todo 0000000000000
//   //  // var info = await videoInfo.getVideoInfo(file.path);
//   //
//   //   if (info?.duration != null) {
//   //     _createReelController.updateRecordingLength(info!.duration!.toInt());
//   //   }
//   //
//   //   debugPrint('RecordedFile:: ${file.path}');
//   //   _createReelController.stopRecording();
//   //   if (_createReelController.croppedAudioFile != null) {
//   //     _createReelController.stopPlayingAudio();
//   //   }
//   //   _createReelController.isRecording.value = false;
//   //   _createReelController.createReel(
//   //       _createReelController.croppedAudioFile, file);
//   // }
//
//   // void startRecording() async {
//   //   await controller!.prepareForVideoRecording();
//   //   await controller!.startVideoRecording();
//   //   _createReelController.startRecording();
//   //   if (_createReelController.croppedAudioFile != null) {
//   //     _createReelController
//   //         .playAudioFile(_createReelController.croppedAudioFile!);
//   //   }
//   //   // startRecordingTimer();
//   // }
// }
