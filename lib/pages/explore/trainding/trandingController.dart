import 'package:dio/dio.dart';
import 'package:realdating/pages/explore/trainding/treading_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreadingController extends GetxController {
  RxBool isLoadingTreandingUser = false.obs;
  RxString inrest = "".obs;
  TreadingModel? treadingModel;

  @override
  void onInit() {
    super.onInit();
    getTreandingUser();
  }

  Future<void> getTreandingUser() async {
    isLoadingTreandingUser(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var data = {'user_id': ''};
    print('Authorization===>"$token');
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/TREnding_users',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      treadingModel = TreadingModel.fromJson(response.data);
      print("treadingModel===>${treadingModel!.trendingUser?.length}");
      isLoadingTreandingUser.value = false;
    } else {
      print(response.statusMessage);
    }
  }
}
