import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_profile/widget/myProfileModel.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessProfileController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    myProfile();
  }

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessHoursController = TextEditingController();
  TextEditingController businessDescriptionController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController businessInstagramController = TextEditingController();
  TextEditingController businessFaceBookController = TextEditingController();
  TextEditingController businessTwitterController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();
  TextEditingController weekController = TextEditingController();

  String? businessProfileImage;
  String? businessBackgroundImage;
  int? modayDate;
  int? tuesDayDate;
  int? webnesdayDate;
  int? thursdayDate;
  int? friDayDate;
  int? saturDayDate;
  int? sunDayDate;

  MyProfileModel? profileData;
  RxBool profileDatLoading = false.obs;

  RxString bussinessName = "".obs;
  RxString bussinessProfilepic = "".obs;
  RxString bussinessCoverprofilepic = "".obs;

  RxBool isLoadigGetProfile = false.obs;

  Future<void> myProfile() async {
    isLoadigGetProfile(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');

    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
      var data = {'id': '$userId'};
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/myprofile',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        profileData = MyProfileModel.fromJson(response.data);
        bussinessName.value = profileData!.businessInfo!.businessName ?? "";
        bussinessProfilepic.value = profileData!.businessInfo!.profileImage ?? "";
        bussinessCoverprofilepic.value = profileData!.businessInfo!.coverPhoto ?? "";

        businessNameController.text = profileData!.businessInfo!.businessName ?? '';
        businessDescriptionController.text = profileData!.businessInfo!.description ?? "";
        businessNumberController.text = profileData!.businessInfo!.phoneNumber;
        businessCategoryController.text = profileData!.businessInfo!.category;
        businessFaceBookController.text = profileData!.businessInfo!.facebookLink;
        businessTwitterController.text = profileData!.businessInfo!.twitterLink;
        businessInstagramController.text = profileData!.businessInfo!.instagramLink;
        businessWebsiteController.text = profileData!.businessInfo!.website;
        isLoadigGetProfile(false);

        print("json.encode(response.data)");
        print(json.encode(response.data));
        print("json.encode(response.data)");
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("https://forreal.net:4000/myprofile");
      print("$e");
    }
  }

  RxBool isLoadingupdateProfile = false.obs;

/*  Future<void> updateProfile() async {
    isLoadingupdateProfile(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');

    var headers = {'Authorization': 'Bearer $token'};

    FormData data = FormData.fromMap({
      'business_id': '$userId',
      'Monday': '1',
    });
    if (businessNameController.text.toString() != "") {
      data.fields.add(MapEntry("business_name", businessNameController.text.toString()));
    }
    if (businessFaceBookController.text.toString() != "") {
      data.fields.add(MapEntry("facebook_link", businessFaceBookController.text.toString()));
    }
    if (businessDescriptionController.text.toString() != "") {
      data.fields.add(MapEntry("description", businessDescriptionController.text.toString()));
    }
    if (businessCategoryController.text.toString() != "") {
      data.fields.add(MapEntry("category", businessCategoryController.text.toString()));
    }

    if (businessNumberController.text.toString() != "") {
      data.fields.add(MapEntry("phone_number", businessNumberController.text.toString()));
    }
    if (businessTwitterController.text.toString() != "") {
      data.fields.add(MapEntry("twitter_link", businessTwitterController.text.toString()));
    }
    if (businessInstagramController.text.toString() != "") {
      data.fields.add(MapEntry("instagram_link", businessInstagramController.text.toString()));
    }
    if (businessWebsiteController.text.toString() != "") {
      data.fields.add(MapEntry("website", businessWebsiteController.text.toString()));
    }
    print("bodyyyyy==${data.fields.length}");
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/add_profile_photo',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("responese==>${response.data}");
      Fluttertoast.showToast(
        msg: "${response.data["message"]}.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      isLoadingupdateProfile(false);
      myProfile();
    } else {
      print(response.statusMessage);
    }
  }*/
  Future<void> updateProfile() async {
    String businessName = businessNameController.text.trim();

    // Validate the business name
    if (businessName.isEmpty) {
      Fluttertoast.showToast(
        msg: "Business name cannot be empty.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    if (businessName.contains(' ')) {
      Fluttertoast.showToast(
        msg: "Spaces are not allowed in the business name.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    isLoadingupdateProfile(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');

    var headers = {'Authorization': 'Bearer $token'};

    FormData data = FormData.fromMap({
      'business_id': '$userId',
      'Monday': '1',
    });

    if (businessName.isNotEmpty) {
      data.fields.add(MapEntry("business_name", businessName));
    }

    if (businessFaceBookController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("facebook_link", businessFaceBookController.text.trim()));
    }
    if (businessDescriptionController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("description", businessDescriptionController.text.trim()));
    }
    if (businessCategoryController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("category", businessCategoryController.text.trim()));
    }
    if (businessNumberController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("phone_number", businessNumberController.text.trim()));
    }
    if (businessTwitterController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("twitter_link", businessTwitterController.text.trim()));
    }
    if (businessInstagramController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("instagram_link", businessInstagramController.text.trim()));
    }
    if (businessWebsiteController.text.trim().isNotEmpty) {
      data.fields.add(MapEntry("website", businessWebsiteController.text.trim()));
    }

    try {
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/add_profile_photo',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print('this is param-------------$data');
        Fluttertoast.showToast(
          msg: "${response.data["message"]}.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        isLoadingupdateProfile(false);
        myProfile();
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error updating profile: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      isLoadingupdateProfile(false);
    }
  }
}
