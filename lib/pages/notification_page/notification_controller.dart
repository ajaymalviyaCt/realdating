import 'package:realdating/services/base_client01.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'noti_model.dart';

class NotificationController extends GetxController{

  RxBool isLoading =false.obs;
  NoficactionModel ? noficactionModel ;
  NoficactionModel ? noficactionModelB ;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // getNotification();
  }
  getNotification() async {

    isLoading.value=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    final response =await BaseClient01().post(Uri.parse('https://forreal.net:4000/Allnotification'),{
      'user_id': '$userId',
      'receiver_type': "user",
    });
    noficactionModel =NoficactionModel.fromJson(response);
    print("response1234567890$noficactionModel" +response.toString());
    isLoading.value=false;

  }

  getNotificationBusiness() async {

    isLoading.value=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    final response =await BaseClient01().post(Uri.parse('https://forreal.net:4000/Allnotification'),{
      'user_id': '$userId',
      'receiver_type': "business",
    });
    noficactionModelB =NoficactionModel.fromJson(response);
    print("response1234567890$noficactionModelB" +response.toString());
    isLoading.value=false;

  }



}