// import 'package:flutter/material.dart';
// import 'package:realdating/pages/homepage/userHomeController.dart';
// import 'package:get/get.dart';
//
// import '../../../function/function_class.dart';
// import '../../swipcard/swip_controller.dart';
//
// class UserCommentScreen extends StatefulWidget {
//   UserCommentScreen({super.key});
//
//   @override
//   State<UserCommentScreen> createState() => _UserCommentScreenState();
// }
//
// class _UserCommentScreenState extends State<UserCommentScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getAllBusinessPost();
//   }
//
//   SwipController swipController = Get.put(SwipController());
//
//   @override
//   Widget build(BuildContext context) {
//     final args = Get.arguments as int;
//     print("Geeta");
//     print(args);
//
//     // print(myDealController.allDataBusiness?.posts?[args].comments?[4].commentOwnerName);
//     return GetBuilder<UserHomeController>(initState: (state) {
//       UserHomeController();
//     }, builder: (controller) {
//       print(controller.userPostModel[args].comments?.length);
//       return Scaffold(
//         appBar: AppBar(
//             title: const Text("Comments"),
//             centerTitle: true,
//             backgroundColor: Colors.white),
//         floatingActionButton: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           height: 80,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 30, right: 0, bottom: 0, top: 0),
//                       child: Container(
//                         padding: const EdgeInsets.only(left: 10),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(color: Colors.grey)),
//                         child: TextField(
//                           // onSubmitted: (value) {
//                           //   var list;
//                           //   print("dsjfuidgfi");
//                           //   setState(() {
//                           //     list = myDealController.allDataBusiness;
//                           //     getAllBusinessPost();
//                           //   });
//                           // },
//                           controller: controller.commentText,
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Add a comment...',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 0.0),
//                     child: TextButton(
//                       onPressed: () async {
//                         controller.userCommentPost(
//                           controller.userPostModel[args].id,
//                         );
//                         controller.getAllUserPost();
//                         swipController.sendNotification(
//                             controller.userPostModel[args].userId, "comment");
//                       },
//                       child: const Text(
//                         'Post',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Appcolor.Redpink,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: "Aboshi",
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               controller.userPostModel[args].comments!.isNotEmpty
//                   ? ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: const EdgeInsets.only(bottom: 100, top: 30),
//                       itemCount:
//                           controller.userPostModel[args].comments?.length,
//                       itemBuilder: (context, index) {
//                         // final comment = comments[index];
//                         return ListTile(
//                           leading: CircleAvatar(
//                             // You can add user avatars here
//                             backgroundColor: Colors.blue,
//                             backgroundImage: NetworkImage(controller
//                                     .userPostModel[args]
//                                     .comments?[index]
//                                     .profileImage ??
//                                 ""),
//                             // child: Image.network( )
//                           ),
//                           title: Text(
//                             controller.userPostModel[args].comments?[index]
//                                     .commentOwnerName ??
//                                 "",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(controller.userPostModel[args]
//                                   .comments?[index].postComment ??
//                               "df"),
//                         );
//                       },
//                     )
//                   : Container(
//                       margin: const EdgeInsets.only(top: 100, bottom: 50),
//                       child: const Center(
//                         child: Text("comment not found "),
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
