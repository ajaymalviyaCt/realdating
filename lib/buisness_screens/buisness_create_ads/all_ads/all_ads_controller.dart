import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';

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

class AllAdssDealController extends GetxController {
  RxBool isLoadig = false.obs;

  GetAllAdsMdoels? getAllAdsMdoels;

  @override
  void onReady() {
    super.onReady();
    getAllAds();
  }

  getAllAds() async {
    isLoadig(true);
    try {
      Map<String, dynamic> apiData = await ApiCall.instance.callApi(
          url: "https://forreal.net:4000/get_advs",
          headers: await authHeader(),
          body: {
            "business_id": await getUserId(),
          },
          method: HttpMethod.POST);
      getAllAdsMdoels = GetAllAdsMdoels.fromJson(apiData);
    } catch (e, s) {}

    isLoadig(false);
  }
}
