import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateUserPost extends StatefulWidget {
  const CreateUserPost({super.key});

  @override
  State<CreateUserPost> createState() => _CreateUserPostState();
}

class _CreateUserPostState extends State<CreateUserPost> {
  final ImagePicker _imagePicker = ImagePicker();
  CroppedFile? _croppedFile;

  XFile? _image;
  File? _videoFile;

  Future<void> _pickVideo(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickVideo(source: source);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  Future<void> imagePicker({required ImageSource source}) async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: source);
    _croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (_croppedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      // setState(() {
      //   // editProfileController.profilepic = croppedFile.path;
      //   // editProfileController.uploadImage(pickedFile);
      // });
    }
  }

  // Future<void> _videoFromCamera() async {
  //   final XFile? photo = await _picker.pickVideo(
  //     source: ImageSource.camera ?? ImageSource.gallery,
  //   );
  //   if (photo != null) {
  //     setState(() {
  //       _video = File(photo.path);
  //       _videoPlayerController = VideoPlayerController.file(_video!)
  //         ..initialize().then((_) {
  //           setState(() {});
  //           _videoPlayerController?.play();
  //
  //         });
  //       print(_video.toString());
  //       testCompressFile(_video!);
  //     });
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create post")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Upload Post"),
            20.heightBox,
            Container(
              height: 500.ah,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black26),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(),
                        20.widthBox,
                        const Text("Pramod"),
                        20.widthBox,
                        IconButton(
                          icon: const Icon(
                            Icons.attachment_sharp,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _showPicker(context);
                          },
                        ),
                      ],
                    ),
                    20.heightBox,
                    Expanded(
                        child: _image != null
                            ? Image.file(File(_croppedFile!.path))
                            : InkWell(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: SizedBox(height: 220.ah, child: const Center(child: Text("Pick File")))))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery '),
                      onTap: () {
                        imagePicker(source: ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('video'),
                    onTap: () {
                      _pickVideo(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imagePicker(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      leading: const Icon(Icons.bookmark_border),
                      title: const Text('Tag people'),
                      onTap: () {
                        // _videoFromGallery();
                        Navigator.pop(context);
                        // _showPickerMention(context, myList, myListId);
                        // Get.to(() => mention());
                      })
                ],
              ),
            ),
          );
        });
  }
}
