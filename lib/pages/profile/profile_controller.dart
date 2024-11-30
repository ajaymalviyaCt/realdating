import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import 'profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoadig = true.obs;
  final RxBool apiLoadingUploadImage = false.obs;
  ProfileModel? profileModel;

  RxString username = "".obs;
  RxString firstName = "User Name".obs;
  RxString idUser = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  RxString profileImage = ''.obs;

  //RxString profile_image1='0'.obs;

  @override
  void onReady() {
    super.onReady();
    profileDaitails();
  }

  Future<void> profileDaitails() async {
    Map<String, dynamic> apiData =
        await ApiCall.instance.callApi(url: "https://forreal.net:4000/users/myprofile", headers: await authHeader(), method: HttpMethod.POST, body: {
      "id": await getUserId(),
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    print("call  profileDaitails");
    final response = await BaseClient01().post(Appurls.profile, {
      "id": "$userId",
    });
    print(response.toString());

    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    profileModel = ProfileModel.fromJson(response);
    print("profile model data--------$profileModel");
    print("profile model data--------${profileModel?.userInfo.address}");

    username.value = profileModel!.userInfo.username;
    firstName.value = ProfileModel.fromJson(response).userInfo.firstName;
    idUser.value = ProfileModel.fromJson(response).userInfo.id.toString();
    lastName.value = ProfileModel.fromJson(response).userInfo.lastName;
    email.value = ProfileModel.fromJson(response).userInfo.email;
    profileImage.value = ProfileModel.fromJson(response).userInfo.profileImage;
    //  profile_image1.value=ProfileModel.fromJson(response).userInfo.profile_image1;
    isLoadig(false);
    update();
    // if (status) {
    //   Get.to(() => const UplodePhoto());
    // }
  }
}
