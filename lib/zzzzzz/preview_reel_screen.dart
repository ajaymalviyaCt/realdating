import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
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
    super.initState();
    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    try {
      videoPlayerController = VideoPlayerController.file(widget.reel);
      await videoPlayerController!.initialize();
      if (mounted) {
        setState(() {
          chewieController = ChewieController(
            aspectRatio: videoPlayerController!.value.aspectRatio,
            videoPlayerController: videoPlayerController!,
            autoPlay: true,
            looping: true,
            showControls: false,
          );
        });
      }
    } catch (e) {
      print("Error initializing video player: $e");
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        backgroundColor: AppColorConstants.backgroundColor,
        body: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: chewieController == null
                  ? Center(child: CircularProgressIndicator())
                  : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Chewie(controller: chewieController!),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                if (value.startsWith(' ')) {
                  _textController.text = value.trim();
                  _textController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _textController.text.length),
                  );
                }
              },
              validator: notEmptyMsgValidator,
              controller: _textController,
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: Colors.red,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                ),
                hintText: 'Caption',
                hintStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
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
                  ).setPadding(
                    left: DesignConstants.horizontalPadding,
                    right: DesignConstants.horizontalPadding,
                    top: 8,
                    bottom: 8,
                  ),
                ).circular.ripple(() {
                  if (_textController.text.trim().isNotEmpty) {
                    compressOrUploadVideo(widget.reel);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Caption can't be empty",
                      textColor: Colors.red,
                    );
                  }
                }),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ).hp(DesignConstants.horizontalPadding),
      ),
    );
  }

  Future<void> compressOrUploadVideo(File file) async {
    try {
      final info = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.Res640x480Quality,
      );

      if (info != null && info.file != null) {
        File compressedFile = info.file!;
        submitReel(compressedFile);
      } else {
        print("Video compression failed. Uploading original file.");
        submitReel(file);
      }
    } catch (e) {
      print("Error compressing video: $e. Uploading original file.");
      submitReel(file);
    }
  }

  Future<void> submitReel(File file) async {
    EasyLoading.show(status: loadingString.tr);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Fluttertoast.showToast(msg: "Authentication token not found");
        EasyLoading.dismiss();
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse('https://forreal.net:4000/create_reel'));
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['caption'] = _textController.text.trim();

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Upload successful");
        Get.back();
        Get.back();
      } else {
        print("Upload failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error during reel submission: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
