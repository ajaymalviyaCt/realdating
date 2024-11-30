import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var userId = prefs.getInt('user_id');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
    var data = {'user_id': userId};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/get_my_friend',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      matchessModel = MatchesModel.fromJson(response.data);
      isLoadig(false);
      update();
    } else {
      print(response.statusMessage);
    }
  }

  ExploreDetailsModel? exploreDetailsModel;
  String? id;
  List<AllReview> displayedItemss = [];
  RxBool isLoadingget_user_by_id = false.obs;

  get_user_by_id(id) async {
    isLoadingget_user_by_id(true);
    Map<String, dynamic> apiData = await ApiCall.instance
        .callApi(url: "https://forreal.net:4000/users/get_user_by_id", method: HttpMethod.POST, body: {"user_id": id}, headers: await authHeader());

    isLoadingget_user_by_id(false);

    exploreDetailsModel = ExploreDetailsModel.fromJson(apiData);
    displayedItemss = exploreDetailsModel!.userInfo[0].allReviews.take(1).toList();
    update();

    update();

    isLoadig(false);

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
