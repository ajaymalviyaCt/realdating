import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../login_page/login.dart';

class ChangePasswordController extends GetxController {
  TextEditingController OldPassword = TextEditingController();
  TextEditingController NPassword = TextEditingController();
  TextEditingController CPassword = TextEditingController();

  RxBool isLoadig = false.obs;

  RxBool OldPassowrdsee = true.obs;
  RxBool NewPassowrdsee = true.obs;
  RxBool ConfirmPassowrdsee = true.obs;

  final formkey1 = GlobalKey<FormState>();
  var deviceType;


  loginwithEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString("email");
    print('user email---------$email');
    print("loginwithEmail");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.changepassword, {
      "email": email,
      "password": NPassword.value.text,
      "old_password": OldPassword.value.text,
      "confirm_password": CPassword.value.text,
    });
    print(response);
    isLoadig(false);

    bool success = response["success"];
    if (success) {
      Get.back();
      Get.back();
    }
    var msg = response["message"];
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
    // DialogHelper.snackbar(msg);
  }

  newPasswordApi(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("loginwithEmail");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.newPassword, {
      "email": email,
      "new_password": NPassword.value.text,
      "confirm_password": CPassword.value.text,
    });
    print(response);
    isLoadig(false);

    bool success = response["success"];
    if (success) {
      Get.to(() => const LoginScreenPage());
      // Get.back();
    }
    var msg = response["message"];
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
    // DialogHelper.snackbar(msg);
  }
}
