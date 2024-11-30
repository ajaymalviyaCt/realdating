import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/pages/a_frist_pages/location_enable/loctaion.dart';
import 'package:get/get.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeightDOBcontroller extends GetxController {
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController height = TextEditingController();
  RxBool isLoadig = false.obs;
  RxString gender = "male".obs;
  DateTime? dob;


  Future<void> upDateOfBrith() async {
    print("dateofbirth ${dateOfBirth.text}");
    try {
      final response = await BaseClient01().post(Appurls.gender, {
        "DOB": dateOfBirth.text,
      });
      updateAge();
      updateHeight();
    } catch (e) {
      print("upDateOfBrith error$e");
    }
  }

  Future<void> updateAge() async {
    var age = calculateAge(dob!);
    print("age===> $age");
    try {
      final response = await BaseClient01().post(Appurls.gender, {
        "age": age.toString(),
      });
    } catch (e) {
      print("age==> error$e");
    }
  }

  Future<void> updateHeight() async {
    print('my height------------${height.text}');

    try {
      final response = await BaseClient01().post(Appurls.gender, {
        "height": height.text,
      });

      print('my response------------$response');
    } catch (e) {
      print("updatehight error$e");
    }
  }

  Future<void> updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    print('safsfssaf');
    var data = {'userId': '$userId', 'profile_status': '5'};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status_update',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      Get.to(() => const LocationScreen());
    } else {
      print(response.statusMessage);
    }
  }

  // 02-02-2011

  int calculateAge(DateTime dob) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }
}
