import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realdating/function/function_class.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import 'events_details_controller.dart';


class EventDetails extends StatefulWidget {
  String id;

  EventDetails({super.key, required this.id});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  EventsDetailsController eventsDetailsController =
  Get.put(EventsDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventsDetailsController.Events(widget.id??"2");
  }

  var ticketsCount = 1;
  Future<void> fetchData() async {
    // Replace this with your actual API call logic
    await   eventsDetailsController.Events(widget.id);
    print("API call completed!");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Event Details", context),
      body: Obx(
            () => eventsDetailsController.isLoadig.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : FutureBuilder(
                future: fetchData(),
                builder: (context,snapshot){

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${eventsDetailsController.eventsDetailsModel?.getEvent[0].eventImage}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    eventsDetailsController.eventsDetailsModel?.getEvent[0].eventTitle?? ' Grand Concert',
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 18.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,color: Appcolor.Redpink,size: 20,),

                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        eventsDetailsController.eventsDetailsModel?.getEvent[0].startDate?? '12 Oct, 2023',
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      const Text('-',style: TextStyle(
                        color: Color(0xFF111111),
                         fontSize: 14,
                          fontFamily: 'Inter',
                         fontWeight: FontWeight.w500,
                       ),),
                      const SizedBox(
                        width: 9,
                      ),
                      Text(
                        eventsDetailsController.eventsDetailsModel?.getEvent[0].endDate??  '12 Oct, 2023',
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height:10,),
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined,color: Appcolor.Redpink,size: 20,),
                      const SizedBox(width:8,),
                      Text(
                        eventsDetailsController.eventsDetailsModel?.getEvent[0].selectTime??  '00:00',
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 341.w,
                    child: Text(
                      eventsDetailsController.eventsDetailsModel?.getEvent[0].description?? 'Tired of swiping and texting? Come, join us at our social mixer to meet potential dates and friends online.',
                      style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (1 < ticketsCount) {
                            ticketsCount--;
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 34.77,
                          height: 34.77,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.03),
                            ),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Color(0xFFF65F51),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${ticketsCount}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          ticketsCount++;
                          setState(() {});
                        },
                        child: Container(
                          width: 34.77,
                          height: 34.77,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33.03),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFFF65F51),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 350,
                    height: 56,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Buy Ticket(s)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ).paddingOnly(left: 20, right: 20, bottom: 20);
            }),
      ),
    );
  }
}

