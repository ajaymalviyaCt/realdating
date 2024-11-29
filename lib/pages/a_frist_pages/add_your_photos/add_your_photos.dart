import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/pages/a_frist_pages/height_dob/heught_dob_page.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_colors.dart';
import '../../../function/function_class.dart';
import '../../../widgets/custom_appbar.dart';

class AddYourPhotoPage extends StatefulWidget {
  const AddYourPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddYourPhotoPage> createState() => _AddYourPhotoPageState();
}

class _AddYourPhotoPageState extends State<AddYourPhotoPage> {
  bool isLoading = false;

  void uploadImage(context) async {
    if (selectedImages.length < 2) {
      Fluttertoast.showToast(
        msg: "Please upload at least 2 photos.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest("POST", Appurls.addYourPhotoas);
    for (var file in selectedImages) {
      try {
        if (file.file.value != null) {
          String fileName = file.file.value!.path.split("/").last;
          var stream = http.ByteStream(DelegatingStream.typed(file.file.value!.openRead()));
          var length = await file.file.value!.length();
          var multipartFileSign = http.MultipartFile('files', stream, length, filename: fileName);
          request.files.add(multipartFileSign);
        }
      } catch (e, s) {
        // TODO
      }
    }

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Fluttertoast.showToast(
            msg: "Photos added Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            isLoading = false;
          });

          updateStatus();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HeightDOBpage(),
              ));
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Internal sever Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print(e.toString());
        }
      });
    });
    request.headers.addAll(headers);
  }

  final RxList<({Rxn<File> file})> selectedImages = <({Rxn<File> file})>[
    (file: Rxn()),
    (file: Rxn()),
    (file: Rxn()),
    (file: Rxn()),
    (file: Rxn()),
    (file: Rxn()),
  ].obs;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Add Your Photos", context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  'Upload 2 photos to start. Add 4 more to \nmake your profile stand out.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    selectedImages[0].file.value != null
                        ? Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffBDBDBD).withOpacity(0.35),
                                  image: DecorationImage(image: FileImage(selectedImages[0].file.value!), fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/cross.svg'),
                            ),
                          ])
                        : InkWell(
                            onTap: () async {
                              final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                              List<XFile> xfilePick = pickedFile;

                              setState(
                                () {
                                  if (xfilePick.isNotEmpty) {
                                    for (var i = 0; i < xfilePick.length; i++) {
                                      selectedImages[0].file.value = File(xfilePick[i].path);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                  }
                                },
                              );

                              // hobbiesController.interestSelect();
                            },
                            child: Stack(children: [
                              Container(
                                height: 130,
                                width: 103,
                                decoration: BoxDecoration(
                                  color: Appcolor.backgroundclr,
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 105, left: 80),
                                child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                              ),
                            ]),
                          ),
                    selectedImages[1].file.value != null
                        ? Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffBDBDBD).withOpacity(0.35),
                                  image: DecorationImage(image: FileImage(selectedImages[1].file.value!), fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/cross.svg'),
                            ),
                          ])
                        : InkWell(
                            onTap: () async {
                              final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                              List<XFile> xfilePick = pickedFile;

                              setState(
                                () {
                                  if (xfilePick.isNotEmpty) {
                                    for (var i = 0; i < xfilePick.length; i++) {
                                      selectedImages[1].file.value = File(xfilePick[i].path);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                  }
                                },
                              );
                            },
                            child: Stack(children: [
                              Container(
                                height: 130,
                                width: 103,
                                decoration: BoxDecoration(
                                  color: Appcolor.backgroundclr,
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 105, left: 80),
                                child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                              ),
                            ]),
                          ),
                    selectedImages[2].file.value != null
                        ? Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffBDBDBD).withOpacity(0.35),
                                  image: DecorationImage(image: FileImage(selectedImages[2].file.value!), fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                            ),
                          ])
                        : InkWell(
                            onTap: () async {
                              final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                              List<XFile> xfilePick = pickedFile;

                              setState(
                                () {
                                  if (xfilePick.isNotEmpty) {
                                    for (var i = 0; i < xfilePick.length; i++) {
                                      selectedImages[2].file.value = File(xfilePick[i].path);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                  }
                                },
                              );
                            },
                            child: Stack(children: [
                              Container(
                                height: 130,
                                width: 103,
                                decoration: BoxDecoration(
                                  color: Appcolor.backgroundclr,
                                  border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 105, left: 80),
                                child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                              ),
                            ]),
                          ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedImages[3].file.value != null
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(image: FileImage(selectedImages[3].file.value!), fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () async {
                            final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                            List<XFile> xfilePick = pickedFile;

                            setState(
                              () {
                                if (xfilePick.isNotEmpty) {
                                  for (var i = 0; i < xfilePick.length; i++) {
                                    selectedImages[3].file.value = File(xfilePick[i].path);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                }
                              },
                            );
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages[4].file.value != null
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(image: FileImage(selectedImages[4].file.value!), fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () async {
                            final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                            List<XFile> xfilePick = pickedFile;

                            setState(
                              () {
                                if (xfilePick.isNotEmpty) {
                                  for (var i = 0; i < xfilePick.length; i++) {
                                    selectedImages[4].file.value = File(xfilePick[i].path);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                }
                              },
                            );
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages[5].file.value != null
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(image: FileImage(selectedImages[5].file.value!), fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset('assets/icons/cross.svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () async {
                            final pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
                            List<XFile> xfilePick = pickedFile;

                            setState(
                              () {
                                if (xfilePick.isNotEmpty) {
                                  for (var i = 0; i < xfilePick.length; i++) {
                                    selectedImages[5].file.value = File(xfilePick[i].path);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
                                }
                              },
                            );
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20),
                child: Text('Upload and introductory video for showcasing your personality and interests',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const Spacer(),
              customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  if (selectedImages.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please Select image",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: colors.primary,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    uploadImage(context);
                  }
                },
                loading: isLoading,
              ),
              SizedBox(
                height: 49.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {'userId': '${userId}', 'profile_status': '4'};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status_update',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print(response.statusMessage);
    }
  }
}
