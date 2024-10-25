import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_create_ads/all_ads/buisness_all_adss_models.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../all_ads/all_ads.dart';
import '../all_ads/all_ads_controller.dart';

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

  AllAdssDealController allAdssDealController =
      Get.put(AllAdssDealController());

  EditAdsUpdate(
    addId,
    index,
    MyAdv? myAdv,
  ) async {
    print("tittle text");
    print(Title.value.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');
    const apiUrl =
        'https://forreal.net:4000/update_advs'; // Replace with your API endpoint
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    print("userid Cover$userId");
    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.headers.addAll(headers);
      request.fields["id"] = addId.toString();
      request.fields["title"] = Title.text.isEmpty ? myAdv!.title : Title.text;
      request.fields["age"] =
          Age.text.isEmpty ? myAdv!.age.toString() : Age.text;
      request.fields["interest"] =
          Intrest.text.isEmpty ? myAdv!.interest : Intrest.text;
      request.fields["budget"] =
          budget.text.isEmpty ? myAdv!.budget.toString() : budget.text;
      request.fields["campaign_duration"] = CampaignDuration.text.isEmpty
          ? myAdv!.campaignDuration
          : CampaignDuration.text;
      request.fields["address"] =
          Location.text.isEmpty ? myAdv!.address : Location.text;
      request.fields["range_km"] =
          Range.text.isEmpty ? myAdv!.rangeKm.toString() : Range.text;
      request.fields["link"] =
          Link.text.isEmpty ? myAdv!.link.toString() : Link.text;

      // Add the image file to the request

      if (addImage == null) {
        var fileName =
            allAdssDealController.getAllAdsMdoels?.myAdvs[index].adImage;
        request.fields['file'] = fileName.toString();
        print("File======>");
        print(
          request.fields['file'],
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('file', addImage.toString()),
        );
        print("file data");
        print(request.fields['file']);
        // https://forreal.net:4000/deals/
      }

      // if (File(addImage.toString()) != null) {
      //   request.files.add(http.MultipartFile(
      //     'file', // This should match the field name expected by your API
      //     File(addImage.toString()).readAsBytes().asStream(),
      //     File(addImage.toString()).lengthSync(),
      //     filename: File(addImage.toString()).path.split('/').last,
      //   ));
      // }

      final response = await request.send();
      if (response.statusCode == 200) {
        // Handle a successful response
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        print('Response: $responseString');
        print('Response: $response');
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
        print(request.fields);
      } else {
        // Handle API error
        print('API Request Failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
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
