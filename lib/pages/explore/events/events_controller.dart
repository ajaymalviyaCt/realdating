import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';

import 'events_model.dart';

class EventsController extends GetxController {
  RxBool isLoadig = false.obs;
  EventssModel? matchessModel;

  @override
  void onReady() {
    super.onReady();
    Events();
  }

  Events() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    print("Events");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.events, {
      "user_id": userId.toString(),
    });
    print(response);
    print("TreadingModel");
    bool success = response["success"];
    var msg = response["message"];
    print("msg ___$msg");
    if (success) {
      matchessModel = EventssModel.fromJson(response);
      update();
    }
    update();
    isLoadig(false);
  }
}
