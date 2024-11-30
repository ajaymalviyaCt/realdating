import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:realdating/validation/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final RxList<String> selectedInterest = <String>[].obs;

  bool showDropdown = false;
  bool isLoading = false;
  List<String> interestList = ['Music', 'Dancing', 'Cricket', 'Movie', 'Photography', 'Gaming'];

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
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
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
    Map<String, dynamic> apiData = await ApiCall.instance.callApi(
        method: HttpMethod.POST,
        headers: await authHeader(),
        url: "https://forreal.net:4000/create_ads",
        body: dio.FormData.fromMap({
          "title": txt_title.text.toString(),
          "interest": txt_interest.text.toString(),
          "budget": txt_budget.text.toString(),
          "campaign_duration": txt_campaign_duration.text.toString(),
          "address": txt_location.text.toString(),
          "link": txt_link.text.toString(),
          "range_km": txt_range.text.toString(),
          "business_id": userId.toString(),
          if (CreateDeal != null) "file": (await dio.MultipartFile.fromFile(CreateDeal!, filename: "${DateTime.now().toUtc().toIso8601String()}.jpg"))
        }));
    if (apiData["success"] == true) {
      Get.off(() => BuisnessHomePage());
      // Navigator.pop(context);
      Fluttertoast.showToast(
          msg: apiData["message"],
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
/*
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://forreal.net:4000/create_ads"),
    );

    request.fields['title'] = txt_title.text.toString();
    // request.fields['age'] = txt_age.text.toString();
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
        if (response.statusCode == 200) {
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

    */
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
            'Create Ad',
            style: CustomTextStyle.black,
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            showDropdown = false;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 30,
                  ),
                  customTextC(text: "Upload Image", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
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
                                    image: DecorationImage(image: FileImage(File(CreateDeal!)), fit: BoxFit.fill)),
                              ),
                      ),
                      Container(
                        height: 141,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
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
                            const Text('Upload Image', style: TextStyle(fontSize: 16, color: Colors.grey))
                          ],
                        ),
                      ),
                    ],
                  ),
                  customTextC(text: "Title", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileTextField1(
                      controller: txt_title,
                      validator: validateTitle,
                      hintText: 'Please Enter Title',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  // customTextC(
                  //     text: "Age(in years)",
                  //     fSize: 16,
                  //     fWeight: FontWeight.w500,
                  //     lineHeight: 36),
                  // SizedBox(
                  //   height: 70,
                  //   child: CustumProfileAgeTextField1(
                  //     controller: txt_age,
                  //     validator: validateage,
                  //     hintText: 'Enter Age',
                  //   ),
                  // ),
                  customTextC(text: "Interest", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                  TextField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: txt_interest,
                    readOnly: true,
                    // Prevent manual typing
                    onTap: () {
                      setState(() {
                        showDropdown = !showDropdown; // Toggle dropdown
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Select Interest",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(.15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(.15),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black.withOpacity(.15)),
                        onPressed: () {
                          setState(() {
                            if (interestList.isEmpty) {
                              print('Category Index-----${interestList}');
                              Fluttertoast.showToast(msg: 'Interest Not found');
                            } else {
                              showDropdown = !showDropdown;
                            }
                          });
                        },
                      ),
                    ),
                    cursorColor: Colors.white,
                  ),
                  if (showDropdown)

interestDropdownUi(),


                  // SizedBox(
                  //   height: 70,
                  //   child: CustumProfileTextField1(
                  //     controller: txt_interest,
                  //     validator: validateIntrest,
                  //     hintText: 'Enter Interest $ ',
                  //   ),
                  // ),

                  customTextC(text: "Budget(\$)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileAgeTextField1(
                      controller: txt_budget,
                      validator: validateBudget,
                      hintText: 'Enter Budget ',
                    ),
                  ),
                  customTextC(text: "  Campaign Duration(in days)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileTextField1(
                      controller: txt_campaign_duration,
                      validator: validateCampaign,
                      hintText: 'Enter Campaign Duration',
                    ),
                  ),
                  customTextC(text: "Location", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileTextField1(
                      controller: txt_location,
                      validator: validateLocation,
                      hintText: 'Enter Location ',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  customTextC(text: "Range (Miles)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileAgeTextField1(
                      controller: txt_range,
                      validator: validateRange,
                      hintText: 'Enter Range ',
                    ),
                  ),
                  customTextC(text: "Link", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 70,
                    child: CustumProfileTextField1(
                      controller: txt_link,
                      validator: validateLink,
                      hintText: 'Enter Link ',
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  updateBtn(context),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
                ]),
              ),
            ),
          ),
        ));
  }

  Container interestDropdownUi() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: isLoading
          ? const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      )
          : Stack(
        children: [
          // Main Dropdown Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4), // Shadow position for soft floating effect
                ),
              ],
            ),
            child: Column(
              children: [
                // Close Button at the top-right with a subtle elegant design
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showDropdown = false; // Close dropdown on tap
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Transparent to make it less intrusive
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.redAccent, // Use accent color for contrast
                          size: 24, // Adjust size for a more prominent close button
                        ),
                      ),
                    ),
                  ),
                ),
                // Dropdown List View
                Container(
                  height: 300, // Set height for scrollable list
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: interestList.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedInterest.contains(interestList[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!isSelected) {
                              selectedInterest.add(interestList[index]);
                            } else {
                              selectedInterest.remove(interestList[index]);
                            }
                            txt_interest.text = selectedInterest.join(", ");
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.red.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.redAccent
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                interestList[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.redAccent.shade700
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.redAccent,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Button(
        btnColor: Colors.redAccent,
        buttonName: 'CREATE',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite, fontFamily: 'Poppins'),
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
