import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realdating/pages/apiHandler/apis/reel_api.dart';

import 'common_import.dart';

class CreateReelController extends GetxController {
  final PlayerManager _playerManager = Get.put(PlayerManager());

  RxBool flashSetting = false.obs; // Observable for flash state
  // RxBool flashSetting = false.obs;
  // Method to toggle flash
  void toggleFlash() {
    flashSetting.value = !flashSetting.value;
    update();
    print('flash light-------${flashSetting.value}');
  }

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ReelMusicModel> audios = <ReelMusicModel>[].obs;

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

      audios.clear();
      // getReelAudios();
    }
  }

  clear() {
    audios.clear();
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
      // getReelAudios();
      update();
    }
  }

  getReelCategories() {
    isLoadingAudios.value = true;
    // ReelApi.getReelCategories(resultCallback: (result) {
    //   categories.value = result;
    //   getReelAudios();
    //   update();
    // });
  }

  getReelAudios() {
    CategoryModel category = categories[selectedSegment];

    if (canLoadMoreAudios == true) {
      isLoadingAudios.value = true;
      // ReelApi.getAudios(
      //     categoryId: category.id,
      //     title: searchText.value.isNotEmpty ? searchText.value : null,
      //     resultCallback: (result, metadata) {
      //       isLoadingAudios.value = false;
      //       audios.value = result;
      //
      //       audiosCurrentPage += 1;
      //
      //       if (result.length == metadata.pageCount) {
      //         canLoadMoreAudios = true;
      //       } else {
      //         canLoadMoreAudios = false;
      //       }
      //
      //       update();
      //     });
    }
  }

  selectReelAudio(ReelMusicModel audio) {
    selectedAudio.value = audio;
  }

  setCroppedAudio(File audioFile) {
    croppedAudioFile = audioFile;
  }

  setAudioCropperTime(double startTime, double endTime) {
    print('-------${audioEndTime}');
    audioStartTime = startTime;
    audioEndTime = endTime;
  }

  playAudio(ReelMusicModel reelAudio) async {
    print('reelAudio.url ${reelAudio.url}');

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

  stopRecording() {
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
            Get.to(() => PreviewReelsScreen(
                  reel: finalFile,
                  audioId: selectedAudio.value?.id,
                  audioStartTime: audioStartTime,
                  audioEndTime: audioEndTime,
                ))?.then((value) async {
              print("object");
              uploadVideo(finalFile);
            });
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
      Get.to(() => PreviewReelsScreen(
            reel: finalFile,
          ));
    }
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

  void trimAudio() async {
    if (audioStartTime == null || audioEndTime == null) {
      AppUtil.showToast(
          message: 'Audio start or end time is not defined.', isSuccess: false);
      return;
    }

    print('Audio Start time-----------$audioStartTime');
    print('Audio End time-----------$audioEndTime');
    print('Audio recording time-----------$recordingLength');

    if ((audioEndTime! - audioStartTime!) < recordingLength.value.toDouble()) {
      AppUtil.showToast(
        message: 'Audio Clip is shorter than ${recordingLength.value} seconds.',
        isSuccess: false,
      );
      return;
    }
    print('Audio End time yyy-----------$audioEndTime');
    if (audioEndTime! <= audioStartTime!) {
      AppUtil.showToast(
        message: 'Audio End time must be greater than Start time.',
        isSuccess: false,
      );
      return;
    }

    EasyLoading.show(status: loadingString.tr);

    // Download and process audio file
    downloadAudio((status) async {
      if (status) {
        if (croppedAudioFile != null) {
          double duration = audioEndTime! - audioStartTime!;
          stopPlayingAudio();

          final directory = await getTemporaryDirectory();
          var finalAudioFile = File(
              '${directory.path}/AUD_${DateTime.now().millisecondsSinceEpoch}.mp3');

          // FFmpeg command to trim audio
          var audioTrimCommand =
              '-ss ${audioStartTime!} -i ${croppedAudioFile!.path} -t $duration -c copy ${finalAudioFile.path}';
          FFmpegKit.executeAsync(
            audioTrimCommand,
                (session) async {
              final returnCode = await session.getReturnCode();

              EasyLoading.dismiss();
              if (ReturnCode.isSuccess(returnCode)) {
                debugPrint('Audio Trimmed at: ${finalAudioFile.path}');
                Get.back(result: finalAudioFile); // Return the trimmed audio file
              } else if (ReturnCode.isCancel(returnCode)) {
                debugPrint('Audio Trim failed :: Cancelled');
              } else {
                debugPrint('Audio Trim failed :: $returnCode');
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
  }
}

Future<void> uploadVideo(File videoFile) async {
  var headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjo1OX0sImlhdCI6MTY5ODc0NTMyNH0.DArIe45knZvCQbmukVQ0dV4CpQ_0OLRvr2DMHoO-p1k'
  };

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://forreal.net:4000/create_reel'),
  );

  request.files.add(
    await http.MultipartFile.fromPath(
      'video', videoFile.path,
    ),
  );

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Reel uploaded successfully",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      print('Video uploaded successfully-----$response');
      // Handle success, maybe parse response
    } else {
      print('Error uploading video: ${response.statusCode}');
      // Handle error, maybe check response body for more info
    }
  } catch (error) {
    print('Exception uploading video: $error');
    // Handle exception
  }
}
