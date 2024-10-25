// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'my_invite_controller.dart';
//
// class MyInvitePage extends StatefulWidget {
//   const MyInvitePage({super.key});
//
//   @override
//   State<MyInvitePage> createState() => _MyInvitePageState();
// }
//
// class _MyInvitePageState extends State<MyInvitePage> {
//
//
//   MyInviteController myInviteController =Get.put(MyInviteController());
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: myInviteController.isLoadig.value ? const SizedBox(height : 100 ,width : 100 ,child : CircularProgressIndicator( )) : SafeArea(
//         child: Padding(
//           padding:  EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     height: 54,
//                     width: 54,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xffE8E6EA),width: 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                         child: IconButton(onPressed: () {  }, icon: Icon(Icons.arrow_back_ios_outlined,color: Color(0xffFA4B65)),
//                         )
//                     ),
//                   ),
//                   SizedBox(width : 70),
//                   Text("My Invite",style: TextStyle(
//                       fontFamily: "inter",
//                       fontWeight: FontWeight.w600,
//                       fontSize: 24
//                   ),),
//
//                 ],
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder:(context, index) {
//                     return Card(
//                       color: Color(0xffFFFFFF),
//                       child: Container(
//                           height: 82,
//                           width: MediaQuery.of(context).size.width,
//                           child : Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                         radius: 25,
//                                         child : Image.asset("assets/images/Rectangle 1092.png")
//                                     ),
//                                     SizedBox(width :10),
//                                     const Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Sophia",style: TextStyle(
//                                             fontFamily: "inter",
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18
//                                         ),),
//                                         Text("Artist",style: TextStyle(
//                                             fontFamily: "inter",
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 10
//                                         ),),
//
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 10),
//                                 Container(
//                                   height: 30,
//                                   width: 85,
//
//                                   decoration: BoxDecoration(
//                                       color: Color(0xffEDEDED),
//                                       borderRadius: BorderRadius.circular(30)
//                                   ),
//                                   child:  Center(
//                                     child: Text("Declined",style: TextStyle(
//                                         fontFamily: "inter",
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 14
//                                     ),),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                       ),
//                     );
//                   },),
//               ),
//             ],
//           ),
//         ),
//       ) ,
//     );
//   }
// }
