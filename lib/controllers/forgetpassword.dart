import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/pages/otp_page/otp_screen.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../buisness_screens/buisness_controller/buisness_login/buisness_login.dart';
import '../custom_iteam/customforgetpassword.dart';
import '../function/function_class.dart';
import '../model/forget_model.dart';
import '../pages/otp_page/forgotOtpU.dart';
import '../validation/validation.dart';

class ForgetPassword extends StatefulWidget {
  final String? email;
  final String? code;
  final String? otp;
  final int? business;

  const ForgetPassword(
      {Key? key, this.email, this.code, this.otp, this.business})
      : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController ForgetController = TextEditingController();

  bool loading = false;
  bool seePassword = true;
  var isLoading = false;
  var OTP;
  var success, message, id, email, otp;

  get urlSegment => toMap();

  get sharedPreferences => ForgetController;
  RxBool isLoadig = false.obs;

  Future<forget_model> Forgetverify(context, int i) async {
    isLoadig(true);
    showLoaderDialog(context);
    Map toMap() {
      var map = new Map<String, dynamic>();
      map["email"] = ForgetController.text.toString();
      return map;
    }

    print(toMap());
    var response = await http.post(
      Uri.parse("https://forreal.net:4000/users/forgotPassword"),
      body: toMap(),
    );
    var Data = json.decode(response.body);
    print(Data);
    var a = Data['data'];
    print(a);
    if (Data['data'] == true) {
      Navigator.pop(context);

      try {
        if (urlSegment == "signUp") {
          sharedPreferences.setString("token");
        }
      } catch (e) {
        print(e);
      }

      Fluttertoast.showToast(
          msg: "Invalid OTP. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: HexColor('#ED1D22'),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    success = (forget_model.fromJson(json.decode(response.body)).success);
    message = (forget_model.fromJson(json.decode(response.body)).message);
    otp = (forget_model.fromJson(json.decode(response.body)).oTP);
    // otp = (forget_model.fromJson(json.decode(response.body)));
    print("success 123 ==${response.body}");
    if (success == true) {
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      if (i == 1) {
        Get.off(() => OtpPageForgot(otp: otp, mail: ForgetController.text
            // email: ForgetController.text.toString(),
            ));
      } else {
        Get.off(() => OtpPage(
              otp: otp, number: 0000000000.toString(),
              // email: ForgetController.text.toString(),
            ));
      }
    } else {
      Navigator.pop(context);
      print('else=====');
      Fluttertoast.showToast(
          msg: message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: HexColor('#ED1D22'),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    isLoadig(false);
    return forget_model.fromJson(json.decode(response.body));
  }

  Future<forget_model> ForgetverifyB(
    context,
  ) async {
    isLoadig(true);
    showLoaderDialog(context);
    Map toMap() {
      var map = new Map<String, dynamic>();
      map["email"] = ForgetController.text.toString();
      return map;
    }

    print(toMap());
    var response = await http.post(
      Uri.parse("https://forreal.net:4000/forgotPassword"),
      body: toMap(),
    );
    var Data = json.decode(response.body);
    print(Data);
    var a = Data['data'];
    print(a);
    if (Data['data'] == true) {
      Navigator.pop(context);

      try {
        if (urlSegment == "signUp") {
          sharedPreferences.setString("token");
        }
      } catch (e) {
        print(e);
      }

      Fluttertoast.showToast(
          msg: "Invalid OTP. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: HexColor('#ED1D22'),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    success = (forget_model.fromJson(json.decode(response.body)).success);
    message = (forget_model.fromJson(json.decode(response.body)).message);
    otp = (forget_model.fromJson(json.decode(response.body)).oTP);
    // otp = (forget_model.fromJson(json.decode(response.body)));
    print("success 123 ==${response.body}");
    if (success == true) {
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );

      Get.off(() => BuisnessLogin(
          // otp: otp, number: 0000000000.toString(),
          // email: ForgetController.text.toString(),
          ));
    } else {
      Navigator.pop(context);
      print('else=====');
      Fluttertoast.showToast(
          msg: message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: HexColor('#ED1D22'),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    isLoadig(false);
    return forget_model.fromJson(json.decode(response.body));
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Please Wait...")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 120),
                child: Image(
                    image: AssetImage(
                        'assets/images/AppIcon-120px-40pt@3x 1.png')),
              ),
              const SizedBox(height: 23),
              const Text(
                'Forgot Password?',
                style: CustomTextStyle.black,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: CustumForgetTextField(
                  controller: ForgetController,
                  validator: validateEmailField,
                  hintText: 'Email',
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      //Sign
                      if (widget.business == 1) {
                        ForgetverifyB(context);
                      } else {
                        Forgetverify(context, 1);
                      }
                    }
                    // else {
                    //   Fluttertoast.showToast(
                    //     msg: "Please Fill Email",
                    //     toastLength: Toast.LENGTH_LONG,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0,
                    //   );
                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(35)),
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Aboshi',
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    //  map["mobile"] = widget.mobile.toString();
    map["email"] = ForgetController.text.toString();

    return map;
  }
}
