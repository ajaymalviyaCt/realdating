import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/swipcard/swip_controller.dart';

import '../../../../services/base_client01.dart';

class InvaiteForDatesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isLoading = false.obs;

  final selectDateC = TextEditingController();
  final selectTimeC = TextEditingController();
  final activityC = TextEditingController();
  final locationC = TextEditingController();

  Future<void> invateForDate(String id, String date, String time, String activity, String location) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var user_id = prefs.getInt('user_id');
    print("InviteForDate Api===>".toString());

    isLoading.value = true;
    final response = await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/invite_for_date"), {
      'user_id': id.toString(),
      'date': date,
      'time': time,
      'activity': activity,
      'location': location,
    });

    sendNotification(id, "invite_date");
    isLoading.value = false;
    print(response.toString());
    var satus = "${response["status"]}";
    if (satus == "200") {
      // sendNotification(id, "");
      Get.back();
      // Get.to(() => InviteRequestsPage());
      print("fdskgfjdfklg");
      selectTimeC.clear();
      selectDateC.clear();
      activityC.clear();
      locationC.clear();
      Fluttertoast.showToast(msg: "Invitation sent successfully.");
    } else {
      Fluttertoast.showToast(msg: "${response["message"]}");
    }
  }
}
