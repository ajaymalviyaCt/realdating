import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import 'profile_model.dart';

class ProfileController extends GetxController {
  RxBool isLoadig = true.obs;
  final RxBool apiLoadingUploadImage = false.obs;
  ProfileModel? profileModel;
  List<String> interests = [];
  List<String> hobbiesData = [];

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



    if (profileModel?.userInfo.interest != null &&
        profileModel!.userInfo.interest.isNotEmpty) {
      interests = profileModel!.userInfo.interest.split(',').map((e) => e.trim()).toList();
    }
    print("Parsed interests: $interests");

    if (profileModel?.userInfo.hobbies != null &&
        profileModel!.userInfo.hobbies.isNotEmpty) {
      hobbiesData = profileModel!.userInfo.hobbies.split(',').map((e) => e.trim()).toList();
    }

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
