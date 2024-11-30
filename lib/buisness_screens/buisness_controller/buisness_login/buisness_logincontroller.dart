import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/base_client01.dart';
import '../../buisness_home/Bhome_page/buisness_home.dart';
import '../../buisness_kycscreen/buisness_kycscreen.dart';

class BuisnessLoginController extends GetxController {
  TextEditingController buisnessemailController = TextEditingController();
  TextEditingController buisnesspasswordController = TextEditingController();
  RxBool isLoadig = false.obs;
  RxBool seePassword = true.obs;

  final formkey1 = GlobalKey<FormState>();
  var deviceType;


  RxBool isLoadigLogin = false.obs;

  BussinessloginwithEmail() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      isLoadigLogin(true);
      final response = await BaseClient01().post(Uri.parse("https://forreal.net:4000/loginbusiness"),
          {"email": buisnessemailController.text.trim(), "password": buisnesspasswordController.text, "fcm_token": fcmToken});
      bool success = response["success"];
      String msg = response["message"];
      if (success) {
        var token = response["token"];
        var userId1 = response["business_info"]["id"];
        var email = response["business_info"]["email"];
        var verifyBusiness = response["business_info"]["verify_business"];
        var KYC = response["business_info"]["KYC"];
        var businessName = response["business_info"]["business_name"];
        var profileImage = response["business_info"]["profile_image"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoginB", true);
        prefs.setInt('user_id', userId1);
        prefs.setString('token', token);
        prefs.setInt("page", 1);
        prefs.setString("email", email);
        print(prefs.get("isLoggedIn"));

        if (KYC == 1) {
          return Get.to(() => const BuisnessHomePage());
        } else {
          return Get.to(() => const BuisnessKycVerify());
        }
      } else {
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    } catch (e, s) {
      isLoadigLogin(false);

      print("msg ___$s");
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
    isLoadigLogin(false);
  }
}
