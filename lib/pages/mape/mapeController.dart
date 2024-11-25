import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import 'mapeModel.dart';

class MapeUserController extends GetxController implements GetxService {
  RxBool isLoadig = false.obs;
  List<Bussiness> userBusinessMap = [];

  @override
  void onReady() {
    super.onReady();
    // print("onReady getAllUsersPost");
    getAllUserMape(search ?? "");
  }

  var search;
  var userProfileImage;

  getAllUserMape(String search) async {
    // isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.get("user_id");
    var token = prefs.get('token');
    isLoadig(true);
    print("MapeApi search====>>>>>${search}");
    final response = await BaseClient01().post(Appurls.mapUrl, {
      "user_id": userid.toString(),
      if (search != null) "search": search ?? "n",
    });
    print(response);
    print("ultramodern1");

    bool success = response["success"];

    if (success) {
      final data = MapeBusinessModel.fromJson(response);
      userBusinessMap = data.bussiness;
      update();
    }
    update();
    // print("controller data ${controller}");
    // cont(false);
    Map<String, dynamic> apiData = await ApiCall.instance
        .callApi(url: "https://forreal.net:4000/users/nearByBussiness", headers: await authHeader(), method: HttpMethod.POST, body: {
      "user_id": await getUserId(),
      "search": search,
    });
    MapeBusinessModel mapeBusinessModel = MapeBusinessModel.fromJson(apiData);
  }
}
