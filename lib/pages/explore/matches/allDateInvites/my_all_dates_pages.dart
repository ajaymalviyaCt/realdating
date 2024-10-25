import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/chat/screens/home_screen.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/services/base_client01.dart';
import 'package:get/get.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../chat/api/apis.dart';
import '../../../../chat/helper/dialogs.dart';
import '../../../../consts/app_colors.dart';
import '../../../../widgets/custom_text_styles.dart';
import '../matchDetsils.dart';
import '../matches_controller.dart';
import 'my_all_dates_controllers.dart';

class MyAllDatesPage extends StatefulWidget {
  const MyAllDatesPage({super.key});

  @override
  State<MyAllDatesPage> createState() => _MyAllDatesPageState();
}

class _MyAllDatesPageState extends State<MyAllDatesPage> {
  final MyAllDatesController myAllDatesController = Get.put(MyAllDatesController());
  final MatchessController matchesController = Get.put(MatchessController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
            // print("Go back");
            // Get.off(() => const DashboardPage());
          },
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: const Color(0xFFE8E6EA),
                // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                width: 1.0, // Border width
              ),
              color: const Color(
                  0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
            ),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: colors.primary,
              size: 18,
            ),
          ),
        ),
        centerTitle: true,
        title: customTextCommon(
          text: 'My all Dates',
          fSize: 22,
          fWeight: FontWeight.w600,
          lineHeight: 24,
        ),
      ),

      // appBar: preferredSizeAppBar(
      //     "My all dates", "assets/icons/filter.svg", () {
      // }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => myAllDatesController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await myAllDatesController.classifiedAllPost();
                      },
                      child:
                          myAllDatesController.myAllDatesModel?.myInvites?.length != 0
                              ? ListView.builder(
                                  itemCount: myAllDatesController
                                      .myAllDatesModel?.myInvites?.length,
                                  itemBuilder: (context, index) {
                                    return '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' == "Received" &&
                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                "2"
                                        ? const SizedBox()
                                        : '${myAllDatesController.myAllDatesModel?.myInvites?[index].classifiedPost}' ==
                                                "1"
                                            ? Container()
                                            : Container(
                                                decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xFFD9D9D9),
                                                        blurRadius: 24,
                                                        offset: Offset(-3, 0),
                                                        spreadRadius: 4,
                                                      )
                                                    ]),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    //first row
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            Get.to(()=>MatchDetails(id: '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' =="Received" ?
                                                              "${myAllDatesController.myAllDatesModel?.myInvites![index].invitedBy!.id}" :"${myAllDatesController.myAllDatesModel?.myInvites![index].invitedTo!.id}", isfriend: true,));
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                const AssetImage(
                                                                    "assets/icons/profile.svg"),
                                                            child: Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                            "Received"
                                                                        ? '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.profileImage.toString()}'
                                                                        : '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                                "2"
                                                                            ? '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.profileImage}'
                                                                            : '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedTo?.profileImage}',
                                                                  ),
                                                                  fit:
                                                                      BoxFit.fill,
                                                                ),
                                                                shape:
                                                                    const OvalBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                      "Received"
                                                                  ? '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.firstName} ${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.lastName}'
                                                                  : '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "2"
                                                                      ? '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.firstName} ${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.lastName}'
                                                                      : '${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedTo?.firstName} ${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedTo?.lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14.adaptSize,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    -0.10,
                                                              ),
                                                            ),
                                                            4.ah.heightBox,
                                                            SizedBox(
                                                              width: 32,
                                                              height: 12,
                                                              child: Text(
                                                                ' Artist',
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0xFFAAAAAA),
                                                                  fontSize:
                                                                      10.adaptSize,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0,
                                                                  letterSpacing:
                                                                      -0.30,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Column(
                                                          children: [
                                                            //icon x right
                                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                    "Received"
                                                                ? Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        "assets/icons/A1arrow_received.svg",
                                                                        height:
                                                                            12,
                                                                      ),
                                                                      5.widthBox,
                                                                      "Rececived"
                                                                          .text
                                                                          .base
                                                                          .red600
                                                                          .medium
                                                                          .make(),
                                                                    ],
                                                                  )
                                                                : const SizedBox(),
                                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                    "Requested"
                                                                ? Row(
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        "assets/icons/A1arrow_requested.svg",
                                                                        height:
                                                                            12,
                                                                      ),
                                                                      7.widthBox,
                                                                      "Requested"
                                                                          .text
                                                                          .base
                                                                          .medium
                                                                          .make(),
                                                                    ],
                                                                  )
                                                                : const SizedBox(),
                                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                    "accepted"
                                                                ? SvgPicture
                                                                    .asset(
                                                                    "assets/icons/A1arrow_received.svg",
                                                                  )
                                                                : const SizedBox(),
                                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                    "rejected"
                                                                ? SvgPicture
                                                                    .asset(
                                                                    "assets/icons/zzzz__Rejected.svg",
                                                                  )
                                                                : const SizedBox(),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    //first  end

                                                    //second  row
                                                    16.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.calendar_month,
                                                          color:
                                                              Appcolor.Redpink,
                                                          size: 20,
                                                        ),
                                                        // SvgPicture.asset(
                                                        //     'assets/icons/calender.svg'),
                                                        10.w.widthBox,
                                                        Text(
                                                          '${myAllDatesController.myAllDatesModel?.myInvites?[index].date}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.adaptSize,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        const Icon(
                                                          Icons
                                                              .watch_later_outlined,
                                                          color:
                                                              Appcolor.Redpink,
                                                          size: 20,
                                                        ),

                                                        10.w.widthBox,
                                                        Text(
                                                          '${myAllDatesController.myAllDatesModel?.myInvites?[index].time}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.adaptSize,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        const Icon(
                                                          Icons
                                                              .monitor_heart_outlined,
                                                          color:
                                                              Appcolor.Redpink,
                                                          size: 20,
                                                        ),

                                                        10.w.widthBox,
                                                        Text(
                                                          '${myAllDatesController.myAllDatesModel?.myInvites?[index].activity}',
                                                          style:
                                                               TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.adaptSize,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),

                                                    //3rd  row
                                                    22.5.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color:
                                                              Appcolor.Redpink,
                                                          size: 20,
                                                        ),
                                                        12.w.widthBox,
                                                        SizedBox(
                                                          width: 230.w,
                                                          child: Text(
                                                            '${myAllDatesController.myAllDatesModel?.myInvites?[index].location}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.adaptSize,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                              letterSpacing:
                                                                  -0.30,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        '${myAllDatesController.myAllDatesModel?.myInvites?[index].requestStatus}' ==
                                                                "Received"
                                                            ? Column(
                                                                children: [
                                                                  '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "1"
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await APIs.addChatUser("${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedBy?.id}").then((value) {
                                                                              if (!value) {
                                                                                Dialogs.showSnackbar(context, 'User does not Exists!');
                                                                              }
                                                                            });
                                                                            Get.to(() => const HomeScreen())?.then((value) =>
                                                                                {});
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.w,
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [
                                                                                    Color(0xFFF65F51),
                                                                                    Color(0xFFFB4967)
                                                                                  ],
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(30)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Text(
                                                                                'Message',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 13.adaptSize,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ).centered(),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : const SizedBox(),
                                                                  // '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                  //         "2"
                                                                  //     ? Container(
                                                                  //         width:
                                                                  //             150.w,
                                                                  //         height:
                                                                  //             30,
                                                                  //         decoration: BoxDecoration(
                                                                  //             gradient: const LinearGradient(
                                                                  //               begin: Alignment(0.00, -1.00),
                                                                  //               end: Alignment(0, 1),
                                                                  //               colors: [
                                                                  //                 Color(0xFFF65F51),
                                                                  //                 Color(0xFFFB4967)
                                                                  //               ],
                                                                  //             ),
                                                                  //             borderRadius: BorderRadius.circular(30)),
                                                                  //         child:
                                                                  //             Padding(
                                                                  //           padding:
                                                                  //               const EdgeInsets.all(4.0),
                                                                  //           child:
                                                                  //               Text(
                                                                  //             'Post to Classifiedd',
                                                                  //             style: TextStyle(
                                                                  //               color: Colors.white,
                                                                  //               fontSize: 13.adaptSize,
                                                                  //               fontFamily: 'Inter',
                                                                  //               fontWeight: FontWeight.w600,
                                                                  //               height: 0,
                                                                  //               letterSpacing: -0.30,
                                                                  //             ),
                                                                  //           ).centered(),
                                                                  //         ),
                                                                  //       )
                                                                  //     : const SizedBox(),
                                                                  '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "0"
                                                                      ? Row(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                // myAllDatesController.isLoadingAceptedRequest.value = true;
                                                                                final response = await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/accept_reject_invite_request"), {
                                                                                  "invite_id": "${myAllDatesController.myAllDatesModel?.myInvites?[index].id}",
                                                                                  "status": "1"
                                                                                });
                                                                                // myAllDatesController.isLoadingAceptedRequest.value = false;
                                                                                await myAllDatesController.classifiedAllPost();
                                                                                await matchesController.matches();

                                                                                setState(() {});
                                                                              },
                                                                              child: Container(
                                                                                width: 100.w,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                    gradient: const LinearGradient(
                                                                                      begin: Alignment(0.00, -1.00),
                                                                                      end: Alignment(0, 1),
                                                                                      colors: [
                                                                                        Color(0xFFF65F51),
                                                                                        Color(0xFFFB4967)
                                                                                      ],
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(30)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                  child: Obx(
                                                                                    () => myAllDatesController.isLoadingAceptedRequest.value == index
                                                                                        ? const Center(
                                                                                            child: SizedBox(
                                                                                            height: 20,
                                                                                            width: 20,
                                                                                            child: SizedBox(
                                                                                                width: 20,
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: Colors.white,
                                                                                                  strokeWidth: 1,
                                                                                                )),
                                                                                          ))
                                                                                        : Text(
                                                                                            'Accept',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontSize: 13.adaptSize,
                                                                                              fontFamily: 'Inter',
                                                                                              fontWeight: FontWeight.w600,
                                                                                              height: 0,
                                                                                              letterSpacing: -0.30,
                                                                                            ),
                                                                                          ).centered(),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            10.widthBox,
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                final response = await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/accept_reject_invite_request"), {
                                                                                  "invite_id": "${myAllDatesController.myAllDatesModel?.myInvites?[index].id}",
                                                                                  "status": "2"
                                                                                });
                                                                                await myAllDatesController.classifiedAllPost();
                                                                              },
                                                                              child: Container(
                                                                                width: 100.w,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0xFFFB4967))),
                                                                                child: Text(
                                                                                  'Cancel',
                                                                                  style: TextStyle(
                                                                                    color: const Color(0xFFFB4967),
                                                                                    fontSize: 13.adaptSize,
                                                                                    fontFamily: 'Inter',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 0,
                                                                                    letterSpacing: -0.30,
                                                                                  ),
                                                                                ).centered(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                ],
                                                              )
                                                            : Column(
                                                                children: [
                                                                  '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "1"
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await APIs.addChatUser("${myAllDatesController.myAllDatesModel?.myInvites?[index].invitedTo?.id}").then((value) {
                                                                              if (!value) {
                                                                                Dialogs.showSnackbar(context, 'User does not Exists!');
                                                                              }
                                                                            });
                                                                            Get.to(() => const HomeScreen())?.then((value) =>
                                                                                {});
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                100.w,
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [
                                                                                    Color(0xFFF65F51),
                                                                                    Color(0xFFFB4967)
                                                                                  ],
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(30)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Text(
                                                                                'Message',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 13.adaptSize,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ).centered(),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : const SizedBox(),
                                                                  '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "2"
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            myAllDatesController.isLoadingPostToClassified.value =
                                                                                true;
                                                                            final response =
                                                                                await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/create_classified_request"), {
                                                                              'invite_id': '${myAllDatesController.myAllDatesModel?.myInvites?[index].id

                                                                                }',
                                                                            });
                                                                            myAllDatesController.isLoadingPostToClassified.value =
                                                                                false;
                                                                            await myAllDatesController.classifiedAllPost();
                                                                            print("response${response.toString()}");
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                140.w,
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [
                                                                                    Color(0xFFF65F51),
                                                                                    Color(0xFFFB4967)
                                                                                  ],
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(30)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Text(
                                                                                'Post to Classified',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 13.adaptSize,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ).centered(),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : const SizedBox(),
                                                                  '${myAllDatesController.myAllDatesModel?.myInvites?[index].status}' ==
                                                                          "0"
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            final response =
                                                                                await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/reject_request"), {
                                                                              "invite_id": "${myAllDatesController.myAllDatesModel?.myInvites?[index].id}",
                                                                              "status": "2"
                                                                            });
                                                                            await myAllDatesController.classifiedAllPost();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                140.w,
                                                                            height:
                                                                                30,
                                                                            decoration: BoxDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [
                                                                                    Color(0xFFF65F51),
                                                                                    Color(0xFFFB4967)
                                                                                  ],
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(30)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Text(
                                                                                'Cancel Request',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 13.adaptSize,
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0,
                                                                                  letterSpacing: -0.30,
                                                                                ),
                                                                              ).centered(),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : const SizedBox(),
                                                                ],
                                                              ),
                                                      ],
                                                    ),
                                                  ],
                                                ).paddingAll(15),
                                              ).paddingOnly(
                                                top: 20, left: 20, right: 20);
                                  },
                                )
                              : const Center(child: Text("No Data Found !!")),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  PreferredSize preferredSizeAppBar(
      String title, String icon, Function()? onTap) {
    return PreferredSize(
      preferredSize: Size.fromHeight(114.ah), // preferred height for the app bar
      child: Row(
        children: [
          Container(
            width: 54.08.ah,
            height: 52.ah,
            decoration: ShapeDecoration(
              // color: Colors.white,
              shape: RoundedRectangleBorder(
                // side: const BorderSide(width: 1, color: Color(0xFFE8E6EA)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // child: Center(
            //     child: SvgPicture.asset("assets/icons/backbuttonIcon.svg")),
          ).paddingOnly(
            left: 16.w,
          ),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF111111),
              fontSize: 20.adaptSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 54.08.ah,
              height: 52.ah,
              // child: Center(child: SvgPicture.asset("$icon")),
            ).paddingOnly(right: 16.w),
          )
        ],
      ).paddingOnly(top: 62.ah, bottom: 14.ah),
    );
  }

  void _addChatUserDialog(context) {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child:  Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16.adaptSize))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await APIs.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child:  Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16.adaptSize),
                    ))
              ],
            ));
  }
}
