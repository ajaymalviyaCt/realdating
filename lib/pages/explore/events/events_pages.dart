import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:realdating/widgets/custom_text_styles.dart';

import '../../../consts/app_colors.dart';
import '../../../function/function_class.dart';
import 'create/createEvent.dart';
import 'eventDetails.dart';
import 'events_controller.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventsController eventsController = Get.put(EventsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventsController.Events();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: preferredSizeAppBar("Events", "assets/icons/+.svg", () {
        Get.to(() => const CreateEvent());
      }),
      body: Obx(
        () => eventsController.isLoadig.value
            ? const Center(child: CircularProgressIndicator())
            : eventsController.matchessModel!.getEvents.isNotEmpty
                ? GridView.builder(
                    itemCount: eventsController.matchessModel?.getEvents.length,
                    padding: const EdgeInsets.all(18),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      // childAspectRatio: 50/100
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => EventDetails(id: eventsController.matchessModel!.getEvents[index].id.toString() ?? "1"),
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          child: Card(
                            elevation: 0,
                            color: Colors.white.withOpacity(.20),
                            child: Stack(children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      eventsController.matchessModel!.getEvents[index].eventImage.isNotEmpty
                                          ? eventsController.matchessModel!.getEvents[index].eventImage
                                          : "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 10,
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(.60), borderRadius: BorderRadius.circular(30)),
                                  height: 32,
                                  width: 105,
                                  child: Center(
                                      child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: customTextCommon(
                                          text: eventsController.matchessModel?.getEvents[index].eventType ?? "Event Online",
                                          fSize: 12,
                                          fWeight: FontWeight.w500,
                                          lineHeight: 10,
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(.60),
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0))),
                                  height: 54,
                                  width: 180,
                                ),
                              ),
                              Positioned(
                                bottom: 32,
                                left: 5,
                                child: customTextCommon(
                                  text: eventsController.matchessModel!.getEvents[index].eventTitle,
                                  fSize: 15,
                                  fWeight: FontWeight.w600,
                                  lineHeight: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: 3,
                                left: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/clender.svg",
                                            ),
                                            const SizedBox(
                                              width: 3.5,
                                            ),
                                            customTextCommon(
                                              text: eventsController.matchessModel!.getEvents[index].startDate,
                                              fSize: 10,
                                              fWeight: FontWeight.w500,
                                              lineHeight: 16,
                                              color: const Color(0xffEBEBF5).withOpacity(.70),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Row(
                                          children: [
                                            customTextCommon(
                                              text: '-  ${eventsController.matchessModel!.getEvents[index].endDate}',
                                              fSize: 10,
                                              fWeight: FontWeight.w500,
                                              lineHeight: 16,
                                              color: const Color(0xffEBEBF5).withOpacity(.70),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          color: Appcolor.ggrry,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          eventsController.matchessModel!.getEvents[index].selectTime,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: const Color(0xffEBEBF5).withOpacity(.70),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No Data Found")),
      ),
    );
  }

  PreferredSize preferredSizeAppBar(String title, String icon, Function()? onTap) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.h), // preferred height for the app bar
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(0xFFE8E6EA),
                    // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                    width: 1.0, // Border width
                  ),
                  color: const Color(0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
                ),
                child: const Icon(Icons.arrow_back_ios_outlined, color: colors.primary, size: 18),
              ).paddingOnly(
                left: 16.w,
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 20.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 54.08.h * .90,
                height: 52.h * .90,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFE8E6EA)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Center(
                    child: Icon(
                  Icons.add,
                  color: Appcolor.Redpink,
                  size: 25,
                )),
              ).paddingOnly(right: 16.w),
            )
          ],
        ).paddingOnly(top: 20.h, bottom: 14.h),
      ),
    );
  }
}
