import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:realdating/zzzzzz/content_creator_view.dart';
import 'package:realdating/zzzzzz/preview_reel_screen.dart';

import '../pages/apiHandler/apis/reel_api.dart';
import '../reel/reel_music_model.dart';
import 'category_model.dart';
import 'manager/player_manager.dart';

class CreateReelController extends GetxController {
  final PlayerManager _playerManager = Get.find();

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ReelMusicModel> audiosFiless = <ReelMusicModel>[].obs;

  Rx<ReelMusicModel?> selectedAudio = Rx<ReelMusicModel?>(null);
  double? audioStartTime;
  double? audioEndTime;
  File? croppedAudioFile;

  RxString searchText = ''.obs;
  int selectedSegment = 0;

  RxBool isLoadingAudios = false.obs;
  int audiosCurrentPage = 1;
  bool canLoadMoreAudios = true;
  final player = AudioPlayer(); // Create a player

  RxBool isRecording = false.obs;

  RxBool enableRecord = false.obs;
  DateTime? startDateTime;
  DateTime? endDateTime;
  RxBool flashSetting = false.obs;
  RxInt recordingLength = 15.obs;

  RxDouble currentProgressValue = (0.0).obs;

  // late SimpleDownloader _downloader;

  void turnOnFlash() {
    flashSetting.value = true;
    update();
  }

  void turnOffFlash() {
    flashSetting.value = false;
    update();
  }

  searchTextChanged(String text) {
    if (searchText.value != text) {
      clear();
      searchText.value = text;

      audiosFiless.clear();
      getReelAudios();
    }
  }

  clear() {
    audiosFiless.clear();
    isLoadingAudios.value = false;
    isRecording.value = false;
    audiosCurrentPage = 1;
    canLoadMoreAudios = true;
    selectedAudio.value = null;
    stopPlayingAudio();
  }

  closeSearch() {
    searchText.value = '';
    update();
  }

  segmentChanged(int index) {
    if (selectedSegment != index) {
      clear();
      selectedSegment = index;
      getReelAudios();
      update();
    }
  }

  getReelCategories() {
    isLoadingAudios.value = true;
    ReelApi.getReelCategories(resultCallback: (result) {
      categories.value = result;
      getReelAudios();
      update();
    });
  }

  getReelAudios() {
    CategoryModel category = categories[selectedSegment];

    if (canLoadMoreAudios == true) {
      isLoadingAudios.value = true;
      ReelApi.getAudios(
          categoryId: category.id,
          title: searchText.value.isNotEmpty ? searchText.value : null,
          resultCallback: (result, metadata) {
            isLoadingAudios.value = false;
            audiosFiless.value = result;

            audiosCurrentPage += 1;

            if (result.length == metadata.pageCount) {
              canLoadMoreAudios = true;
            } else {
              canLoadMoreAudios = false;
            }

            update();
          });
    }
  }

  selectReelAudio(ReelMusicModel audio) {
    selectedAudio.value = audio;
  }

  setCroppedAudio(File audioFile) {
    croppedAudioFile = audioFile;
  }

  setAudioCropperTime(double startTime, double endTime) {
    audioStartTime = startTime;
    audioEndTime = endTime;
  }

  playAudio(ReelMusicModel reelAudio) async {
    Audio audio = Audio(id: reelAudio.id.toString(), url: reelAudio.url);
    _playerManager.playNetworkAudio(audio);

    update();
  }

  playAudioFile(File reelAudio) async {
    _playerManager.playAudioFile(reelAudio);
    update();
  }

  playAudioFileUntil(ReelMusicModel reelAudio, double startDuration, double endDuration) async {
    _playerManager.playAudioFileTimeIntervalBased(reelAudio, startDuration, endDuration);
    update();
  }

  stopPlayingAudio() {
    debugPrint('end at:: ${_playerManager.currentPosition}');
    _playerManager.stopAudio();
    update();
  }

  void stopRecording() {
    endDateTime = DateTime.now();
    isRecording.value = false;
    stopPlayingAudio();
    update();
  }

  void startRecording() {
    isRecording.value = true;
    startDateTime = DateTime.now();
    update();
  }

  enableRecording() {
    enableRecord.value = true;
    update();
  }

  disableRecording() {
    enableRecord.value = false;
    update();
  }

