import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../model/myDealModel.dart';

class MyDealController extends GetxController {
  RxBool isLoadig = false.obs;
  MyDealsModel? myDealsModel;

  @override
  void onReady() {
    super.onReady();
    MYDeal();
  }

  MYDeal() async {
    print("Events");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.mydeal, {
      "business_id": "1",
    });
    print(response);
    print("TopDeal");
    bool success = response["success"];
    var msg = response["message"];
    print("msg ___$msg");
    if (success) {
      myDealsModel = MyDealsModel.fromJson(response);
    }
    isLoadig(false);
  }
}
