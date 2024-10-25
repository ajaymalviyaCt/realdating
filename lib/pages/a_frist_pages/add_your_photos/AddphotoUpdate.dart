// import 'package:get/get.dart';
//
// import '../../../consts/app_urls.dart';
// import '../../../services/base_client01.dart';
// import '../location_enable/loctaion.dart';
//
// class AddphotoController extends GetxController {
// // TextEditingController emailController =    TextEditingController();
// // TextEditingController passwordController = TextEditingController();
//   RxBool isLoadig = false.obs;
//   // RxString hobbies = "".obs;
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//
//   interestSelect() async {
//     print("call  interestSelect");
//     isLoadig(true);
//     final response = await BaseClient01().post(Appurls.gender, {
//       "profile_status": "4"
//     });
//     print(response.toString());
//     isLoadig(false);
//     bool status = response["success"];
//     print("status ___$status");
//     var msg = response["message"];
//     print("msg ___$msg");
//     if (status) {
//       Get.to(() => const LocationScreen());
//     }
//   }
// }
