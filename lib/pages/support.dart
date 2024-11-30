import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/pages/dash_board_page.dart';
import 'package:realdating/validation/validation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../button.dart';
import '../const.dart';
import '../consts/app_urls.dart';
import '../custom_iteam/coustomtextcommon.dart';
import '../custom_iteam/customprofile_textfiiled.dart';
import '../function/function_class.dart';
import '../services/base_client01.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var firstname, lastname, mobile, email, status, message, data;
  String? CreateDeal;
  String? myimage;
  String? user_id = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var reasonValidation = true;
  RxBool isLoadig = false.obs;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
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

  /*void uploadFileToServerInfluencer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    setState(() {
      // user_id = prefs.getString('user_id');
      //  print('user_id==============' + user_id!);
    });
    print("CLICKED 123 ==");

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (_connectionStatus != null) {
      // Internet Present Case
      showLoaderDialog(context);
    } else {
      Fluttertoast.showToast(
          msg: "Please check your Internet connection!!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }

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
  }*/

  supportFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    print("signwithBuissEmail");
    isLoadig(true);

    final response = await BaseClient01().post(
      Appurls.supportUri,
      {
        'name': nameController.value.text,
        'email': emailController.value.text,
        'user_id': userId.toString(),
        'message': messageController.value.text,
      },
    );

    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];

    if (success) {
      nameController.clear();
      emailController.clear();
      messageController.clear();
      Get.off(() => const DashboardPage());

      /*  buisnessnameController.clear();
      bphonenoController.clear();
      bemailController.clear();
      bpasswordcontroller.clear();*/
/*      cityValue = null;
      stateValue = "";
      countryValue = null;*/
      // categoryController.clear();
    }
    print("msg ___$msg");
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/icons/btn.svg')),
          ),
          title: const Text(
            'For Real Support',
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 30,
                ),
                customTextC(text: "Name", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                SizedBox(
                  height: 70,
                  child: TextFormField(
                    validator: validateName,
                    controller: nameController,
                    // maxLines: 1,
                    // Set the maximum number of lines for input
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black12,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black12,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.red,
                          )),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                      hintText: 'Please Enter Name',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
                    ),
                  ),
                ),
                customTextC(text: "Email", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                SizedBox(
                  height: 70,
                  child: CustumProfileTextField1(
                    controller: emailController,
                    validator: validateEmailField,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Please Enter Email',
                  ),
                ),
                customTextC(text: "Message", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                SizedBox(
                  // height: 70,
                  child: TextFormField(
                    validator: notEmptyMsgValidator,
                    controller: messageController,
                    maxLines: 4,
                    // Set the maximum number of lines for input
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black12,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black12,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.red,
                          )),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                      hintText: 'Type your message here...',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
                    ),
                  ),
                ),
                /*  Obx(
                          () => CustumTextField(
                        onTap: () {
                          loginController.seePassword.value =
                          !loginController.seePassword.value;
                        },
                        controller: loginController.passwordController,
                        validator: validatePassword,
                        suffixIconn: loginController.seePassword == true
                            ? 'assets/icons/Eye Slash.svg'
                            : 'assets/icons/eye.svg',
                        hintText: 'Password',
                        obscureText: loginController.seePassword.value,
                      ),
                    ),*/

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
        ));
  }

  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Button(
        btnColor: Colors.redAccent,
        buttonName: 'Send',
        btnstyle: textstylesubtitle2(context)!.copyWith(color: colorWhite, fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // uploadFileToServerInfluencer();
            supportFunction();
          }
        },
      ),
    );
  }
}
