import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/pages/dash_board_page.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _currentAddress = '';
  Position? _currentPosition;

  // --------------- Permission & Location Handling ---------------

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      _currentPosition = await getCurrentLocation();
      if (_currentPosition != null) {
        await getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
      }
    } else if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<void> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks[0];
        _currentAddress = "${firstPlacemark.street}, ${firstPlacemark.locality}, ${firstPlacemark.country}";
        print("Address: $_currentAddress");
      } else {
        print("No address found for the given coordinates");
      }
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  // --------------- Profile Update Handling ---------------

  Future<void> editProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Fetch location data if missing
    if (_currentPosition == null) {
      _currentPosition = await getCurrentLocation();
      if (_currentPosition != null) {
        await getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
      }
    }

    print('User current address: $_currentAddress');

    // Prepare data
    var data = {
      'address': _currentAddress.isEmpty ? "address" : _currentAddress,
    };

    var body = jsonEncode(data);

    // Make the HTTP POST request
    var url = Uri.parse('https://forreal.net:4000/users/editProfile');
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // Handle response
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      Get.back();
    } else {
      print("Edit Profile Error: ${response.reasonPhrase}");
    }
  }

  Future<void> updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {'userId': '$userId', 'profile_status': '6'};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status_update',
      options: Options(method: 'POST'),
      data: data,
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> uploadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    var headers = {'Authorization': 'Bearer $token'};
    var data = {};
    var dio = Dio();

    var response = await dio.request(
      'https://forreal.net:4000/users/new_profile_image',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  // --------------- UI ---------------

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
            'You’ll need to enable your \n location in order to use.',
            style: CustomTextStyle.blackLoc,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: customPrimaryBtn(
              btnText: "Continue",
              btnFun: () async {
                await requestLocationPermission();
                await updateStatus();
                await uploadProfileImage();
                await editProfile();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("isLogin", true);

                Get.offAll(() => const DashboardPage());
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
