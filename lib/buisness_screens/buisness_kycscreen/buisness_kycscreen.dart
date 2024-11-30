import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../function/function_class.dart';
import '../../widgets/custom_buttons.dart';
import 'kycApi_model.dart';

class BuisnessKycVerify extends StatefulWidget {
  const BuisnessKycVerify({Key? key}) : super(key: key);

  @override
  State<BuisnessKycVerify> createState() => _BuisnessKycVerifyState();
}

class _BuisnessKycVerifyState extends State<BuisnessKycVerify> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  // String? KYCBDOC;
  // String? KYCDOC;
  // String? CreateDeal;
//   final ReadSinglePostController _controller = Get.put(ReadSinglePostController());
//
// //and when you need to change you do like this:
//   _controller.updateID(newId);
  BusinessKycController businessKYCController = Get.put(BusinessKycController());
  var user_id;
  var status, message, data;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? myimage;

  Future? _future;
  String? _validatemobile = null;

  RxBool isLoadig = false.obs;

  String state = "";

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Please Wait...")),
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

  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  _asyncFileUpload(File file, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      user_id = prefs.get('user_id');
      // token = prefs.get('token');
      // print('user_id==============' + user_id!);
    });
    //create multipart request for POST or PATCH method
    isLoadig(true);
    showLoaderDialog(context);
    // check().then((intenet) {
    //   print('jyrtvkk');
    //   if (intenet) {
    //     // Internet Present Case
    //     showLoaderDialog(context);
    //   } else {
    //     Fluttertoast.showToast(
    //         msg: "Please check your Internet connection!!!!",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         backgroundColor: HexColor('#ED1D22'),
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    // });
    var request = http.MultipartRequest("POST", Uri.parse("https://forreal.net:4000/business_document_1"));
    //add text fields
    request.fields["business_id"] = user_id.toString();
    request.fields["document_name"] = "document_name";
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      var ress = await businessKYCController.asyncUploadInfo(File(businessKYCController.KYCDOC ?? ""));
      setState(() {
        state = ress.toString();
        print(ress);
      });
    }
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    isLoadig(false);
    return responseString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10),
        //   child: InkWell(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: SvgPicture.asset('assets/icons/btn.svg')),
        // ),
        title: const Text(
          'KYC Verification',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Business document',
                style: CustomTextStyle.black,
              ),
              const Text(
                'Scanned copy of business license or certificate of incorporation.',
                style: CustomTextStyle.blackyc,
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(children: [
                DottedBorder(
                  dashPattern: const [10, 5, 10, 5, 10, 5],
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: HexColor('#FB4967'),
                  child: businessKYCController.KYCBDOC == null
                      ? Container(
                          height: 141, width: 400,
                          decoration: const BoxDecoration(
                              //  borderRadius: BorderRadius.circular(10)
                              ),
                          //  borderRadius: BorderRadius.circular(10)
                        )
                      : Container(
                          height: 141,
                          width: 400,
                          decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(businessKYCController.KYCBDOC!)), fit: BoxFit.fill)
                              //  borderRadius: BorderRadius.circular(10)
                              ),
                        ),
                ),
                Container(
                  height: 141,
                  width: 400,
                  decoration: const BoxDecoration(
                      //  color: Colors.white
                      //  borderRadius: BorderRadius.circular(10)
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  SvgPicture.asset('assets/icons/file-plus.svg'),
                      InkWell(
                        onTap: () async {
                          final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
                          if (pickImage != null) {
                            setState(() {
                              businessKYCController.KYCBDOC = pickImage.path;
                            });
                          }
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/file-plus.svg'),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Upload document here', style: TextStyle(fontSize: 16, color: Colors.grey))
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 80),
              const Text(
                'Personal identification',
                style: CustomTextStyle.black,
              ),
              const Text(
                'Aadhaar or PAN or passport or driver’s license',
                style: CustomTextStyle.blackyc,
              ),
              const SizedBox(height: 30),
              Stack(children: [
                DottedBorder(
                  dashPattern: [10, 5, 10, 5, 10, 5],
                  strokeWidth: 2,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: HexColor('#FB4967'),
                  child: businessKYCController.KYCDOC == null
                      ? Container(
                          height: 141, width: 400,
                          decoration: const BoxDecoration(
                              //  borderRadius: BorderRadius.circular(10)
                              ),
                          //  borderRadius: BorderRadius.circular(10)
                        )
                      : Container(
                          height: 141,
                          width: 400,
                          decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(businessKYCController.KYCDOC!)), fit: BoxFit.fill)
                              //  borderRadius: BorderRadius.circular(10)

                              ),
                        ),
                ),
                Container(
                  height: 141,
                  width: 400,
                  decoration: const BoxDecoration(
                      //  color: Colors.white
                      //  borderRadius: BorderRadius.circular(10)
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  SvgPicture.asset('assets/icons/file-plus.svg'),
                      InkWell(
                        onTap: () async {
                          final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
                          if (pickImage != null) {
                            setState(() {
                              businessKYCController.KYCDOC = pickImage.path;
                            });
                          }
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/file-plus.svg'),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Upload document here', style: TextStyle(fontSize: 16, color: Colors.grey))
                    ],
                  ),
                ),
              ]),

              /*Padding(
                padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessProfile(),));
                  },
                  child: Container(
                    decoration: BoxDecoration(color:Colors.redAccent,
                        borderRadius: BorderRadius.circular(35)),
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: Center(
                      child: Text('Upload',style:TextStyle(
                          fontSize:18,fontWeight: FontWeight.w400,fontFamily: 'Aboshi',
                          color: Colors.white ),),
                    ),
                  ),
                ),
              ),*/

              const SizedBox(height: 10),
              customPrimaryBtn(
                btnText: "Upload",
                btnFun: () async {
                  if (businessKYCController.KYCBDOC!.isEmpty && businessKYCController.KYCDOC!.isEmpty) {
                    Fluttertoast.showToast(msg: 'Fill Documents first');
                  } else {
                    var res = await _asyncFileUpload(File(businessKYCController.KYCBDOC ?? ""), context);

                    setState(() {
                      state = res.toString();
                      print(res);
                    });
                  }

                  // genderController.selectGender();
                  // businessKYCController.uploadImage(businessKYCController.KYCBDOC??"","https://forreal.net:4000/business_document_1");
                  // businessKYCController.BusinessDocumentKycFunction();
                  /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BusinessProfile()));*/
                },
                //  loading: genderController.isLoadig.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
