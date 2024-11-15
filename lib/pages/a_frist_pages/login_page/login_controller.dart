// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../chat/api/apis.dart';
// import '../../../consts/app_urls.dart';
// import '../../../services/base_client01.dart';
// import '../add_your_photos/add_your_photos.dart';
// import '../gender/gender.dart';
// import '../height_dob/heught_dob_page.dart';
// import 'package:realdating/pages/dash_board_page.dart';
// import '../hobbies/hobbys.dart';
// import '../interest/interest.dart';
// import '../location_enable/loctaion.dart';
//
//
// class LoginController extends GetxController {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   RxBool isLoadig = false.obs;
//   RxBool seePassword = true.obs;
//
//   final formkey1 = GlobalKey<FormState>();
//   var deviceType;
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   loginwithEmail() async {
//     isLoadig(true);
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     try {
//       final response = await BaseClient01().post(Appurls.userLogin, {
//         "email": emailController.text.trim(),
//         "password": passwordController.text,
//         "fcm_token": fcmToken
//       });
//       isLoadig(false);
//       bool success = response["success"];
//       var msg = response["message"];
//       if (success) {
//         signIn();
//         var token = response["token"];
//         var user_id1 = response["user_info"]["id"];
//         var email = response["user_info"]["email"];
//         var profile_status = response["user_info"]["profile_status"];
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         APIs.updateUserInfo("$fcmToken","$user_id1");
//         Fluttertoast.showToast(
//           msg: "$msg",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.white,
//           textColor: Colors.black,
//           fontSize: 16.0,
//         );
//         prefs.setBool("isLoggedInUser", true);
//         if (profile_status == 0) {
//           Get.to(() => SelectGenderPage());
//         }
//         if (profile_status == 1) {
//           Get.to(() => Interest_Screen());
//         }
//         if (profile_status == 2) {
//           Get.to(() => HobbiesPage());
//         }
//         if (profile_status == 3) {
//           Get.to(() => AddYourPhotoPage());
//         }
//         if (profile_status == 4) {
//           Get.to(() => LocationScreen());
//         }
//         if (profile_status == 5) {
//           Get.to(() => const HeightDOBpage());
//         }
//         if (profile_status == 6) {
//           Get.to(() => const DashboardPage());
//         }
//
//         prefs.setInt('user_id', user_id1);
//         prefs.setInt('profile_status', profile_status);
//         prefs.setString('token', token);
//         prefs.setInt("page", 1);
//         prefs.setString("email", email);
//       } else {
//         Fluttertoast.showToast(
//           msg: "$msg",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.white,
//           textColor: Colors.black,
//           fontSize: 16.0,
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "$e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.white,
//         textColor: Colors.black,
//         fontSize: 16.0,
//       );
//     }
//
//     // DialogHelper.snackbar(msg);
//   }
//
//   Future signIn() async {
//
//
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text,
//       ).then((value) {
//         getCurrentUserProfile();
//       });
//     } catch (e) {
//       print("FirebaseAuth errorr=====>$e");
//     }
//   }
//
//   Future<void> getCurrentUserProfile() async{
//     User? user=FirebaseAuth.instance.currentUser;
//     try
//     {
//       await FirebaseFirestore.instance.collection('allusers').doc(user!.uid).get().then((value) {
//         user.updateDisplayName(value.data()!['name']);
//         // user.updatePhotoURL(value.data()!['image']);
//         user.updateEmail(value.data()!['email']);
//         // Get.offAll(()=>const HomePage());
//       });
//     }
//     catch(e) {
//
//      }
//   }
//
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../chat/api/apis.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../add_your_photos/add_your_photos.dart';
import '../gender/gender.dart';
import '../height_dob/heught_dob_page.dart';
import 'package:realdating/pages/dash_board_page.dart';
import '../hobbies/hobbys.dart';
import '../interest/interest.dart';
import '../location_enable/loctaion.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoadig = false.obs;
  RxBool seePassword = true.obs;

  var deviceType;

  @override
  void onReady() {
    super.onReady();
  }

  // loginwixxxthEmail() async {
  //   isLoadig(true);
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   try {
  //     final response = await BaseClient01().post(Appurls.userLogin, {
  //       "email": emailController.text.trim(),
  //       "password": passwordController.text,
  //       "fcm_token": fcmToken
  //     });
  //     isLoadig(false);
  //     bool success = response["success"];
  //     var msg = response["message"];
  //     if (success) {
  //       signIn();
  //       var token = response["token"];
  //       var user_id1 = response["user_info"]["id"];
  //       var email = response["user_info"]["email"];
  //       var profile_status = response["user_info"]["profile_status"];
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.clear();
  //       prefs.setInt('user_id', user_id1);
  //       prefs.setInt('profile_status', profile_status);
  //       prefs.setInt('user_id', user_id1);
  //       prefs.setString('token', token);
  //       prefs.setInt("page", 1);
  //       prefs.setString("email", email);
  //
  //       APIs.updateUserInfo("$fcmToken","$user_id1");
  //       Fluttertoast.showToast(
  //         msg: "$msg",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.white,
  //         textColor: Colors.black,
  //         fontSize: 16.0,
  //       );
  //         prefs.setBool("isLoggedInUser", true);
  //         if (profile_status == 0) {
  //           Get.to(() => SelectGenderPage());
  //         }
  //         if (profile_status == 1) {
  //           Get.to(() => Interest_Screen());
  //         }
  //         if (profile_status == 2) {
  //           Get.to(() => HobbiesPage());
  //         }
  //         if (profile_status == 3) {
  //           Get.to(() => AddYourPhotoPage());
  //         }
  //         if (profile_status == 4) {
  //           Get.to(() => LocationScreen());
  //         }
  //         if (profile_status == 5) {
  //           Get.to(() => const HeightDOBpage());
  //         }
  //         if (profile_status == 6) {
  //           Get.to(() => const DashboardPage());
  //         }
  //
  //
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "$msg",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.white,
  //         textColor: Colors.black,
  //         fontSize: 16.0,
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "$e",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 16.0,
  //     );
  //   }
  //
  //   // DialogHelper.snackbar(msg);
  // }
  loginWithEmail() async {
    isLoadig(true);
    String? fcmToken;

    try {
       fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      // TODO
    }
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'fcm_token': (fcmToken??"").toString()
      };
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/users/loginUser',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        isLoadig(false);
        print("pramod${response.data}");
        Fluttertoast.showToast(msg: response.data["message"]);
        var status = response.data["status"];

        if ("$status" == "200") {
          var profile_status = response.data["user_info"]["profile_status"];
          String token = response.data["token"];
          int user_id = response.data["user_info"]["id"];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", token);
          prefs.setInt("user_id", user_id);
          if (profile_status == 0) {
            Get.offAll(() => SelectGenderPage());
          }
          if (profile_status == 1) {
            Get.offAll(() => Interest_Screen());
          }
          if (profile_status == 2) {
            Get.offAll(() => HobbiesPage());
          }
          if (profile_status == 3) {
            Get.offAll(() => AddYourPhotoPage());
          }
          if (profile_status == 4) {
            Get.offAll(() => const HeightDOBpage());
          }
          if (profile_status == 5) {
            prefs.setBool("isLogin", true);
            Get.offAll(() => LocationScreen());
          }
          if (profile_status == 6) {
            prefs.setBool("isLogin", true);
            Get.offAll(() => const DashboardPage());
          }
        }
      } else {
        Fluttertoast.showToast(msg: response.data["message"]);
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
      // Fluttertoast.showToast(
      //   msg: "$e",
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      //   fontSize: 16.0,
      // );
    }

    // DialogHelper.snackbar(msg);
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      )
          .then((value) {
        getCurrentUserProfile();
      });
    } catch (e) {
      print("FirebaseAuth errorr=====>$e");
    }
  }

  Future<void> getCurrentUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('allusers')
          .doc(user!.uid)
          .get()
          .then((value) {
        user.updateDisplayName(value.data()!['name']);
        // user.updatePhotoURL(value.data()!['image']);
        user.updateEmail(value.data()!['email']);
        // Get.offAll(()=>const HomePage());
      });
    } catch (e) {}
  }
}
