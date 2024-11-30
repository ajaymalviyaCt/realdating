import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';

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
    profileModel = ProfileModel.fromJson(apiData);
    username.value = profileModel!.userInfo.username;
    firstName.value = profileModel!.userInfo.firstName;
    idUser.value = profileModel!.userInfo.id.toString();
    lastName.value = profileModel!.userInfo.lastName;
    email.value = profileModel!.userInfo.email;
    profileImage.value = profileModel!.userInfo.profileImage;

    isLoadig(false);
    update();
  }
}
