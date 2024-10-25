import 'dart:async';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/validation/validation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../button.dart';
import '../../const.dart';
import '../../custom_iteam/coustomtextcommon.dart';
import '../../custom_iteam/customprofile_textfiiled.dart';
import '../../function/function_class.dart';
import '../buisness_home/Bhome_page/buisness_home.dart';

class CreateAads extends StatefulWidget {
  const CreateAads({Key? key}) : super(key: key);

  @override
  State<CreateAads> createState() => _CreateAadsState();
}

class _CreateAadsState extends State<CreateAads> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var firstname, lastname, mobile, email, status, message, data;
  String? CreateDeal;
  String? myimage;
  String? user_id = "";

  TextEditingController txt_title = TextEditingController();
  TextEditingController txt_age = TextEditingController();
  TextEditingController txt_interest = TextEditingController();
  TextEditingController txt_budget = TextEditingController();
  TextEditingController txt_campaign_duration = TextEditingController();
  TextEditingController txt_location = TextEditingController();
  TextEditingController txt_range = TextEditingController();
  TextEditingController txt_link = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    // _connectivitySubscription?.cancel();
    super.dispose();
  }

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

  void uploadFileToServerInfluencer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    setState(() {
      // user_id = prefs.getString('user_id');
      //  print('user_id==============' + user_id!);
    });
    print("CLICKED 123 ==");
    //
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
    showLoaderDialog(context);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://forreal.net:4000/create_ads"),
    );

    request.fields['title'] = txt_title.text.toString();
    request.fields['age'] = txt_age.text.toString();
    request.fields['interest'] = txt_interest.text.toString();
    request.fields['budget'] = txt_budget.text.toString();
    request.fields['campaign_duration'] = txt_campaign_duration.text.toString();
    request.fields['address'] = txt_location.text.toString();
    request.fields['link'] = txt_link.text.toString();
    request.fields['range_km'] = txt_range.text.toString();
    //request.fields['business_id'] = user_id.toString();
    request.fields['business_id'] = userId.toString();

    if (CreateDeal == null) {
      request.fields['file'] = "";
    } else {
      request.files.add(await http.MultipartFile.fromPath('file', CreateDeal!));
    }
    print("??????????????${request.fields.toString()}");
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        if(response.statusCode==200) {
          print("response.statusCod");
          print(onValue.body);
          Get.off(() => BuisnessHomePage());
          // Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Ads created successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong....",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: const Color(0xffC83760),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/icons/btn.svg')),
          ),
          title: const Text(
            'Create Ads',
            style: CustomTextStyle.black,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    customTextC(
                        text: "Upload Image",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CreateDeal == null
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor('#D9D9D9'),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ))
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 135,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: HexColor('#D9D9D9'),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: FileImage(File(CreateDeal!)),
                                          fit: BoxFit.fill)),
                                ),
                        ),
                        Container(
                          height: 141,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final XFile? pickImage = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 10);
                                  final croppedFile = await ImageCropper().cropImage(
                                    sourcePath: pickImage!.path,

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
                                      CreateDeal = croppedFile.path;
                                    });
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/image-add (1).svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text('Upload Image',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey))
                            ],
                          ),
                        ),
                      ],
                    ),
                    customTextC(
                        text: "Title",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileTextField1(
                        controller: txt_title,
                        validator: validateTitle,
                        hintText: 'Please Enter Title',
                      ),
                    ),
                    customTextC(
                        text: "Age",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileAgeTextField1(
                        controller: txt_age,
                        validator: validateage,
                        hintText: 'Enter Age',
                      ),
                    ),
                    customTextC(
                        text: "Interest",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileTextField1(
                        controller: txt_interest,
                        validator: validateIntrest,
                        hintText: 'Enter Interest ',
                      ),
                    ),
                    customTextC(
                        text: "Budget",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileAgeTextField1(
                        controller: txt_budget,
                        validator: validateBudget,
                        hintText: 'Enter Budget ',
                      ),
                    ),
                    customTextC(
                        text: "  Campaign Duration",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileTextField1(
                        controller: txt_campaign_duration,
                        validator: validateCampaign,
                        hintText: 'Enter Campaign Duration ',
                      ),
                    ),
                    customTextC(
                        text: "Location",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileTextField1(
                        controller: txt_location,
                        validator: validateLocation,
                        hintText: 'Enter Location ',
                      ),
                    ),
                    customTextC(
                        text: "Range (Miles)",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileAgeTextField1(
                        controller: txt_range,
                        validator: validateRange,
                        hintText: 'Enter Range ',
                      ),
                    ),
                    customTextC(
                        text: "Link",
                        fSize: 16,
                        fWeight: FontWeight.w500,
                        lineHeight: 36),
                    SizedBox(
                      height: 70,
                      child: CustumProfileTextField1(
                        controller: txt_link,
                        validator: validateLink,
                        hintText: 'Enter Link ',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    updateBtn(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ]),
            ),
          ),
        ));
  }

  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Button(
        btnColor: Colors.redAccent,
        buttonName: 'CREATE',
        btnstyle: textstylesubtitle2(context)!
            .copyWith(color: colorWhite, fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            uploadFileToServerInfluencer();
          }
        },
      ),
    );
  }
}
