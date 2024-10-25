import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';

class BusinessKycController extends GetxController {
  TextEditingController buisnessnameController = TextEditingController();
  RxBool isLoadig = false.obs;

  String? KYCBDOC;
  String? KYCDOC;

  BusinessDocumentKycFunction() async {
    // print(cityValue);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");
    print("signwithBuissEmail");
    isLoadig(true);
    File file = File(KYCBDOC ?? "");
    String fileName = file.path.split('/').last;

    print("File Name====> $fileName");

    final response = await BaseClient01().post(
      Appurls.buisnessKYCDocument,
      {
        'business_id': user_id,
        'document_name': 'BusinessDocument',
        'file': '${fileName}',
      },
    );

    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];

    if (success) {
      print("doc uploaded");
      // Get.off(() => BuisnessLogin());
      Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
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
  }

  PersonalIdentificationKycFunction() async {
    // print(cityValue);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");
    print("buisnessKYCIdentificationUrl====>>");
    isLoadig(true);

    final response = await BaseClient01().post(
      Appurls.buisnessKYCIdentificationUrl,
      {
        'business_id': user_id,
        'file': '${KYCBDOC}',
      },
    );

    print(response);
    isLoadig(false);
    bool success = response["success"];
    var msg = response["message"];

    if (success) {
      // Get.off(() => BuisnessLogin());
      Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
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
  }

  // Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
  //   http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/upload'));
  //   // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
  //   if(GetPlatform.isMobile && data != null) {
  //     File _file = File(data.path);
  //     request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
  //   }
  //   Map<String, String> _fields = Map();
  //   _fields.addAll(<String, String>{
  //     'file': KYCBDOC.toString(),  'business_id': "12",        'document_name': 'BusinessDocument',
  //
  //   });
  //   request.fields.addAll(_fields);
  //   http.StreamedResponse response = await request.send();
  //   return response;
  // }

  asyncUploadInfo(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST",
        Uri.parse("https://forreal.net:4000/business_document_camera"));
    //add text fields
    request.fields["business_id"] = user_id.toString();
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Get.off(() => BuisnessHomePage());
      print("issuesss");
    }
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.headers);
    return responseString;
  }
}
