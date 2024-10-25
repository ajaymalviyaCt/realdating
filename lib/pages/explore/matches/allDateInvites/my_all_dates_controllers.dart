import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/base_client01.dart';
import 'my_all_dates_models.dart';


class MyAllDatesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    classifiedAllPost();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingPostToClassified = false.obs;
  RxInt isLoadingAceptedRequest = 9999.obs;

  MyAllDatesModel001? myAllDatesModel;

  Future<void> classifiedAllPost() async {
    print("classifiedAllPost".toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    isLoading.value = true;
    final response = await BaseClient01()
        .post(Uri.parse("https://forreal.net:4000/users/ALL_sent_request"), {
      'user_id': userId.toString(),
    });

    isLoading.value = false;
    print(response.toString());
    var satus = "${response["status"]}";
    if (satus == "200") {
      print("++++++++++++++++++++++++++++++++++++");
      print(response.toString());
      print("sdfgfsdfdf");
      myAllDatesModel = MyAllDatesModel001.fromJson(response);
      print("sdfgfsdfdf");
    }
  }
}
