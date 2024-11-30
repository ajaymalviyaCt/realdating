import 'package:intl/intl.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:realdating/widgets/size_utils.dart';

import '../../../consts/app_colors.dart';
import '../../../reel/common_import.dart';
import '../../matches_request_page/matches_request_pages.dart';
import 'allDateInvites/my_all_dates_pages.dart';
import 'invite/invite_for_date_controller.dart';
import 'matchDetsils.dart';
import 'matches_controller.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  MatchessController matchessController = Get.find<MatchessController>();

  // matchessController matchessController = Get.put(matchessController());

  final _formKey = GlobalKey<FormState>();
  InvaiteForDatesController invaiteForDatesController = Get.put(InvaiteForDatesController());
  DateTime currentDate = DateTime.now();
  final List<String> genderItems = [
    'Sports Events',
    'Concerts',
    'Fine Dining',
    'Coffee',
  ];

  var selectedValue = "Sports Events";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate.subtract(
        const Duration(),
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        invaiteForDatesController.selectDateC.text = "${picked.month.toString()}-${picked.day.toString()}-${picked.year.toString()}";
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        String militaryTimeString = "${picked.hour}:${picked.minute.toString()}"; // Your 24-hour format time string
        DateFormat militaryFormat = DateFormat('HH:mm');
        DateFormat twelveHourFormat = DateFormat('h:mm a');
        DateTime parsedTime = militaryFormat.parse(militaryTimeString);
        String convertedTime = twelveHourFormat.format(parsedTime);
        print("asdfgfdsdfgfds$convertedTime");
        print("zccxccccccccccc${_selectedTime}");
        invaiteForDatesController.selectTimeC.text = "${convertedTime}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
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
                color: const Color(0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
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
            text: 'Matches',
            fSize: 24,
            fWeight: FontWeight.w600,
            lineHeight: 24,
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.to(() => const MatchesRequestPages());
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE8E6EA),
                      width: 1.0,
                    )),
                child: const Icon(
                  Icons.person,
                  color: Appcolor.Redpink,
                  size: 25,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => MyAllDatesPage());
              },
              child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE8E6EA),
                        width: 1.0,
                      )),
                  child: const Icon(
                    Icons.calendar_month,
                    color: Appcolor.Redpink,
                    size: 25,
                  )),
            ),
          ],
        ),
        body: Obx(() => matchessController.isLoadig.value
            ? Center(
                child: const CircularProgressIndicator(
                strokeWidth: 2,
              ))
            : matchessController.matchessModel!.myFriends!.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: Text("No Matches Found"),
                    ))
                : RefreshIndicator(
                    onRefresh: () async {
                      await matchessController.matches();
                    },
                    child: GridView.builder(
                      itemCount: matchessController.matchessModel!.myFriends!.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 85 / 100),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => MatchDetails(
                                id: matchessController.matchessModel!.myFriends![index].friendId.toString(),
                                isfriend: true,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // child:ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Container(
                            //     width: 262.ah,
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       image :   DecorationImage(
                            //         image: NetworkImage(matchessController.matchessModel!.myFriends![index].profileImage.toString()),
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //     child: Container(
                            //       decoration: const BoxDecoration(
                            //           gradient: LinearGradient(
                            //               colors: [Colors.transparent,Colors.black],
                            //               begin: Alignment.topCenter,
                            //               end: Alignment.bottomCenter,
                            //               stops: [0.7,1]
                            //           )
                            //       ),
                            //       padding: EdgeInsets.all(10),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             mainAxisAlignment: MainAxisAlignment.end,
                            //             children: [
                            //               InkWell(
                            //                 onTap: () {
                            //                   _showBottomSheet(
                            //                       context,
                            //                       matchessController
                            //                           .matchessModel!.myFriends![index].friendId
                            //                           .toString());
                            //                 },
                            //                 child: Container(
                            //                   width: 80,
                            //                   decoration: BoxDecoration(
                            //                       color: Colors.white.withOpacity(.60),
                            //                       borderRadius: BorderRadius.circular(4)),
                            //                   child: Center(
                            //                       child: customTextCommon(
                            //                         text: "Invite",
                            //                         fSize: 14,
                            //                         fWeight: FontWeight.w600,
                            //                         lineHeight: 24,
                            //                       )),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           Spacer(),
                            //           Padding(
                            //             padding: const EdgeInsets.only(bottom: 10.0),
                            //             child: Text(
                            //               '${matchessController.matchessModel!.myFriends![index].friendFirstName} ${matchessController.matchessModel!.myFriends![index].friendFirstName},',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 15.adaptSize,
                            //                 fontFamily: 'Inter',
                            //                 fontWeight: FontWeight.w600,
                            //                 height: 0.06,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: SizedBox(
                                width: 240.ah,
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.black12,
                                      height: 360.ah,
                                      width: 240.ah,
                                      child: CachedNetworkImage(
                                        imageUrl: matchessController.matchessModel!.myFriends![index].profileImage.toString(),
                                        placeholder: (context, url) => const Center(
                                            child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ))),
                                        errorWidget: (context, url, error) => const Icon(Icons.person_2_outlined),
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.fill,
                                        height: 300,
                                      ),
                                    ),
                                    Container(
                                      width: 240.ah,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [Colors.transparent, Colors.black],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.7, 1])),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${matchessController.matchessModel!.myFriends![index].friendFirstName} ${matchessController.matchessModel!.myFriends![index].friendLastName}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.adaptSize,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // child: Card(
                          //   elevation: 0,
                          //   color: Colors.white.withOpacity(.20),
                          //   child: Stack(children: [
                          //     CachedNetworkImage(
                          //       imageUrl: matchessController
                          //           .userFriend[index].profileImage ??
                          //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM4sEG5g9GFcy4SUxbzWNzUTf1jMISTDZrTw&usqp=CAU",
                          //       imageBuilder: (context, imageProvider) => Container(
                          //         height: 200,
                          //         width: 200,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(8),
                          //             image: DecorationImage(
                          //               image: NetworkImage(
                          //                 matchessController
                          //                     .userFriend[index].profileImage ??
                          //                     "",
                          //               ),
                          //               fit: BoxFit.cover,
                          //             )),
                          //       ),
                          //       placeholder: (context, url) {
                          //         return Center(
                          //             child: Image.network(
                          //                 "https://res.cloudinary.com/practicaldev/image/fetch/s--94oo0BCW--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/9zqj8ab4s1a5joa9umsu.gif"));
                          //       },
                          //       errorWidget: (context, url, error) => Center(
                          //         child: Container(
                          //           width: double.infinity,
                          //           height: 200.0,
                          //           decoration: const BoxDecoration(
                          //             // shape: BoxShape.circle,
                          //             image: DecorationImage(
                          //               image: NetworkImage(
                          //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM4sEG5g9GFcy4SUxbzWNzUTf1jMISTDZrTw&usqp=CAU"),
                          //               fit: BoxFit.cover,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     Positioned(
                          //       top: 12,
                          //       right: 10,
                          //       child: InkWell(
                          //         onTap: () {
                          //           _showBottomSheet(
                          //               context,
                          //               matchessController
                          //                   .userFriend[index].friendId
                          //                   .toString());
                          //         },
                          //         child: Container(
                          //           padding: const EdgeInsets.only(
                          //               left: 10, right: 10, top: 5, bottom: 5),
                          //           decoration: BoxDecoration(
                          //               color: Colors.white.withOpacity(.60),
                          //               borderRadius: BorderRadius.circular(8)),
                          //           // height: 32,width: 105,
                          //           child: Center(
                          //               child: customTextCommon(
                          //                 text: "Invite",
                          //                 fSize: 14,
                          //                 fWeight: FontWeight.w600,
                          //                 lineHeight: 24,
                          //               )),
                          //         ),
                          //       ),
                          //     ),
                          //     Positioned(
                          //         bottom: 0,
                          //         child: Container(
                          //           decoration: const BoxDecoration(
                          //             // color: Colors.red.withOpacity(.60),
                          //               borderRadius: BorderRadius.only(
                          //                   bottomLeft: Radius.circular(15),
                          //                   bottomRight: Radius.circular(15))),
                          //           height: 54,
                          //           width: 160,
                          //         )),
                          //     Positioned(
                          //       bottom: 10,
                          //       left: 8,
                          //       child: Container(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, right: 10, top: 5, bottom: 5),
                          //         decoration: BoxDecoration(
                          //             color: Colors.white.withOpacity(.60),
                          //             borderRadius: BorderRadius.circular(8)),
                          //         child: customTextCommon(
                          //           text: matchessController
                          //               .userFriend[index].friendUsername ??
                          //               "",
                          //           fSize: 12,
                          //           fWeight: FontWeight.w600,
                          //           lineHeight: 24,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //   ]),
                          // ),
                        );
                      },
                    ),
                  )));
  }
}
