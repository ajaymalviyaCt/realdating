import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/buisness_screens/buisness_dashboard/buisness_dashboard.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/pages/dash_board_page.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../height_dob/heught_dob_page.dart';
import 'LocationUpdate.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
    } else {
      if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset('assets/icons/btn.svg'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 100),
            child: Image(
              image: AssetImage('assets/images/Group 26.png'),
              height: 180,
              width: 180,
            ),
          ),
          const Text(
            'Enable Location',
            style: CustomTextStyle.black,
          ),
          const SizedBox(height: 12),
          const Text(
              'You’ll need to enable your '
              '\n location in order to use.',
              style: CustomTextStyle.blackLoc),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: customPrimaryBtn(
                btnText: "Continue",
                btnFun: () async {

                  updateStatus();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var token = prefs.get('token');

                  var headers = {
                    'Authorization': 'Bearer $token'
                  };
                  var data = {};
                  var dio = Dio();
                  var response = await dio.request(
                    'https://forreal.net:4000/users/new_profile_image',
                    options: Options(
                      method: 'POST',
                      headers: headers,
                    ),
                    data: data,
                  );

                  if (response.statusCode == 200) {
                    print(json.encode(response.data));
                  }
                  else {
                    print(response.statusMessage);
                  }
                  await  requestLocationPermission();
                 await prefs.setBool("isLogin",true);
                  Get.offAll(() => const DashboardPage());
                }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks[0];
        // _currentAddress = "${firstPlacemark.street} ${firstPlacemark.subLocality}, ${firstPlacemark.locality},${firstPlacemark.country}";
        // print("Address: $_currentAddress");
        // buisbnesssignUpController.addressController.text=_currentAddress!;
      } else {
        print("No address found for the given coordinates");
      }
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {
      'userId': '${userId}',
      'profile_status': '6'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status_update',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(response.data);
    }
    else {
      print(response.statusMessage);
    }

  }

}
