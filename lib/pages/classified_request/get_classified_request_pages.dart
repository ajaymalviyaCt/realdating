import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:realdating/widgets/size_utils.dart';

import 'package:velocity_x/velocity_x.dart';
import 'get_classified_request_controllers.dart';

class GetClassifiedRequestPage extends StatefulWidget {
  const GetClassifiedRequestPage({super.key});

  @override
  State<GetClassifiedRequestPage> createState() => _GetClassifiedRequestPageState();
}

class _GetClassifiedRequestPageState extends State<GetClassifiedRequestPage> {
  final GetClassifiedRequestController classifiedRequestC = Get.put(GetClassifiedRequestController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void _openEndDrawer() {
    print("_openEndDrawer");
    scaffoldKey.currentState!.openEndDrawer(); // Open the right drawer
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classifiedRequestC.GetClassifiedRequestMethod(true);
  }

  //for filtteing check box
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await classifiedRequestC.GetClassifiedRequestMethod(true);
        },
        child: Scaffold(
          key: scaffoldKey,
          endDrawer: endDrawer(context),
          appBar: preferredSizeAppBar("Classified Request", "assets/icons/filter.svg", () {
            _openEndDrawer();
          }),
          body: Obx(
            () => classifiedRequestC.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Obx(
                    () => RefreshIndicator(
                      onRefresh: () async {
                        await classifiedRequestC.GetClassifiedRequestMethod(true);
                      },
                      child: classifiedRequestC.filteredClassifiedRequests.isEmpty
                          ? const Center(
                              child: Text("No Request Found !!"),
                            )
                          : ListView.builder(
                              itemCount: classifiedRequestC.filteredClassifiedRequests.length,
                              itemBuilder: (context, index) {
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
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${classifiedRequestC.filteredClassifiedRequests[index].invitedBy?.profileImage.toString()}',
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: const OvalBorder(),
                                              ),
                                            ),
                                          ),
                                          10.w.widthBox,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${classifiedRequestC.filteredClassifiedRequests[index].invitedBy!.firstName} ${classifiedRequestC.filteredClassifiedRequests[index].invitedBy!.lastName}',
                                                style: TextStyle(
                                                  color: const Color(0xFF111111),
                                                  fontSize: 18.adaptSize,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                  letterSpacing: -0.30,
                                                ),
                                              ),
                                              4.ah.heightBox,
                                              SizedBox(
                                                width: 32,
                                                height: 12,
                                                child: Text(
                                                  ' Artist',
                                                  style: TextStyle(
                                                    color: const Color(0xFFAAAAAA),
                                                    fontSize: 10.adaptSize,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                    letterSpacing: -0.30,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                          //icon x right
                                          const Spacer(),
                                          SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: SvgPicture.asset(
                                              "assets/icons/arrow_green.svg",
                                              color: Colors.black,
                                            ),
                                          ),
                                          12.w.widthBox,
                                          Text(
                                            'Open Request',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.adaptSize,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                              letterSpacing: -0.30,
                                            ),
                                          ).centered(),

                                          /// end
                                        ],
                                      ),
                                      //first  end

                                      //second  row
                                      16.ah.heightBox,
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/calender.svg'),
                                          10.w.widthBox,
                                          Text(
                                            '${classifiedRequestC.filteredClassifiedRequests[index].date}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.adaptSize,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset('assets/icons/clock.svg'),
                                          10.w.widthBox,
                                          Text(
                                            '${classifiedRequestC.filteredClassifiedRequests[index].time}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.adaptSize,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset('assets/icons/a_haertbit.svg'),
                                          10.w.widthBox,
                                          Text(
                                            classifiedRequestC.filteredClassifiedRequests[index].activity,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),

                                      //3rd  row
                                      22.5.ah.heightBox,
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/a_location.svg'),
                                          12.w.widthBox,
                                          SizedBox(
                                            width: 230.w,
                                            child: Text(
                                              '${classifiedRequestC.filteredClassifiedRequests[index].location}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.adaptSize,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: -0.30,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              classifiedRequestC.indexselect.value = index;
                                              classifiedRequestC.aceptedRejectMethod("${classifiedRequestC.filteredClassifiedRequests[index].invitedBy!.id}",
                                                  "${classifiedRequestC.filteredClassifiedRequests[index].id}");
                                              classifiedRequestC.GetClassifiedRequestMethod(false);
                                              // setState(() {
                                              //
                                              // });
                                            },
                                            child: Obx(
                                              () => Container(
                                                width: 110.w,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    gradient: const LinearGradient(
                                                      begin: Alignment(0.00, -1.00),
                                                      end: Alignment(0, 1),
                                                      colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                    ),
                                                    borderRadius: BorderRadius.circular(30)),
                                                child: Center(
                                                  child: classifiedRequestC.isLoadingApceted.value
                                                      ? classifiedRequestC.indexselect.value == index
                                                          ? const SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: CircularProgressIndicator(
                                                                color: Colors.white,
                                                                strokeWidth: 2,
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
                                                            )
                                                      : Center(
                                                          child: Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13.adaptSize,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w600,
                                                              height: 0,
                                                              letterSpacing: -0.30,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                // child: Padding(
                                                //   padding:
                                                //   const EdgeInsets
                                                //       .all(4.0),
                                                //   child:Obx(() => classifiedRequestC.indexselect.value==index ?
                                                //   const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)) :
                                                //   classifiedRequestC.isLoadingApcepted.value  ?  const Center(child: Padding(
                                                //         padding: EdgeInsets.only(left: 4.0,right: 4),
                                                //         child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),
                                                //       )) :  Text(
                                                //       'Accept',
                                                //       style: TextStyle(
                                                //         color: Colors.white,
                                                //         fontSize: 13.adaptSize,
                                                //         fontFamily: 'Inter',
                                                //         fontWeight:
                                                //         FontWeight.w600,
                                                //         height: 0,
                                                //         letterSpacing:
                                                //         -0.30,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).paddingAll(15),
                                ).paddingOnly(top: 20, left: 20, right: 20);
                              },
                            ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Drawer endDrawer(context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Request Filters',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.09,
            ),
          ),
          40.ah.heightBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Obx(
                  () => Checkbox(
                    value: classifiedRequestC.value1.value,
                    onChanged: (value) {
                      classifiedRequestC.value1.value = value!;
                      classifiedRequestC.value2.value = false;
                      classifiedRequestC.value3.value = false;
                      classifiedRequestC.value4.value = false;
                      if (value) {
                        classifiedRequestC.searchQuery.value = "Sports Events";
                      } else {
                        classifiedRequestC.searchQuery.value = "";
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Sports Events',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ],
          ),
          const SizedBox(height: 37),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Obx(
                  () => Checkbox(
                    value: classifiedRequestC.value2.value,
                    onChanged: (value) {
                      classifiedRequestC.value2.value = value!;
                      classifiedRequestC.value1.value = false;
                      classifiedRequestC.value3.value = false;
                      classifiedRequestC.value4.value = false;

                      if (value) {
                        classifiedRequestC.searchQuery.value = "Concerts";
                      } else {
                        classifiedRequestC.searchQuery.value = "";
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Concerts',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.adaptSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ],
          ),
          const SizedBox(height: 37),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Obx(
                  () => Checkbox(
                    value: classifiedRequestC.value3.value,
                    onChanged: (value) {
                      classifiedRequestC.value3.value = value!;
                      classifiedRequestC.value2.value = false;
                      classifiedRequestC.value4.value = false;
                      classifiedRequestC.value1.value = false;
                      if (value) {
                        classifiedRequestC.searchQuery.value = "Fine Dining";
                      } else {
                        classifiedRequestC.searchQuery.value = "";
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Fine Dining',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.adaptSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ],
          ),
          const SizedBox(height: 37),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Obx(
                  () => Checkbox(
                    value: classifiedRequestC.value4.value,
                    onChanged: (value) {
                      classifiedRequestC.value4.value = value!;
                      classifiedRequestC.value2.value = false;
                      classifiedRequestC.value1.value = false;
                      classifiedRequestC.value3.value = false;

                      if (value) {
                        classifiedRequestC.searchQuery.value = "Coffee";
                      } else {
                        classifiedRequestC.searchQuery.value = "";
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Coffee',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.adaptSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ],
          ),
        ],
      ).paddingOnly(left: 30, right: 30, top: 40),
    );
  }

  PreferredSize preferredSizeAppBar(String title, String icon, Function()? onTap) {
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
              fontSize: 18.adaptSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 54.08.ah,
              height: 52.ah,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E6EA)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Center(child: SvgPicture.asset(icon)),
            ).paddingOnly(right: 16.w),
          )
        ],
      ).paddingOnly(top: 15.ah),
    );
  }
}
