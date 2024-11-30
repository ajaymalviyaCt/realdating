import 'package:get/get.dart';
import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../hobbies/hobbys.dart';

class InterestController extends GetxController {
  // TextEditingController emailController =    TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  RxBool isLoadig = false.obs;
  RxString inrest = "".obs;

  @override
  void onReady() {
    super.onReady();
  }

  // Future<void> devicTypeCheck()async{
  //   if (Platform.isAndroid) {
  //     var androidInfo = await DeviceInfoPlugin().androidInfo;
  //     var release = androidInfo.version.release;
  //     var sdkInt = androidInfo.version.sdkInt;
  //     var manufacturer = androidInfo.manufacturer;
  //     var model = androidInfo.model;
  //     print('Android $release (SDK $sdkInt), $manufacturer $model');
  //     deviceType="0";
  //   }else{
  //     deviceType="1";
  //   }
  // }

  interestSelect(String interstSelect) async {
    print("call  interestSelect");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.gender, {"Interest": "$interstSelect", "profile_status": "2"});
    print(response.toString());
    print(interstSelect.toString());
    isLoadig(false);
    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    if (status) {
      Get.to(() => const HobbiesPage());
    }
  }
}
