// import 'dart:convert';
//
// import 'package:realdating/pages/reels/reelModel.dart';
// import 'package:get/get.dart';
// import 'package:reels_viewer/reels_viewer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../consts/app_urls.dart';
// import '../../services/base_client01.dart';
// import 'package:http/http.dart' as http;
//
// class ReelsController extends GetxController {
//   RxBool isLoadig = false.obs;
//   //
//   // @override
//   // void on() {
//   //   super.onReady();
//   //   watchReels();
//   // }
//
//   @override
//   void onInit() async {
//     print("call onInit");  // this line not printing
//     super.onInit();
//   }
//
//   GetReelsModel? getReelModel;
//
//   watchReels() async {
//     isLoadig(true);
//     final response = await BaseClient01().get(Appurls.getAllReels);
//     print("fsfsfsdfsfs");
//     print(response);
//     print("fsfsfsdfsfs");
//     print("fsfsfsdfsfs");
//     try {
//       getReelModel = GetReelsModel.fromJson(response);
//     } catch (e) {
//       print("sad1234567sfsffsf$e");
//     }
//     update();
//     isLoadig(false);
//   }
// }
