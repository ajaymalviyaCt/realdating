import 'package:get/get.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';

import 'profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoadig = true.obs;
  final RxBool apiLoadingUploadImage = false.obs;
  final Rxn<ProfileModel> profileModel = Rxn<ProfileModel>();

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
    profileModel.value = ProfileModel.fromJson(apiData);
    username.value = profileModel.value!.userInfo.username;
    firstName.value = profileModel.value!.userInfo.firstName;
    idUser.value = profileModel.value!.userInfo.id.toString();
    lastName.value = profileModel.value!.userInfo.lastName;
    email.value = profileModel.value!.userInfo.email;
    profileImage.value = profileModel.value!.userInfo.profileImage;

    isLoadig(false);
    update();
  }
}
