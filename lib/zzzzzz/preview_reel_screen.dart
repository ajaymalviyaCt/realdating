import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
// import 'package:video_compress_ds/video_compress_ds.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../reel/localization_strings.dart';
import '../validation/validation.dart';
import 'colors_file.dart';

class PreviewReelsScreen extends StatefulWidget {
  final File reel;
  final int? audioId;
  final double? audioStartTime;
  final double? audioEndTime;

  const PreviewReelsScreen({Key? key, required this.reel, this.audioId, this.audioStartTime, this.audioEndTime}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PreviewReelsState();
  }
}

class _PreviewReelsState extends State<PreviewReelsScreen> {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(widget.reel);
    videoPlayerController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      chewieController = ChewieController(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        showOptions: false,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    chewieController!.dispose();
    videoPlayerController!.dispose();
    chewieController?.pause();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: AppScaffold(
        backgroundColor: AppColorConstants.backgroundColor,
        body: Column(
            // alignment: Alignment.topCenter,
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: chewieController == null
                    ? Container()
                    : SizedBox(
                        height: (Get.width - 32) / videoPlayerController!.value.aspectRatio,
                        child: Chewie(
                          controller: chewieController!,
                        ),
                      ).round(20),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                // height: 70,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    if (value.startsWith(' ')) {
                      _textController.text = value.trim();
                      _textController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _textController.text.trim().length),
                      );
                    }
                  },
                  validator: notEmptyMsgValidator,
                  controller: _textController,
                  maxLines: 4,
                  // Set the maximum number of lines for input
                  decoration: InputDecoration(
                    fillColor: Colors.red,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        )),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        )),
                    hintText: 'Caption',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   ThemeIconWidget(
                    ThemeIcon.backArrow,
                    size: 25,
                  ).circular.ripple(() {
                    Get.back();
                  }),
                  Container(
                      color: AppColorConstants.themeColor,
                      child: Text(
                        nextString.tr,
                        style: TextStyle(fontSize: FontSizes.b2),
                      ).setPadding(left: DesignConstants.horizontalPadding, right: DesignConstants.horizontalPadding, bottom: 8, top: 8))
                      .circular
                      .ripple(() {
                    compressVideo(widget.reel);
                  }),
                ],
              ),
              const SizedBox(
                height: 40,
              )

            ]).hp(DesignConstants.horizontalPadding),
      ),
    );
  }

  Future<void> compressVideo(File file) async {
    // setState(() {
    //   isCompressing = true;
    // });
    int fileSizeInBytes = file.lengthSync();
    print("Total_size===>: ${file.lengthSync()}");
    double fileSizeInKB = fileSizeInBytes / 1024; // Convert bytes to kilobytes
    double fileSizeInMB = fileSizeInKB / 1024;
    print("Total_size===>fileSizeInKB: $fileSizeInKB");
    print("Total_size===>fileSizeInMB $fileSizeInMB");
    try {
      final info = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.Res640x480Quality,
      );
      print("Compression result: ${info?.path}");
      print("Compression result1: ${info?.filesize}");
      print("Compression result2: ${info?.duration}");

      File finalFile = info!.file!;

      int fileSizeInBytes22 = finalFile.lengthSync();
      print("Total_size_after===>: ${file.lengthSync()}");
      double fileSizeInKB22 = fileSizeInBytes22 / 1024; // Convert bytes to kilobytes
      double fileSizeInMB = fileSizeInKB22 / 1024;
      print("Total_size===>fileSizeInKB_after: $fileSizeInKB");
      print("Total_size===>fileSizeInMB_after $fileSizeInMB");

      submitReel(finalFile);
      // Handle the compressed video file, for example, you can upload it or play it.
    } catch (e) {
      print("Error compressing video: $e");
    } finally {
      //EasyLoading.dismiss();
      // isCompressing = false;
    }
  }

  submitReel(File file) async {
    EasyLoading.show(status: loadingString.tr);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token'); // Ensure token retrieval is consistent
    print("File path: ${file.path}");
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://forreal.net:4000/create_reel'));

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    request.fields['caption'] = _textController.text.trim();

    print("Caption: ${_textController.text.trim()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print("Upload successful: Upload successful: $responseBody");
      Get.back();
      Get.back();
    } else {
      print("Upload failed: ${response.reasonPhrase}");
    }

    EasyLoading.dismiss(); // Dismiss loading indicator
  }

}
