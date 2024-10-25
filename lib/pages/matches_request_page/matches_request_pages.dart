import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:realdating/pages/explore/matches/matches_controller.dart';
import 'package:realdating/pages/swipcard/swip_controller.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../services/base_client01.dart';
import 'matches_request_controller.dart';

class MatchesRequestPages extends StatefulWidget {
  const MatchesRequestPages({super.key});

  @override
  State<MatchesRequestPages> createState() => _MatchesRequestPagesState();
}

class _MatchesRequestPagesState extends State<MatchesRequestPages> {
  MatchesRequestController matchesRequestController = Get.put(MatchesRequestController());
  MatchessController matchessController = Get.put(MatchessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Matches Request")),
      body: Obx(
        () => matchesRequestController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Obx(
                () => matchesRequestController.myFriendsRequest.isEmpty
                    ? const Center(
                        child: Text("No Data Found"),
                      )
                    : ListView.builder(
                        itemCount:
                            matchesRequestController.myFriendsRequest.length,
                        itemBuilder: (context, index){
                          return Container(
                            decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0xFFD9D9D9),
                                    blurRadius: 24,
                                    offset: Offset(-3, 0),
                                    spreadRadius: 4,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //first row
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              '${matchesRequestController.myFriendsRequest[index].senderInfo?[0].profileImage}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                    ),
                                    10.w.widthBox,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '  ${matchesRequestController.myFriendsRequest[index].senderInfo?[0].firstName}',
                                          style: TextStyle(
                                            color: const Color(0xFF111111),
                                            fontSize: 18.adaptSize,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                matchesRequestController
                                                    .isLoadingAceptedReq
                                                    .value = true;
                                                matchesRequestController
                                                    .indexValueapcepted
                                                    .value = index;
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var userId =
                                                    prefs.getInt('user_id');
                                                final response =
                                                    await BaseClient01().post(Uri.parse('https://forreal.net:4000/users/add_friend'),
                                                        {
                                                      'reciver_id': '$userId',
                                                      'sender_id':
                                                          '${matchesRequestController.myFriendsRequest[index].senderId}',
                                                      'status': '1'
                                                    });
                                                sendNotification(
                                                    "${matchesRequestController.myFriendsRequest[index].senderId}",
                                                    "accept_your_match_request");
                                                matchesRequestController
                                                    .isLoadingAceptedReq
                                                    .value = false;
                                                // matchesRequestController.getMyFriendRequestModelMethod(false);

                                                setState(() {
                                                  matchesRequestController
                                                      .getMyFriendRequestModelMethod(
                                                          false);
                                                  matchessController.matches();

                                                });
                                              },
                                              child: Obx(
                                                () => Container(
                                                  width: 100.w,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        begin: Alignment(
                                                            0.00, -1.00),
                                                        end: Alignment(0, 1),
                                                        colors: [
                                                          Colors.green,
                                                          Colors.green,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: matchesRequestController
                                                                .indexValueapcepted
                                                                .value ==
                                                            index
                                                        ? matchesRequestController
                                                                .isLoadingAceptedReq
                                                                .value
                                                            ? const Center(
                                                                child: SizedBox(
                                                                    width: 20,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white,
                                                                      strokeWidth:
                                                                          2,
                                                                    )))
                                                            : Text(
                                                                'Accept',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12
                                                                      .adaptSize,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  height: 0,
                                                                  letterSpacing:
                                                                      -0.30,
                                                                ),
                                                              ).centered()
                                                        : Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  12.adaptSize,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                              letterSpacing:
                                                                  -0.30,
                                                            ),
                                                          ).centered(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                matchesRequestController
                                                    .isLoadingCancelReq
                                                    .value = true;
                                                matchesRequestController
                                                    .indexValue.value = index;
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var userId =
                                                    prefs.getInt('user_id');
                                                final response =
                                                    await BaseClient01().post(
                                                        Uri.parse(
                                                            'https://forreal.net:4000/users/add_friend'),
                                                        {
                                                      'reciver_id': '$userId',
                                                      'sender_id': '${matchesRequestController.myFriendsRequest[index].senderId}',
                                                      'status': '2'
                                                    });
                                                matchesRequestController
                                                    .isLoadingCancelReq
                                                    .value = false;
                                                // matchesRequestController.getMyFriendRequestModelMethod(false);

                                                setState(() {
                                                  matchesRequestController
                                                      .getMyFriendRequestModelMethod(
                                                          false);
                                                });
                                              },
                                              child: Obx(
                                                () => Container(
                                                  width: 100.w,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        begin: Alignment(
                                                            0.00, -1.00),
                                                        end: Alignment(0, 1),
                                                        colors: [
                                                          Color(0xFFF65F51),
                                                          Color(0xFFFB4967)
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: matchesRequestController
                                                                .indexValue
                                                                .value ==
                                                            index
                                                        ? matchesRequestController
                                                                .isLoadingCancelReq
                                                                .value
                                                            ? const Center(
                                                                child: SizedBox(
                                                                    width: 20,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white,
                                                                      strokeWidth:
                                                                          2,
                                                                    )))
                                                            : Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12
                                                                      .adaptSize,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  height: 0,
                                                                  letterSpacing:
                                                                      -0.30,
                                                                ),
                                                              ).centered()
                                                        : Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  12.adaptSize,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                              letterSpacing:
                                                                  -0.30,
                                                            ),
                                                          ).centered(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        4.ah.heightBox,
                                      ],
                                    ),
                                    //icon x right
                                    /// end
                                  ],
                                ),
                              ],
                            ).paddingAll(15),
                          ).paddingOnly(top: 20, left: 20, right: 20);
                        },
                      ),
              ),
      ),
    );
  }
}
