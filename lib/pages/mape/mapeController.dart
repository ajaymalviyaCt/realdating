import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../model/userModel.dart';
import '../../services/base_client01.dart';
import '../createPostUser/mention/getFriendModel.dart';
import '../discovery/discoveryModel.dart';
import '../profile/profile_controller.dart';
import 'mapeModel.dart';

class MapeUserController extends GetxController implements GetxService {
  RxBool isLoadig = false.obs;
  List<Bussiness> userBusinessMap = [];


  @override
  void onReady() {
    super.onReady();
    // print("onReady getAllUsersPost");
    getAllUserMape(search??"");

  }
  var search;
  var userProfileImage;

  getAllUserMape(search) async {
    // isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.get("user_id");
    var token = prefs.get('token');
    isLoadig(true);
    print("MapeApi====>>>>>");
    final response = await BaseClient01().post(Appurls.mapUrl, {
      "user_id": userid.toString(),
      if(search!=null)
      "search": search??"n",
    });
    print(response);
    print("ultramodern1");

    bool success = response["success"];

    if (success) {
      final data = MapeBusinessModel.fromJson(response);
      userBusinessMap = data.bussiness;
      update();

    }
    update();
    // print("controller data ${controller}");
    // cont(false);
  }


}