import 'dart:io';
import 'package:dio/dio.dart';
import 'package:realdating/pages/swipcard/tinder_card_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TinderSwipController extends GetxController {
  List<MyFriendSwipe> user = <MyFriendSwipe>[];
  List<MyFriendSwipe> user2 = <MyFriendSwipe>[];
  GetAllUserModel? getAllUserModel;

  RxBool lastIndex = false.obs;

  RxBool isLoadinggetAllUser = false.obs;

  @override
  void onInit() {
    getAllUser();
    super.onInit();
  }

  Future<void> getAllUser() async {
    isLoadinggetAllUser.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt('user_id');
    var token = prefs.get('token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${token}'};
    Map<String, String> body = {'user_id': user_id.toString()};
    var dio = Dio();

    try {
      var response = await dio.request(
        'https://forreal.net:4000/users/get_all_users',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        user = GetAllUserModel.fromJson(response.data).myFriends!;
        user2 = GetAllUserModel.fromJson(response.data).myFriends!;
        isLoadinggetAllUser.value = true;
        isLoadinggetAllUser.value = false;
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          print("EROOR_PRAMOD");
          print("${e.message}EROOR_PRAMOD");
        } else {
          // Handle other DioError types
        }
      } else {
        // Handle other types of exceptions
      }
    }
    try {} catch (e) {
      print(e.toString());
    }
  }
}