  void createReel(File? selectedAudioFile, XFile videoFile) async {
    final directory = await getTemporaryDirectory();
    var finalFile = File('${directory.path}/REEL_${DateTime.now().millisecondsSinceEpoch}.mp4');

    if (selectedAudioFile != null) {
      FFmpegKitConfig.enableLogCallback((log) {});
      var command = "-i ${videoFile.path} -i ${selectedAudioFile.path} -map 0:v -map 1:a -c:v copy "
          "-shortest ${finalFile.path}";
      FFmpegKit.executeAsync(
        command,
            (session) async {
          final returnCode = await session.getReturnCode();

          if (ReturnCode.isSuccess(returnCode)) {
            debugPrint('Reel Created at: ${finalFile.path}');
            // SUCCESS
            // AppUtil.showToast(
            //     context: Get.context!,
            //     message: 'Reel Created successfully',
            //     isSuccess: true);

            if (Get.find<CameraControllerService>().controller.description.lensDirection == CameraLensDirection.front && Platform.isAndroid) {
              final directory = await getTemporaryDirectory();
              var outputFilePath = File('${directory.path}/REEL_${DateTime.now().millisecondsSinceEpoch}.mp4').path;
              await flipVideo(finalFile.path, outputFilePath, "hflip");
              Get.to(() => PreviewReelsScreen(
                reel: File(outputFilePath),
                audioId: selectedAudio.value?.id,
                audioStartTime: audioStartTime,
                audioEndTime: audioEndTime,
              ));
            } else {
              Get.to(() => PreviewReelsScreen(
                reel: finalFile,
                audioId: selectedAudio.value?.id,
                audioStartTime: audioStartTime,
                audioEndTime: audioEndTime,
              ));
            }
            /* final route = MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => VideoPage(filePath: file.path),
            );
            Navigator.push(context, route);*/
          } else if (ReturnCode.isCancel(returnCode)) {
            debugPrint('Reel failed :: Cancelled');
            // CANCEL
          } else {
            debugPrint('Reel failed :: $returnCode');
            // ERROR
          }
        },
      );
    } else {
      debugPrint('Reel Created without audio:: ${videoFile.path}');
      var finalFile = File(videoFile.path);
      // AppUtil.showToast(
      //     context: Get.context!,
      //     message: 'Reel Created without Audio',
      //     isSuccess: true);

      if (Get.find<CameraControllerService>().controller.description.lensDirection == CameraLensDirection.front && Platform.isAndroid) {
        final directory = await getTemporaryDirectory();
        var outputFilePath = File('${directory.path}/REEL_${DateTime.now().millisecondsSinceEpoch}.mp4').path;
        await flipVideo(finalFile.path, outputFilePath, "hflip");

        Get.to(() => PreviewReelsScreen(
          reel: File(outputFilePath),
        ));
      }else{
        Get.to(() => PreviewReelsScreen(
          reel: finalFile,
        ));
      }

    }
  }

  Future<void> flipVideo(String inputFilePath, String outputFilePath, String flipType) async {
    // Example Flip Types: "hflip" (horizontal), "vflip" (vertical), "hflip,vflip" (both)
    final command = '-i "$inputFilePath" -vf "$flipType" "$outputFilePath"';

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        print('Video flipped successfully!');
      } else {
        print('Error flipping video: ${session.getFailStackTrace()}');
      }
    });
  }

  downloadAudio(Function(bool) callback) async {
    final response = await http.get(Uri.parse(selectedAudio.value!.url));
    final bytes = response.bodyBytes;

    final dir = await Directory.systemTemp.createTemp();
    final file = File('${dir.path}/${selectedAudio.value!.id}.mp3');
    await file.writeAsBytes(bytes);
    croppedAudioFile = file;
    callback(true);
  }

  // downloadAudio(Function(bool) callback) async {
  //   // **** Download the audio file *******//
  //   DownloaderTask task = DownloaderTask(
  //     url: selectedAudio.value!.url,
  //     fileName: "${selectedAudio.value!.id}.mp3",
  //     bufferSize:
  //         1024, // if bufferSize value not set, default value is 64 ( 64 Kb )
  //   );
  //
  //   final pathFile = (await path.getTemporaryDirectory()).path;
  //   // if (!mounted) return;
  //
  //   task = task.copyWith(
  //     downloadPath: pathFile,
  //   );
  //
  //   _downloader = SimpleDownloader.init(task: task);
  //   _downloader.download();
  //   _downloader.callback.addListener(() {
  //     if (_downloader.callback.status == DownloadStatus.completed) {
  //       croppedAudioFile = File("$pathFile/${selectedAudio.value!.id}.mp3");
  //
  //       callback(true);
  //     } else if (_downloader.callback.status == DownloadStatus.failed ||
  //         _downloader.callback.status == DownloadStatus.canceled ||
  //         _downloader.callback.status == DownloadStatus.deleted) {
  //       callback(false);
  //     }
  //   });
  // }

  void trimAudio() async {
    if ((audioEndTime ?? 0 - (audioStartTime ?? 0)) < recordingLength.toDouble()) {
      Get.snackbar("title", 'Audio Clip is shorter than ${recordingLength}seconds ');

      return;
    }

    // Loader.show(status: "loadingString.tr");
    downloadAudio((status) async {
      if (status) {
        if (croppedAudioFile != null) {
          double duration = audioEndTime! - audioStartTime!;
          stopPlayingAudio();

          final directory = await getTemporaryDirectory();
          var finalAudioFile = File('${directory.path}/AUD_${DateTime.now().millisecondsSinceEpoch}.mp3');

          var audioTrimCommand = '-ss ${audioStartTime!} -i ${croppedAudioFile!.path} -t $duration -c copy ${finalAudioFile.path}';
          FFmpegKit.executeAsync(
            audioTrimCommand,
                (session) async {
              final returnCode = await session.getReturnCode();

              Loader.dismiss();
              if (ReturnCode.isSuccess(returnCode)) {
                debugPrint('Audio Trimmed at: ${finalAudioFile.path}');
                // SUCCESS
                Get.back(result: finalAudioFile);
              } else if (ReturnCode.isCancel(returnCode)) {
                debugPrint('Audio Trim failed :: Cancelled');
                // CANCEL
              } else {
                debugPrint('Audio Trim failed :: $returnCode');
                // ERROR
              }
            },
          );
        }
      }
    });
  }

  void updateProgress() {
    currentProgressValue.value = currentProgressValue.value + 1;
    update();
  }

  void resetProgress() {
    currentProgressValue.value = 0.0;
    update();
  }

  void updateRecordingLength(int recordingTime) {
    recordingLength.value = recordingTime;
    update();
  }
}
