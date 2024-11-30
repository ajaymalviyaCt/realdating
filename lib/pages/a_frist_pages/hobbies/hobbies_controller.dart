import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:realdating/consts/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/base_client01.dart';
import '../add_your_photos/add_your_photos.dart';

class HobbiesController extends GetxController {
  RxBool isLoadig = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  hobbiesSelect(String hobbies) async {
    print("call  interestSelect");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.gender, {
      "hobbies": hobbies.toString(),
      // "profile_status": "3"
    });
    print(response.toString());
    updateStatus();

    print(hobbies.toString());
    isLoadig(false);
    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    if (status) {
      Get.to(() => const AddYourPhotoPage());
    }
  }

  updateStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var data = {'userId': '${userId}', 'profile_status': '3'};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/user_profile_status_update',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print(response.statusMessage);
    }
  }
}
