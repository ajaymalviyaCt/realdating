import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';

class SwipController extends GetxController implements GetxService {
  RxBool isLoadig = false.obs;
  RxBool isLoadig1 = false.obs;

  // List<MyFriend> get_all_users = <MyFriend>[].obs;

  @override
  void onReady() {
    super.onReady();

  }



  sendNotificationOnlyMatch(reciverId) async {
    print("_notification_response ==>$reciverId");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getInt('user_id');
      print("SwipModel");
      final response = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/send_notification"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
        'notification_type': 'matches'
      });
      print("notificationResponse ==> $response");
      isLoadig1.value = true;
      final response2 = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/users/friend_request"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
      });
      print("friend_request_Response ==> $response2");

      isLoadig1.value = false;
      print(response2.toString());
    //  Fluttertoast.showToast(msg: "${response2["message"]}");
      print("friend_request==> friend_request==>" + response2.toString());


    } catch (e) {
      print(e);
    }
  }

  sendNotification(reciverId, type) async {
    print("_notification_response ==>$reciverId");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getInt('user_id');
      print("SwipModel");
      final response = await BaseClient01().post(
          Uri.parse("https://forreal.net:4000/send_notification"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
        'notification_type': type
      });
      print("responseNotiFication");
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
sendNotification(reciverId, type) async {
  print("_notification_response ==>$reciverId");
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt('user_id');
    print("SwipModel");
    if("$user_id"=="$reciverId"){
      print("sameUser");

    }else{
      final response = await BaseClient01().post(
          Uri.parse("https://forreal.net:4000/send_notification"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
        'notification_type': type
      });
      print("responseNotiFication==> $response");
      print(response);
    }


  } catch (e) {
    print(e);
  }
}