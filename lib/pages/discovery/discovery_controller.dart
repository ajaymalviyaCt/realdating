import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/discovery/discovery_model.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import '../explore/matches/matches_controller.dart';
import '../profile/profile_model.dart';

class DiscoveryController extends GetxController {
  MatchessController matchessController = Get.put(MatchessController());
  RxBool isLoadingGetDiscoverUser = false.obs;
  RxBool isLoadingForYourModel = false.obs;
  RxBool isLoadig1 = false.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchText="".obs;

  final Rxn<Discovery2Model> forYourModel=Rxn<Discovery2Model>();


  RxBool isLoadig = false.obs;
  ProfileModel? profileModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileDaitails();
    foryou(intrest: true);
  }

  Future<void> profileDaitails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt('user_id');
    print("call  profileDaitails");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.profile, {
      "id": "$user_id",
    });
    print(response.toString());

    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    profileModel = ProfileModel.fromJson(response);

    print("profile model data--------${profileModel}");

    isLoadig(false);
    // if (status) {
    //   Get.to(() => const UplodePhoto());
    // }
  }





  Future<void> foryou({bool intrest=true}) async {
    isLoadingForYourModel.value = true;
    forYourModel.value=null;
    Map<String, dynamic> apiData = await ApiCall.instance.callApi(
        url: 'https://forreal.net:4000/users/discovery_filter',
        method: HttpMethod.POST,
        body: {
          'user_id': await getUserId(),
         if(intrest) 'Interest':( profileModel?.userInfo.interest.split(",").take(1).toList())![0]
        },
        headers: await authHeader());

    isLoadingForYourModel.value = false;
    try {
      forYourModel.value = Discovery2Model.fromJson(apiData);


    } catch (e) {
      print("responseee=>$e");
    }
  }

  Future<bool> sendNotificationOnlyMatch(
      {required String reciverId, required int index}) async {
    print("_notification_response ==>$reciverId");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getInt('user_id');
      print("SwipModel");
      final response = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/send_notification"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
        'notification_type': 'matches'
      });
      print("notificationResponse ==> $response");
      isLoadig1.value = true;
      final response2 = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/users/friend_request"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
      });
      print("friend_request_Response ==> $response2");
      isLoadig1.value = false;
      matchessController.matches();

      print(response2.toString());
      Fluttertoast.showToast(msg: "${response2["message"]}");
      return true;

      print("friend_request==> friend_request==>" + response2.toString());
    } catch (e) {
      print(e);
      return false;
    }
  }
}
