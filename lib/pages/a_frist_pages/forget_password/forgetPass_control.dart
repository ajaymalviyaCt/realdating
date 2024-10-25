
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../login_page/login.dart';

class  ForgetOtpController extends GetxController {

  TextEditingController Codecontroller = TextEditingController();
  RxBool isLoadig =false.obs;

  final   formkey1 = GlobalKey<FormState>();
  var deviceType;

  @override
  void onReady() {
    super.onReady();
  }

  otpverify(String mobileNo)async{



    print("loginwithEmail");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.email_verifcation,{
      'OTP': '${Codecontroller.value.text}',
      'email': '$mobileNo'
    }
    );
    print(response);
    isLoadig(false);
    bool success= response["success"];
    if(success){
      Get.to(()=>LoginScreenPage());
      Codecontroller.clear();
    }

    var msg= response["message"];
    print( "msg ___$msg");
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      gravity:ToastGravity.BOTTOM,
      backgroundColor:HexColor('#ED1D22'),
      textColor:Colors.white,
      fontSize:16.0,
    );
  }
}

