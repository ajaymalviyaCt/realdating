import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import '../a_frist_pages/login_page/login.dart';
import '../newPassword.dart';

class OtpController extends GetxController {
  TextEditingController Codecontroller = TextEditingController();
  RxBool isLoadig = false.obs;

  final formkey1 = GlobalKey<FormState>();
  var deviceType;

  @override
  void onReady() {
    super.onReady();
  }

  otpverify(String mobileNo) async {
    print("loginwithEmail");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.otp_verifcation,
        {'code': '${Codecontroller.value.text}', 'phone_number': '$mobileNo'});
    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];
    var otp = response["OTP"];

    print("msg ___$msg");
    print("otp ___$otp");
    if (success) {
      Get.to(() => LoginScreenPage());
      Codecontroller.clear();
      Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // mobileNo=null;
    }else{

      Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: HexColor('#ED1D22'),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

  }


  otpverifyForgot(email) async {
    print("loginwithEmail");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.email_verifcation,
        {'OTP': '${Codecontroller.value.text}','email': '${email}'});
    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];
    var otp = response["OTP"];
    var mail = response["email"];

    print("msg ___$msg");
    print("otp ___$otp");
    if (success) {
      Get.to(() => NewPasswordPage( email: email,));
      Codecontroller.clear();
      Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // mobileNo=null;
    }else{

      Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: HexColor('#ED1D22'),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

  }
}
