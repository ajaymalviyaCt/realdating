
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile/profile_controller.dart';

class EditProfileController extends GetxController {

   ProfileController profileController=Get.put(ProfileController());

  TextEditingController username = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController dateOfbrith = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController gender = TextEditingController();
  // TextEditingController gender = TextEditingController();
  TextEditingController Interest = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController hobbies = TextEditingController();
  TextEditingController phone_number = TextEditingController();

  RxBool isLoadig =false.obs;
  RxString inrest = "".obs;
  String? profilepic;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    username.text = profileController.profileModel?.userInfo.username ?? "";
    first_name.text = profileController.profileModel?.userInfo.firstName??"";
    last_name.text = '${profileController.profileModel?.userInfo.lastName}'??"";
    height.text = '${profileController.profileModel?.userInfo.height}' ?? "";
    dateOfbrith.text = '${profileController.profileModel?.userInfo.dob}' ?? '';
    Address.text = profileController.profileModel?.userInfo.address??"";
    print('address is here-----${profileController.profileModel?.userInfo.address}');
  }
  @override
  void onReady() {
    super.onReady();
  }
   var dio = Dio();

  Future<void> editProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {
      'Authorization':
      'Bearer $token'
    };
    var data = FormData.fromMap({
      'first_name': first_name.value.text,
      'last_name': last_name.value.text,
      'username': username.value.text,
      'DOB': dateOfbrith.value.text,
      'height': height.value.text,
      'address': Address.value.text == "" ? "address" :  Address.value.text,
    });

    var response = await dio.request(
      'https://forreal.net:4000/users/editProfile',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      profileController.profileDaitails();
      print(json.encode(response.data));
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      Get.back();
      Get.back();


    } else {
      print("editprofile${response.statusMessage}");
    }
  }
   Future<void> onlyage(int age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {
      'Authorization':
      'Bearer $token'
    };
    var data = FormData.fromMap({
      'age': age,
    });

    var response = await dio.request(
      'https://forreal.net:4000/users/editProfile',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print("${response.statusCode}");

    if (response.statusCode == 200) {
      profileController.profileDaitails();
      print(json.encode(response.data));
      Fluttertoast.showToast(msg: "${response.data["message"]}");
      Get.back();
      Get.back();


    } else {
      print("editprofile${response.statusMessage}");
    }
  }
   Future<void> uploadImage(XFile file) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.get('token');
     try {
       var headers = {
         'Authorization':
         'Bearer $token'
       };

       var formData = FormData.fromMap({
         'file': [
           await MultipartFile.fromFile(file.path, filename: file.name),
         ],
       });

       var response = await dio.post(
         'https://forreal.net:4000/users/editProfile',
         options: Options(
           method: 'POST',
           headers: headers,
         ),
         data: formData,
       );

       if (response.statusCode == 200) {
         print("dsfdsffds");
         print(json.encode(response.data));
       } else {
         print(response.statusMessage);
       }

       print('Request Headers: ${response.requestOptions.headers}');
       print('Response Data: ${response.data}');
       Fluttertoast.showToast(msg: "${response.data["message"]}");
     } catch (e) {
       print("Error uploading image: $e");
     }
   }


}
