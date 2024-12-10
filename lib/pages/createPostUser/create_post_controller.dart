import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

import 'createUserPost.dart';

class CreatePostController extends GetxController {
  final Rxn<XFile> selectedFile = Rxn<XFile>();
  final Rxn<fileTypeName> selectedFileType = Rxn<fileTypeName>();

  @override
  void onInit() {
    super.onInit();
  }

  void onTapGallery() {
    final ImagePicker picker = ImagePicker();
    picker
        .pickMedia(
      imageQuality: 50,
    )
        .then(
      (value) async {
        if (value != null) {
          selectedFile.value = null;
          selectedFileType.value = null;
          selectedFile.value = value;
          selectedFileType.value = fileTypeCheckk(selectedFile.value!.path!);
          if (selectedFileType.value == fileTypeName.Video) {
            final directory = await getTemporaryDirectory();
            MediaInfo? mediaInfo = await VideoCompress.compressVideo(
              '${directory.path}/temp_${DateTime.now().millisecondsSinceEpoch}.mp4',
              quality: VideoQuality.DefaultQuality,
            );
            selectedFile.value = XFile(mediaInfo!.path!);
          }
        }
      },
    );
  }

  void onTapVideo() {
    final ImagePicker picker = ImagePicker();
    picker.pickVideo(source: ImageSource.camera).then(
      (value) async {
        if (value != null) {
          selectedFile.value = null;
          selectedFileType.value = null;
          selectedFile.value = value;
          selectedFileType.value = fileTypeCheckk(selectedFile.value!.path!);
          final directory = await getTemporaryDirectory();
          MediaInfo? mediaInfo = await VideoCompress.compressVideo(
            '${directory.path}/temp_${DateTime.now().millisecondsSinceEpoch}.mp4',
            quality: VideoQuality.DefaultQuality,
          );
          selectedFile.value = XFile(mediaInfo!.path!);
        }
      },
    );
  }

  void onTapCamera() {
    final ImagePicker picker = ImagePicker();
    picker.pickVideo(source: ImageSource.gallery).then(
      (value) {
        if (value != null) {
          selectedFile.value = null;
          selectedFileType.value = null;
          selectedFile.value = value;
          selectedFileType.value = fileTypeCheckk(selectedFile.value!.path!);
        }
      },
    );
  }


}
