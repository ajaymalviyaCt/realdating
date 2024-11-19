import 'dart:io';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/pages/a_frist_pages/height_dob/heught_dob_page.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../consts/app_colors.dart';
import '../../../function/function_class.dart';
import '../../../widgets/custom_appbar.dart';
import '../location_enable/loctaion.dart';
import 'package:http/http.dart' as http;


// class AddYourPhotosPage extends StatefulWidget {
//   const AddYourPhotosPage({Key? key}) : super(key: key);
//
//   @override
//   State<AddYourPhotosPage> createState() => _AddYourPhotosPageState();
// }
//
// class _AddYourPhotosPageState extends State<AddYourPhotosPage> {
//   @override
//   Widget build(BuildContext context) {
//
//
//     return  Scaffold(
//       appBar: customAppbar("Add your photoss",context),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 30),
//           Padding(
//             padding: const EdgeInsets.only(left: 12.0),
//             child: customTextCommon(text: 'Upload 2 Photos to start. Add 4 or more to '
//                 '\nmake your profile stand out.', fSize: 16, fWeight: FontWeight.w400, lineHeight: 24),
//           ),
//           SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Stack(
//                   children: [
//                     Container(
//                       height:130,width: 103,
//                       decoration: BoxDecoration(
//                           color:Appcolor.backgroundclr,
//                           border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(image: AssetImage('assets/images/image.png',),fit: BoxFit.cover)
//                       ),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(top: 105,left: 80),
//                       child: SvgPicture.asset('assets/icons/Sign In Button.svg'),
//                     ),
//                   ]
//               ),
//
//               Stack(
//                 children: [
//                   Container(
//                     height:130,width: 103,
//                     decoration: BoxDecoration(
//                       color:Appcolor.backgroundclr,
//                       border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   Padding(
//                     padding:  EdgeInsets.only(top: 105,left: 80),
//                     child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),
//                   ),
//                 ],
//               ),
//
//               Stack(
//                   children: [
//                     Container(
//                       height:130,width: 103,
//                       decoration: BoxDecoration(
//                           color:Appcolor.backgroundclr,
//                           border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(top: 105,left: 80),
//                       child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),),
//                   ]
//               ),
//             ],
//           ),
//
//           SizedBox(height: 20),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Stack(
//                   children: [
//                     Container(
//                       height:130,width: 103,
//                       decoration: BoxDecoration(
//                           color:Appcolor.backgroundclr,
//                           border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(top: 105,left: 80),
//                       child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),),
//                   ]
//               ),
//               Stack(
//                   children: [
//                     Container(
//                       height:130,width: 103,
//                       decoration: BoxDecoration(
//                           color:Appcolor.backgroundclr,
//                           border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(top: 105,left: 80),
//                       child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),),
//                   ]
//               ),
//               Stack(
//                   children: [
//                     Container(
//                       height:130,width: 103,
//                       decoration: BoxDecoration(
//                           color:Appcolor.backgroundclr,
//                           border: Border.all(style: BorderStyle.solid,color: Colors.redAccent),
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(top: 105,left: 80),
//                       child: SvgPicture.asset('assets/icons/Sign In Button (1).svg'),),
//                   ]
//               ),
//             ],
//           ),
//
//           InkWell(
//             onTap: ()async{
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               prefs.setBool("isLoggedIn", true);
//               Get.to(()=>LocationScreen());
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20,vertical:80),
//               child: Container(
//                 decoration: BoxDecoration(color:Colors.redAccent,
//                     borderRadius: BorderRadius.circular(35)),
//                 width: MediaQuery.of(context).size.width,
//                 height: 56,
//                 child: Center(
//                   child: Text('Continue',style:TextStyle(
//                       fontSize:18,fontWeight: FontWeight.w400,fontFamily: 'Aboshi',
//                       color: Colors.white ),),
//                 ),
//               ),
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }

///////////////////////AddYourPhotoPage/////////////////////////AddYourPhotoPage/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AddYourPhotoPage extends StatefulWidget {
  const AddYourPhotoPage({Key? key}) : super(key: key);

  @override
  State<AddYourPhotoPage> createState() => _AddYourPhotoPageState();
}

class _AddYourPhotoPageState extends State<AddYourPhotoPage> {
  bool isLoading = false;

  void uploadImage(context) async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest("POST", Appurls.addYourPhotoas);
    // request.fields['user_id'] = stringValue.toString();

    for (var file in selectedImages) {
      String fileName = file.path.split("/").last;
      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFileSign = http.MultipartFile('files', stream, length, filename: fileName);request.files.add(multipartFileSign);
    }

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Fluttertoast.showToast(
            msg: "Add Your Photos Sucessfully",
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => HeightDOBpage(),));
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

  List<File> selectedImages = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Scaffold(
      appBar: customAppbar("Add Your Photos", context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              ///////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedImages.length > 0
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[0]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                            // hobbiesController.interestSelect();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages.length > 1
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[1]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages.length > 2
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[2]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedImages.length > 3
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[3]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages.length > 4
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[4]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                  selectedImages.length > 5
                      ? Stack(children: [
                          Container(
                            height: 130,
                            width: 103,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffBDBDBD).withOpacity(0.35),
                                image: DecorationImage(
                                    image: FileImage(selectedImages[5]),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(top: 105, left: 80),
                            child: SvgPicture.asset(
                                'assets/icons/Sign In Button (1).svg'),
                          ),
                        ])
                      : InkWell(
                          onTap: () {
                            getImages();
                          },
                          child: Stack(children: [
                            Container(
                              height: 130,
                              width: 103,
                              decoration: BoxDecoration(
                                color: Appcolor.backgroundclr,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.only(top: 105, left: 80),
                              child: SvgPicture.asset(
                                  'assets/icons/Sign In Button (1).svg'),
                            ),
                          ]),
                        ),
                ],
              ),

              Spacer(),
              customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  if (selectedImages.length == 0) {
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

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
        List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));

          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {
      'userId': '${userId}',
      'profile_status': '4'
    };
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
    }
    else {
      print(response.statusMessage);
    }

  }






}
