import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  final Rxn<XFile> selectedFile = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
  }

  void onTapGallery() {
    ImagePicker picker = ImagePicker();
    picker
        .pickMedia(
      imageQuality: 50,
    )
        .then(
      (value) {
        if (value != null) {
          selectedFile.value = value;
        }
      },
    );
  }

  void onTapVideo() {
    ImagePicker picker = ImagePicker();
    picker.pickVideo(source: ImageSource.camera).then(
      (value) {
        if (value != null) {
          selectedFile.value = value;
        }
      },
    );
  }

  void onTapCamera() {
    ImagePicker picker = ImagePicker();
    picker.pickVideo(source: ImageSource.gallery).then(
      (value) {
        if (value != null) {
          selectedFile.value = value;
        }
      },
    );
  }
}
