import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';

import '../exploreDetailsModel.dart';
import 'matches_model.dart';

class MatchessController extends GetxController {
  RxBool isLoadig = false.obs;
  MatchesModel? matchessModel;

  @override
  void onInit() {
    super.onInit();
    matches();
  }

  Future<void> matches() async {
    isLoadig(true);
  Map<String,dynamic>apiData= await ApiCall.instance.callApi(
        url: "https://forreal.net:4000/users/get_my_friend",
        method: HttpMethod.POST,
        headers: await authHeader(),
        body: {'user_id': await getUserId()});

    matchessModel = MatchesModel.fromJson(apiData);

    isLoadig(false);
    update();
  }

  ExploreDetailsModel? exploreDetailsModel;
  String? id;
  List<AllReview> displayedItemss = [];
  RxBool isLoadingget_user_by_id = false.obs;

  get_user_by_id(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    isLoadingget_user_by_id(true);
    final response = await BaseClient01().post(Appurls.get_user_by_id, {
      "user_id": id.toString(),
    });
    isLoadingget_user_by_id(false);

    bool success = response["success"];
    try {
      exploreDetailsModel = ExploreDetailsModel.fromJson(response);
      displayedItemss = exploreDetailsModel!.userInfo[0].allReviews.take(1).toList();
      update();
    } catch (e, s) {
      print(e);
      print(s);
    }
    update();

    isLoadig(false);
    var msg = response["message"];
    print(msg);
    update();
  }

  DetailsApiScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.get_user_by_id, {
      "user_id": userId.toString(),
    });

    bool success = response["success"];
    try {
      exploreDetailsModel = ExploreDetailsModel.fromJson(response);
      update();
    } catch (e, s) {
      print(e);
      print(s);
    }
    update();

    isLoadig(false);
    var msg = response["message"];
  }
}
