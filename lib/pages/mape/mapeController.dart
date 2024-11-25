import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import 'mapeModel.dart';

class MapeUserController extends GetxController implements GetxService {


  @override
  void onReady() {
    super.onReady();
    // print("onReady getAllUsersPost");
    getAllUserMape(search ?? "");
  }

  var search;
  var userProfileImage;

  getAllUserMape(String search) async {

    Map<String, dynamic> apiData = await ApiCall.instance
        .callApi(url: "https://forreal.net:4000/users/nearByBussiness", headers: await authHeader(), method: HttpMethod.POST, body: {
      "user_id": await getUserId(),
      "search": search,
    });
    MapeBusinessModel mapeBusinessModel = MapeBusinessModel.fromJson(apiData);
  }
}
