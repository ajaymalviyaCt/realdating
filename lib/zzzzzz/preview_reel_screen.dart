import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
// import 'package:video_compress_ds/video_compress_ds.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart'as http;
import '../reel/common_import.dart';



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
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.reel);
    videoPlayerController!.initialize().then((value) {
      if (!mounted) return;
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
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoPlayerController?.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              chewieController == null
                  ? const Center(child: CircularProgressIndicator())
                  : AspectRatio(
                aspectRatio:1,
                child: Chewie(controller: chewieController!),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: captionController,
                onChanged: (value) {
                  if(value.trim().isNotEmpty){
                    captionController.text.trim();
                  }
                },
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Add a caption...",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Get.back(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      compressVideo(widget.reel);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }



  Future<void> compressVideo(File file) async {
    // setState(() {
    //   isCompressing = true;
    // });
    EasyLoading.show(status: loadingString.tr);
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
      EasyLoading.dismiss();
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

    request.fields['caption'] = captionController.text.trim();

    print("Caption: ${captionController.text.trim()}");
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


