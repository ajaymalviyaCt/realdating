import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../interest/interest.dart';


class GenderController extends GetxController {

  RxBool isLoadig =false.obs;
  RxString gender = "male".obs;




  @override
  void onReady() {
    super.onReady();
  }


  selectGender()async{
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.gender,{
       "gender": "${gender.value}",
      "profile_status": "1"
    });
    print(response.toString());
    isLoadig(false);
    bool status= response["success"];
    print( "status ___$status");
    var msg= response["message"];
    print( "msg ___$msg");
    if(status){
      Get.to(()=>const Interest_Screen());
    }


  }

}
