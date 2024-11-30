import 'package:get/get.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../hobbies/hobbys.dart';

class InterestController extends GetxController {
  RxBool isLoadig = false.obs;
  RxString inrest = "".obs;
  final List<String>? selectedInterest;

  InterestController({required this.selectedInterest});

  interestSelect(String interstSelect) async {
    print("call  interestSelect");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.gender, {"Interest": interstSelect, "profile_status": "2"});
    print(response.toString());
    print(interstSelect.toString());
    isLoadig(false);
    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    if (selectedInterest != null) {
      Get.back();
    } else {
      Get.to(() => const HobbiesPage());
    }
  }
}
