//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:realdating/pages/reels/reelController.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:realdating/pages/reels/reelModel.dart';
// import '../../consts/app_colors.dart';
// import '../../consts/app_urls.dart';
// import '../../services/base_client01.dart';
// import '../../widgets/custom_text_styles.dart';
// import '../dash_board_page.dart';
// import '../video_player.dart';
// import '../video_screen/video_player_iten.dart';
//
// class WatchReels extends StatefulWidget {
//   const WatchReels({super.key});
//
//   @override
//   State<WatchReels> createState() => _WatchReelsState();
// }
//
// class _WatchReelsState extends State<WatchReels> {
//   // ReelsController reelController = Get.put(ReelsController());
//
//   GetReelsModel? getReelModel;
//    bool isLoadig =false;
//   Future<void> watchReels() async {
//     isLoadig =true;
//     setState(() {
//
//     });
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
//     isLoadig=false;
//     setState(() {
//
//     });
//   }
//
//
//    @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     watchReels();
//     print("asdfgfds");
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: InkWell(
//             onTap: () {
//               print("Go back");
//               Get.off(() => const DashboardPage());
//             },
//             child: Container(
//               margin: EdgeInsets.only(top: 5, bottom: 5, left: 10),
//               width: 35,
//               height: 35,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 border: Border.all(
//                   color: Color(0xFFE8E6EA),
//                   // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
//                   width: 1.0, // Border width
//                 ),
//                 color: const Color(
//                     0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
//               ),
//               child: Icon(
//                 Icons.arrow_back_ios_outlined,
//                 color: colors.primary,
//                 size: 18,
//               ),
//             ),
//           ),
//           centerTitle: true,
//           title: customTextCommon(
//             text: 'Reels',
//             fSize: 24,
//             fWeight: FontWeight.w600,
//             lineHeight: 24,
//           ),
//         ),
//         body:isLoadig ? Center(child: Text("loading."),) : PageView.builder(
//           itemCount: getReelModel?.reels?.length,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) {
//             var data;
//             data = getReelModel?.reels?[index].reel;
//
//             return Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Stack(
//                 children: [
//                   Container(
//                     height: double.infinity,
//                     child: VideoPlayerItem(
//                         videoUrl:
//                             "${getReelModel?.reels?[index].reel}"),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Container(
//                         height: 80,
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 25),
//                         // decoration: BoxDecoration(color: Colors.black.withOpacity(0.2),borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                                   getReelModel
//                                   ?.reels?[index].reelName??"",
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.8),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   fontFamily: "Poppins"),
//                             ),
//                             Text(
//                               "Totel Likes : ${getReelModel!.reels![index].totalLikes.toString()}",
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.8),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                   fontFamily: "Poppins"),
//                             ),
//                             Text(
//                               "Totel Comments : ${getReelModel!.reels![index].totalComments.toString()}",
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.8),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                   fontFamily: "Poppins"),
//                             ),
//                           ],
//                         )),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }
