import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/base_client01.dart';
import 'my_all_dates_models.dart';

class MyAllDatesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    classifiedAllPost();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingPostToClassified = false.obs;
  RxInt isLoadingAceptedRequest = 9999.obs;

  MyAllDatesModel001? myAllDatesModel;

  Future<void> classifiedAllPost() async {
    isLoading.value = true;
  Map<String,dynamic>apiData=  await ApiCall.instance.callApi(
      url: "https://forreal.net:4000/users/ALL_sent_request",
      method: HttpMethod.POST,
      body: {
        'user_id': await getUserId()
      },
      headers:await authHeader()
    );

    myAllDatesModel = MyAllDatesModel001.fromJson(apiData);
    isLoading.value = false;

  }
}
