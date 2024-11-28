import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import 'package:realdating/custom_iteam/coustomtextcommon.dart';
import 'package:realdating/function/function_class.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realdating/reel/common_import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_area/text_area.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import '../../button.dart';
import '../../const.dart';
import '../buisness_home/Bhome_page/homepage_bussiness_controller.dart';
import '../buisness_home/controller/business_home_controller.dart';
import '../buisness_profile/business_profile_controller.dart';

class BuisnessPost extends StatefulWidget {
  const BuisnessPost({Key? key}) : super(key: key);

  @override
  State<BuisnessPost> createState() => _BuisnessPostState();
}

class _BuisnessPostState extends State<BuisnessPost> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var status, message, data, user_id, token, headers;

  String? PostImage;

  TextEditingController Content = TextEditingController();

  final myTextController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _images;
  File? _video;

  String? reasonValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required.';
    }
    return null;
  }



  _imgFromGallery() async {
    final XFile? image = (await _picker.pickMedia(
        // source: ImageSource.gallery,
        // imageQuality: 10,
        requestFullMetadata: true));
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,

      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      maxWidth: 600,
      maxHeight: 600,
    );
    if (croppedFile != null) {
      _images = File(croppedFile.path);
      print(_images.toString());

      testCompressFile(_images!);

      _videoPlayerController = VideoPlayerController.file(_images!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController?.play();
        });
      setState(() {});
    }
    // return image??_videoPlayerController;
  }

  _imgFromCamera() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: photo!.path,

      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      maxWidth: 600,
      maxHeight: 600,
    );
    if (croppedFile != null) {
      setState(() {
        _images = File(croppedFile.path);
        print(_images.toString());
        testCompressFile(_images!);
      });
    }
  }

  VideoPlayerController? _videoPlayerController;

  _videoFromGallery() async {
    final XFile? photo = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (photo != null) {
      setState(() {
        _video = File(photo.path);
        _videoPlayerController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController?.play();
          });
        print(_video.toString());
        try {
          // testCompressFile(_video!);
        }  catch (e,s) {
        print(e);
        print(s);
        }
      });
    } else {}
  }
  Future<void> compressVideos(File file) async {
    // setState(() {
    //   isCompressing = true;
    // });
    EasyLoading.show(status: loadingString.tr);
    int fileSizeInBytes = file.lengthSync();
    print("Total_size===>: ${file.lengthSync()}");
    double fileSizeInKB = fileSizeInBytes / 1024; // Convert bytes to kilobytes
    double fileSizeInMB = fileSizeInKB / 1024;
    print("Total_size===>fileSizeInKB: ${fileSizeInKB}");
    print("Total_size===>fileSizeInMB ${fileSizeInMB}");
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
      print("Total_size===>fileSizeInKB_after: ${fileSizeInKB}");
      print("Total_size===>fileSizeInMB_after ${fileSizeInMB}");


      // uploadFileToServerUHome(finalFile);
      // submitReel(finalFile);
      // Handle the compressed video file, for example, you can upload it or play it.
    } catch (e) {
      print("Error compressing video: $e");
    } finally {
      EasyLoading.dismiss();
      // isCompressing = false;
    }
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
                      title: const Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  /*  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('video'),
                    onTap: () {
                      _videoFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),*/
                ],
              ),
            ),
          );
        });
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 5,
      rotate: 90,
    );
    print('??????????????');
    print(file.lengthSync());
    print(result!.length);
    setState(() {});
    return result;
  }

  @override
  void initState() {
    super.initState();
 /*   myTextController.addListener(() {
      setState(() {
        reasonValidation = myTextController.text.isEmpty;
      });
    });*/
  }

  @override
  void dispose() {
    // _connectivitySubscription?.cancel();
    super.dispose();
  }
  //
  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void uploadFileToServerBHome() async {
    myDealController.allDataBusiness?.posts.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        user_id = prefs.get('user_id');
        token = prefs.get('token');
        // print('user_id==============' + user_id!);
      });
      print("CLICKED 123 ==");

      // initConnectivity();
      // _connectivitySubscription =
      //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

      if (_images == null && _video == null && myTextController.text == null) {
        Fluttertoast.showToast(
          msg: "Please fill any Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        showLoaderDialog(context);
        // if (_connectionStatus != null) {
        //   // Internet Present Case
        //   showLoaderDialog(context);
        // } else {
        //   Fluttertoast.showToast(
        //       msg: "Please check your Internet connection!!!!",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       backgroundColor: Colors.black,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        var request = http.MultipartRequest("POST",
            Uri.parse("https://forreal.net:4000/create_business_post"));
        final headers = {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        };
        request.headers.addAll(headers);
        if (myTextController.text.isNotEmpty) {
          request.fields['caption'] = myTextController.text.toString();
        }

        request.fields['post_type'] = _video != null ? "video" : "Image" ?? "";

        request.fields['business_id'] = user_id.toString();
        // request.headers.addAll(headers);
        if (_video == null && _images == null) {
          print("object");
          request.fields['file']?.isEmpty;
        } else if (_video != null) {
          // EasyLoading.show(status: loadingString.tr);
          int fileSizeInBytes = _video!.lengthSync();
          print("Total_size===>: ${_video!.lengthSync()}");
          double fileSizeInKB = fileSizeInBytes / 1024; // Convert bytes to kilobytes
          double fileSizeInMB = fileSizeInKB / 1024;
          print("Total_size===>fileSizeInKB: ${fileSizeInKB}");
          print("Total_size===>fileSizeInMB ${fileSizeInMB}");
          try {
            final info = await VideoCompress.compressVideo(
              _video!.path,
              quality: VideoQuality.Res640x480Quality,
            );
            print("Compression result: ${info?.path}");
            print("Compression result1: ${info?.filesize}");
            print("Compression result2: ${info?.duration}");


            File finalFile = info!.file!;

            int fileSizeInBytes22 = finalFile.lengthSync();
            print("Total_size_after===>: ${_video!.lengthSync()}");
            double fileSizeInKB22 = fileSizeInBytes22 / 1024; // Convert bytes to kilobytes
            double fileSizeInMB = fileSizeInKB22 / 1024;
            print("Total_size===>fileSizeInKB_after: ${fileSizeInKB}");
            print("Total_size===>fileSizeInMB_after ${fileSizeInMB}");

            request.files.add(await http.MultipartFile.fromPath('file', finalFile.path));
            // submitReel(finalFile);
            // Handle the compressed video file, for example, you can upload it or play it.
          } catch (e) {
            print("Error compressing video: $e");
          } finally {
            EasyLoading.dismiss();
            // isCompressing = false;
          }
        } else if(_images != null){
          request.files
              .add(await http.MultipartFile.fromPath('file', _images!.path));
        }
        request.send().then((response) {
          http.Response.fromStream(response).then((onValue) async {
            if (response.statusCode == 200) {
              Fluttertoast.showToast(
                msg: "Post has been uploaded successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              setState(() {
                myDealController.pagingController.appendLastPage([]);
              });
              // Delay the page refresh to allow server processing time
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  myDealController.pagingController.refresh();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BuisnessHomePage()));
                });
              });
              Get.offAll(()=>BuisnessHomePage());
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => BuisnessHomePage()));

              // ... (existing code)
            } else {
              Fluttertoast.showToast(
                msg: "Something went wrong....",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: const Color(0xffC83760),
                textColor: Colors.white,
                fontSize: 16.0,
              );
              // handle exception
            }
          });
        });

      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  MyDealController myDealController = Get.put(MyDealController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        color: Appcolor.Redpink,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _showPicker(context);
                },
                icon: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  _videoFromGallery();
                },
                icon: const Icon(
                  Icons.video_camera_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Create post',
          style: CustomTextStyle.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: IconButton(
              onPressed: () {
                if (_images != null ||
                    _video != null ||
                    myTextController.text.isNotEmpty ) {

                    uploadFileToServerBHome();

                } else {
                  Fluttertoast.showToast(
                    msg: "Please select image or Text..",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              icon: Image.asset('assets/icons/Share.png'),
            ),
          ),

          // SvgPicture.asset('assets/icons/Share.svg'),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  // autovalidateMode:  AutovalidateMode.always,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        customTextC(
                            text: "Upload image or video",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: _images == null && _video == null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 306,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: HexColor('#D9D9D9'),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ))
                                  : _video != null
                                      ? _videoPlayerController!
                                              .value.isInitialized
                                          ? Container(
                                              height: 360,
                                              child: AspectRatio(
                                                aspectRatio:
                                                    _videoPlayerController!
                                                        .value.aspectRatio,
                                                child: VideoPlayer(
                                                    _videoPlayerController!),
                                              ),
                                            )
                                          : Container()
                                      : Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 306,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: HexColor('#D9D9D9'),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          File(_images!.path)),
                                                      fit: BoxFit.fill)),
                                            ),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                    onTap: () {
                                                      _images = null;
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.cancel,
                                                      color: Colors.white,
                                                      size: 30,
                                                    )))
                                          ],
                                        ),
                            ),
                            Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //  SvgPicture.asset('assets/icons/file-plus.svg'),
                                  /*    InkWell(
                                    onTap: () {
                                      // _showPicker(context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/image-add (1).svg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),*/
                                  SizedBox(height: 12),
                                  Text('Upload Image',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey))
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        // customTextC(
                        //     text: "Contents",
                        //     fSize: 16,
                        //     fWeight: FontWeight.w500,
                        //     lineHeight: 36),
                        TextFormField(
                          controller: myTextController,
                          validator: reasonValidation,
                          maxLines: null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your description here...',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Adjust padding
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30)
                      ]),
                )),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: HexColor('#FA525F'),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     //crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       SvgPicture.asset('assets/icons/ic_filter_24px.svg'),
      //       SizedBox(width: 100),
      //       SvgPicture.asset('assets/icons/ic_videocam_24px.svg'),
      //     ],
      //   ),
      // ),
    );
  }

  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Button(
        btnColor: Colors.redAccent,
        buttonName: 'Share',
        btnstyle: textstylesubtitle2(context)!
            .copyWith(color: colorWhite, fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        // btnColor: colorbutton,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            print("ADDPOST===>");
            uploadFileToServerBHome();
          }
          // else{
          //   Fluttertoast.showToast(
          //       msg: "Please Match Password",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       backgroundColor: Colors.black,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
        },
      ),
    );
  }
}
