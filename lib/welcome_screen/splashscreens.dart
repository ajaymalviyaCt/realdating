import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/welcome_screen/onbording.dart';
import 'package:get/get.dart';
import 'package:realdating/welcome_screen/onbording.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import '../messaing_service/messaging_service.dart';
import '../pages/a_frist_pages/add_your_photos/add_your_photos.dart';
import '../pages/a_frist_pages/gender/gender.dart';
import '../pages/a_frist_pages/height_dob/heught_dob_page.dart';
import '../pages/a_frist_pages/hobbies/hobbys.dart';
import '../pages/a_frist_pages/interest/interest.dart';
import '../pages/dash_board_page.dart';
import 'optionButton.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  final _messagingService = MessagingService(); // Instance of MessagingService for handling notifications
  var profile_status;

  @override
  void initState() {
    _messagingService.init(context);
    MessagingService.localNotiInit(context);
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isShowOnboarding = prefs.getBool("isShowOnboarding") ?? true;
      bool isLogin = prefs.getBool("isLogin") ?? false;
      bool isLoginB = prefs.getBool("isLoginB") ?? false;

      if (isShowOnboarding) {
        Get.offAll(() => const Onbording());
      } else if (isLogin) {
        Get.offAll(const DashboardPage());
      } else if (isLoginB) {
        Get.offAll(() => const BuisnessHomePage());
      } else {
        print("optionScreen");
        Get.offAll(() => const OptionScreen());
      }
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool? isFirstTime = prefs.getBool("firstTimeOnApp");
      // var user_id = prefs.getInt('user_id');
      // bool? isLoggedIn = prefs.getBool('isLoggedIn');
      // bool? isLoggedInU = prefs.getBool('isLoggedInUser');
      // if (isFirstTime == null  && isLoggedInU == null) {
      //   prefs.setBool("firstTimeOnApp", true);
      //   Get.off(() => const Onbording());
      // } else if (
      // isFirstTime == true && isLoggedIn == false && isLoggedInU == false) {
      //   print("xcvb");
      //   return Get.off(() => const OptionScreen());
      // } else if (isFirstTime == true && isLoggedInU == true) {
      //   print("gdfgfgfdgdfggfdg");
      //   return Get.off(() => const DashboardPage());
      // } else if (isFirstTime == true && isLoggedIn == true) {
      //   Get.off(() => const BuisnessHomePage());
      // } else {
      //   Get.off(() => const BuisnessLogin());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        top: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            Image.asset(
              'assets/images/Background 1.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                const SizedBox(height: 20 /**/),
                SvgPicture.asset(
                  'assets/icons/face-smile-regular .svg',
                  fit: BoxFit.none,
                  color: Colors.white,
                  height: 34,
                  width: 34,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 55),
                        child: Center(child: Image(image: AssetImage('assets/images/Foreground.png'), fit: BoxFit.none, height: 400, width: 300)),
                      ),
                      Image(image: AssetImage('assets/images/Background Pattern.png'), fit: BoxFit.fill),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> getprofileSatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt("user_id");
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var data = {'userId': user_id.toString()};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      print("user_id==${user_id.toString()}");
      print("response==${response.data}");
      profile_status = response.data["profile_status"];
      profile_satuss(profile_status);
    } else {}
  }

  void profile_satuss(var profile_status) {
    print("prfsdfdfdsfsdfdsfsdfsf$profile_status");
    if (profile_status == 0) {
      Get.to(() => SelectGenderPage());
    }
    if (profile_status == 1) {
      Get.to(() => Interest_Screen());
    }
    if (profile_status == 2) {
      Get.to(() => HobbiesPage());
    }
    if (profile_status == 3) {
      Get.to(() => AddYourPhotoPage());
    }
    if (profile_status == 4) {
      Get.to(() => HeightDOBpage());
    }
    if (profile_status == 5) {
      Get.to(() => const DashboardPage());
    }
    if (profile_status == 6) {
      Get.to(() => const DashboardPage());
    } else {
      // Get.to(() => const OptionScreen());
    }
  }
}
