import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_create_ads/all_ads/buisness_all_adss_models.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../all_ads/all_ads.dart';
import '../all_ads/all_ads_controller.dart';

import 'package:dio/dio.dart' as dio;

class EditAdsController extends GetxController {
  RxBool isLoadig = false.obs;

  TextEditingController Title = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Intrest = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController CampaignDuration = TextEditingController();
  TextEditingController Location = TextEditingController();
  TextEditingController Range = TextEditingController();
  TextEditingController Link = TextEditingController();
  TextEditingController file = TextEditingController();

  bool _obscureText = false;
  bool loading = false;
  var isLoading = false;

  @override
  void onReady() {
    super.onReady();
    // EditAdsUpdate(addId);
  }

  var addId;
  String? addImage;

  var index;

  AllAdssDealController allAdssDealController = Get.put(AllAdssDealController());

  EditAdsUpdate(
    addId,
    index,
    MyAdv? myAdv,
  ) async {
    print("tittle text");
    print(Title.value.text);
    Map<String, dynamic> apiData = await ApiCall.instance.callApi(
      url: "https://forreal.net:4000/update_advs",
      method: HttpMethod.POST,
      body: dio.FormData.fromMap({
        "id": addId.toString(),
        "title": Title.text.isEmpty ? myAdv!.title : Title.text,
        "interest": Intrest.text.isEmpty ? myAdv!.interest : Intrest.text,
        "budget": budget.text.isEmpty ? myAdv!.budget.toString() : budget.text,
        "campaign_duration": CampaignDuration.text.isEmpty ? myAdv!.campaignDuration : CampaignDuration.text,
        "address": Location.text.isEmpty ? myAdv!.address : Location.text,
        "range_km": Range.text.isEmpty ? myAdv!.rangeKm.toString() : Range.text,
        "link": Link.text.isEmpty ? myAdv!.link.toString() : Link.text,
        if (addImage != null)
          "file": (await dio.MultipartFile.fromFile(addImage!, filename: "${DateTime.now().toUtc().toIso8601String()}.jpg"))
      }),
      headers: await authHeader(),
    );

    if (apiData["success"] == true) {
      // Handle a successful response

      Get.off(() => All_Ads());
      allAdssDealController.All_AdsD();
      Fluttertoast.showToast(
        msg: "updated Successfully.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      // Handle API error
    }
  }

  EditAdsDelete(addId) async {
    print("Ads");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.adsdelete, {
      "id": addId.toString(),
    });

    print(response.toString());
    isLoadig(false);
    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    if (status) {
      print("editAdssUp");
      // allAdssDealController.All_AdsD();
      allAdssDealController.All_AdsD();
      allAdssDealController.getAllAdsMdoels?.myAdvs.clear();
      Get.to(() => All_Ads());
      //Get.back();
      // Get.back();
    }
  }
}
