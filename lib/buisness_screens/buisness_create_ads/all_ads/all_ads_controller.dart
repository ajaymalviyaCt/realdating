import 'package:realdating/consts/app_urls.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buisness_all_adss_models.dart';

// class CreateAdsController extends GetxController{
//
//   RxBool isLoadig =false.obs;
//
//   BuisnessCreateDealsModel  ? buisnessCreateDealsModel;
//
//   @override
//   void onReady() {
//     super.onReady();
//     All_AdsD();
//   }
//
//   All_AdsD()async{
//     isLoadig(true);
//
//     final response = await BaseClient01().post(Appurls.creatads,{
//     "business_id": "1",
//     });
//     print(response);
//     print("BuissnessAllAdsModel");
//     bool success= response["success"];
//     var msg= response["message"];
//     print( "msg ___$msg");
//     if(success){
//       buisnessCreateDealsModel = BuisnessCreateDealsModel.fromJson(response);
//     }
//     isLoadig(false);
//
//
//   }
// }

class AllAdssDealController extends GetxController{

  RxBool isLoadig =false.obs;

  GetAllAdsMdoels ? getAllAdsMdoels;

  @override
  void onReady() {
    super.onReady();
    All_AdsD();
  }

  All_AdsD()async{
    isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    final response = await BaseClient01().post(Appurls.getsallads,{
      "business_id":userId.toString(),
    });
    print(response);
    print("GetAllAdsModel");
    bool success= response["success"];
    var msg= response["message"];
    print( "msg ___$msg");
    if(success){
      getAllAdsMdoels = GetAllAdsMdoels.fromJson(response);
    }
    isLoadig(false);

  }
}
