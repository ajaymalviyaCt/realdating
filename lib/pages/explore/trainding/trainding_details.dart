// // import 'dart:async';
// // import 'package:cached_network_image/cached_network_image.dart';
// //
// // import 'package:connectivity/connectivity.dart';
// // import 'package:dotted_border/dotted_border.dart';
// //
// // import 'package:dropdown_button2/dropdown_button2.dart';
// // import 'package:flutter/material.dart';
// //
// // import 'package:flutter/services.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// //
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/svg.dart';
// //
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';
// // import 'package:realdating/chat/api/apis.dart';
// // import 'package:realdating/chat/screens/home_screen.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:velocity_x/velocity_x.dart';
// //
// // import '../../../consts/app_colors.dart';
// // import '../../../consts/app_urls.dart';
// // import '../../../services/base_client01.dart';
// // import '../../../validation/validation.dart';
// // import '../../../widgets/custom_text_styles.dart';
// // import '../../../widgets/custom_textfield.dart';
// // import 'invite/invite_for_date_controller.dart';
// // import 'matches_controller.dart';
// //
// // class MatchDetails extends StatefulWidget {
// //   String id;
// //
// //   MatchDetails({super.key, required this.id});
// //
// //   @override
// //   State<MatchDetails> createState() => _MatchDetailsState();
// // }
// //
// // class _MatchDetailsState extends State<MatchDetails> {
// //   MatchessController matchessController = Get.put(MatchessController());
// //   ConnectivityResult _connectionStatus = ConnectivityResult.none;
// //   final Connectivity _connectivity = Connectivity();
// //   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
// //   var comment;
// //   var ratingcount;
// //   TextEditingController txt_comment = TextEditingController();
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //
// //   // final List<String> allItems = List<String>.generate(100, (index) => "Item $index");
// //   final int initialItemCount = 2;
// //   bool showAllItems = false;
// //   int visibleItemCount = 5;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     matchessController.get_user_by_id(widget.id);
// //   }
// //
// //   bool showAllItemsss = false;
// //
// //   @override
// //   void dispose() {
// //     _connectivitySubscription?.cancel();
// //
// //     super.dispose();
// //   }
// //
// //   Future<void> initConnectivity() async {
// //     late ConnectivityResult result;
// //     try {
// //       result = await _connectivity.checkConnectivity();
// //     } on PlatformException catch (e) {
// //       return;
// //     }
// //     if (!mounted) {
// //       return Future.value(null);
// //     }
// //     return _updateConnectionStatus(result);
// //   }
// //
// //   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
// //     setState(() {
// //       _connectionStatus = result;
// //     });
// //   }
// //
// //   void uploadFileToServerInfluencer() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //
// //     var user_id = prefs.getInt('user_id');
// //     //  print('user_id==============' + user_id!);
// //
// //     initConnectivity();
// //     _connectivitySubscription =
// //         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
// //     if (_connectionStatus != null) {
// //       // Internet Present Case
// //       // showLoaderDialog(context);
// //     } else {
// //       Fluttertoast.showToast(
// //           msg: "Please check your Internet connection!!!!",
// //           toastLength: Toast.LENGTH_SHORT,
// //           gravity: ToastGravity.BOTTOM,
// //           backgroundColor: Colors.black,
// //           textColor: Colors.white,
// //           fontSize: 16.0);
// //     }
// //
// //     final response = await BaseClient01().post(Appurls.review, {
// //       "review": txt_comment.text.toString(),
// //       "rating_star": ratingcount.toString() ?? 1,
// //       "user_id": widget.id.toString()
// //     });
// //     // isLoadig(false);
// //     bool status = response["success"];
// //     var msg = response["message"];
// //     if (status == true) {
// //       matchessController.get_user_by_id(widget.id);
// //
// //       // ratingcount.clear();
// //       txt_comment.clear();
// //       await matchessController.get_user_by_id(widget.id);
// //       Navigator.pop(context);
// //     }
// //   }
// //
// //   final _formKey = GlobalKey<FormState>();
// //   InvaiteForDatesController invaiteForDatesController =
// //   Get.put(InvaiteForDatesController());
// //   DateTime currentDate = DateTime.now();
// //   final List<String> genderItems = [
// //     'Sports Events',
// //     'Concerts',
// //     'Fine Dining',
// //     'Coffee',
// //   ];
// //
// //   var selectedValue = "Sports Events";
// //
// //   Future<void> _selectDate(BuildContext context) async {
// //     DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: currentDate.subtract(
// //         const Duration(),
// //       ),
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime(2040),
// //     );
// //
// //     if (picked != null && picked != DateTime.now()) {
// //       setState(() {
// //         invaiteForDatesController.selectDateC.text = "${picked.month.toString()}-${picked.day.toString()}-${picked.year.toString()}";
// //       });
// //     }
// //   }
// //
// //   TimeOfDay _selectedTime = TimeOfDay.now();
// //
// //   Future<void> _selectTime(BuildContext context) async {
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: _selectedTime,
// //     );
// //     if (picked != null && picked != _selectedTime) {
// //       setState(() {
// //         _selectedTime = picked;
// //         String militaryTimeString = "${picked.hour}:${picked.minute.toString()}"; // Your 24-hour format time string
// //         DateFormat militaryFormat = DateFormat('HH:mm');
// //         DateFormat twelveHourFormat = DateFormat('h:mm a');
// //         DateTime parsedTime = militaryFormat.parse(militaryTimeString);
// //         String convertedTime = twelveHourFormat.format(parsedTime);
// //         print("asdfgfdsdfgfds" +convertedTime);
// //         print("zccxccccccccccc${_selectedTime}");
// //         invaiteForDatesController.selectTimeC.text = "${convertedTime}";
// //       });
// //     }
// //   }
// //
// //   bool isloading = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // showAllItems ? allItems : allItems.sublist(0, initialItemCount);
// //     void _showBottomSheet(BuildContext context, String userID) {
// //       showModalBottomSheet(
// //           isScrollControlled: true,
// //           context: context,
// //           builder: (BuildContext bc) {
// //             return Form(
// //               key: _formKey,
// //               child: SafeArea(
// //                 child: Container(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: <Widget>[
// //                       10.h.heightBox,
// //                       SizedBox(
// //                         height: MediaQuery.of(context).size.height * .62,
// //                         child: ListView(
// //                           children: [
// //                             10.h.heightBox,
// //                             const Text(
// //                               'Invite For Date',
// //                               style: TextStyle(
// //                                 color: Colors.black,
// //                                 fontSize: 20,
// //                                 fontFamily: 'Inter',
// //                                 fontWeight: FontWeight.w600,
// //                                 height: 0.04,
// //                               ),
// //                             ).centered(),
// //                             47.h.heightBox,
// //                             const Text('Select Date',
// //                                 style: AppTextStyle.selectDateTextStyle),
// //                             5.h.heightBox,
// //                             TextFormField(
// //                               onTap: () {
// //                                 _selectDate(context);
// //                               },
// //                               controller: invaiteForDatesController.selectDateC,
// //                               validator: notEmptyValidator,
// //                               decoration: InputDecoration(
// //                                 contentPadding: const EdgeInsets.all(10),
// //                                 enabledBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 focusedBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 errorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.red,
// //                                     )),
// //                                 focusedErrorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black,
// //                                     )),
// //
// //                                 hintText: "MM-DD-YYYY",
// //
// //                                 hintStyle: TextStyle(
// //                                     color: Colors.black.withOpacity(.40),
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14),
// //                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
// //                                 suffixIcon: IconButton(
// //                                   icon: const Icon(
// //                                     Icons.calendar_month,
// //                                     color: Colors.red,
// //                                   ),
// //                                   onPressed: () => _selectDate(context),
// //                                 ),
// //                               ),
// //                             ),
// //                             10.h.heightBox,
// //                             const Text('Select Time',
// //                                 style: AppTextStyle.selectDateTextStyle),
// //                             5.h.heightBox,
// //                             TextFormField(
// //                               onTap: () {
// //                                 _selectTime(context);
// //                               },
// //                               controller: invaiteForDatesController.selectTimeC,
// //                               validator: notEmptyValidator,
// //                               decoration: InputDecoration(
// //                                 contentPadding: const EdgeInsets.all(10),
// //                                 enabledBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 focusedBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 errorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.red,
// //                                     )),
// //                                 focusedErrorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black,
// //                                     )),
// //
// //                                 hintText: "hh-mm",
// //
// //                                 hintStyle: TextStyle(
// //                                     color: Colors.black.withOpacity(.40),
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14),
// //                                 labelStyle: TextStyle(
// //                                     color: Colors.black.withOpacity(.40),
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14),
// //                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
// //                                 suffixIcon: IconButton(
// //                                   icon: const Icon(
// //                                     Icons.access_time_outlined,
// //                                     color: Colors.red,
// //                                   ),
// //                                   onPressed: () => _selectTime(context),
// //                                 ),
// //                               ),
// //                             ),
// //                             10.h.heightBox,
// //                             const Text('Select Activity',
// //                                 style: AppTextStyle.selectDateTextStyle),
// //                             5.h.heightBox,
// //
// //                             ///  dropdown start /////////////////////////////////////
// //
// //                             DropdownButtonFormField2<String>(
// //                               decoration: InputDecoration(
// //                                 contentPadding: const EdgeInsets.all(10),
// //                                 enabledBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 focusedBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black12,
// //                                     )),
// //                                 errorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.red,
// //                                     )),
// //                                 focusedErrorBorder: OutlineInputBorder(
// //                                     borderRadius: BorderRadius.circular(10),
// //                                     borderSide: const BorderSide(
// //                                       width: 1,
// //                                       color: Colors.black,
// //                                     )),
// //                                 hintText: "Select Activity",
// //
// //                                 hintStyle: TextStyle(
// //                                     color: Colors.black.withOpacity(.40),
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14),
// //                                 labelStyle: TextStyle(
// //                                     color: Colors.black.withOpacity(.40),
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14),
// //                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
// //                               ),
// //                               items: genderItems
// //                                   .map((item) => DropdownMenuItem<String>(
// //                                 value: item,
// //                                 child: Text(
// //                                   item,
// //                                   style: const TextStyle(
// //                                     fontSize: 14,
// //                                   ),
// //                                 ),
// //                               ))
// //                                   .toList(),
// //                               validator: (value) {
// //                                 if (value == null) {
// //                                   return 'Please select gender.';
// //                                 }
// //                                 return null;
// //                               },
// //                               onChanged: (value) {
// //                                 print("asdfgzsxdfghjhg");
// //                                 selectedValue = value.toString();
// //                                 print("$selectedValue + :::::::::::::::::::");
// //                               },
// //                               buttonStyleData: const ButtonStyleData(
// //                                 padding: EdgeInsets.only(right: 8),
// //                               ),
// //                               iconStyleData: const IconStyleData(
// //                                 icon: Icon(
// //                                   Icons.arrow_downward_rounded,
// //                                   size: 22,
// //                                   color: Colors.red,
// //                                 ),
// //                               ),
// //                               dropdownStyleData: DropdownStyleData(
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(15),
// //                                 ),
// //                               ),
// //                               menuItemStyleData: const MenuItemStyleData(
// //                                 padding: EdgeInsets.symmetric(horizontal: 16),
// //                               ),
// //                             ),
// //                             10.h.heightBox,
// //
// //                             ///  dropdwon end /////////////////////////////////////
// //                             const Text('Location',
// //                                 style: AppTextStyle.selectDateTextStyle),
// //                             5.h.heightBox,
// //                             primaryTextfield(
// //                                 validator: notEmptyValidator,
// //                                 hintText: 'Location',
// //                                 controller:
// //                                 invaiteForDatesController.locationC),
// //                             15.h.heightBox,
// //                             Obx(
// //                                   () => invaiteForDatesController.isLoading.value
// //                                   ? Container(
// //                                 width: 350,
// //                                 height: 56,
// //                                 decoration: ShapeDecoration(
// //                                   gradient: const LinearGradient(
// //                                     begin: Alignment(0.00, -1.00),
// //                                     end: Alignment(0, 1),
// //                                     colors: [
// //                                       Color(0xFFF65F51),
// //                                       Color(0xFFFB4967)
// //                                     ],
// //                                   ),
// //                                   shape: RoundedRectangleBorder(
// //                                     side: const BorderSide(
// //                                         width: 1, color: Colors.white),
// //                                     borderRadius:
// //                                     BorderRadius.circular(30),
// //                                   ),
// //                                 ),
// //                                 child: const CircularProgressIndicator(
// //                                   color: Colors.white,
// //                                 ).centered(),
// //                               )
// //                                   : Container(
// //                                 width: 350,
// //                                 height: 56,
// //                                 decoration: ShapeDecoration(
// //                                   gradient: const LinearGradient(
// //                                     begin: Alignment(0.00, -1.00),
// //                                     end: Alignment(0, 1),
// //                                     colors: [
// //                                       Color(0xFFF65F51),
// //                                       Color(0xFFFB4967)
// //                                     ],
// //                                   ),
// //                                   shape: RoundedRectangleBorder(
// //                                     side: const BorderSide(
// //                                         width: 1, color: Colors.white),
// //                                     borderRadius:
// //                                     BorderRadius.circular(30),
// //                                   ),
// //                                 ),
// //                                 child: const Text(
// //                                   'Invite',
// //                                   textAlign: TextAlign.center,
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontSize: 17,
// //                                     fontFamily: 'Inter',
// //                                     fontWeight: FontWeight.w600,
// //                                     height: 0,
// //                                   ),
// //                                 ).centered(),
// //                               ).onTap(() {
// //                                 if (_formKey.currentState!.validate()) {
// //                                   print("validate");
// //
// //                                   invaiteForDatesController.invateForDate(
// //                                     userID,
// //                                     invaiteForDatesController
// //                                         .selectDateC.text,
// //                                     invaiteForDatesController
// //                                         .selectTimeC.text,
// //                                     "$selectedValue",
// //                                     invaiteForDatesController
// //                                         .locationC.text,
// //                                   );
// //                                 } else {
// //                                   print("Not validatef");
// //                                   // AppDialog.taostMessage("")
// //                                 }
// //                               }),
// //                             ),
// //                             Padding(
// //                                 padding: EdgeInsets.only(
// //                                     bottom: MediaQuery.of(context)
// //                                         .viewInsets
// //                                         .bottom)),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           });
// //     }
// //
// //     return Scaffold(
// //       body: Form(
// //         key: formKey,
// //         child: Obx(
// //               () => matchessController.isLoadingget_user_by_id.value
// //               ? const Center(child: CircularProgressIndicator())
// //               : ListView(
// //             children: [
// //               Stack(
// //                 children: [
// //                   matchessController.exploreDetailsModel?.userInfo[0]
// //                       .profileImage ==
// //                       null
// //                       ? Container(
// //                     width: MediaQuery.of(context).size.width,
// //                     height: 415,
// //                     decoration: const BoxDecoration(
// //                       image: DecorationImage(
// //                         image: NetworkImage(
// //                             "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg"),
// //                         fit: BoxFit.fill,
// //                       ),
// //                     ),
// //                   )
// //                       : Container(
// //                     width: MediaQuery.of(context).size.width,
// //                     height: 415,
// //                     decoration: BoxDecoration(
// //                       image: DecorationImage(
// //                         image: NetworkImage(matchessController
// //                             .exploreDetailsModel
// //                             ?.userInfo[0]
// //                             .profileImage ??
// //                             "https://forreal.net:4000/profile/15471d74-dbc5-4c13-9202-78b7a24c76be.png"),
// //                         fit: BoxFit.fill,
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     decoration: const BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.only(
// //                           topRight: Radius.circular(30),
// //                           topLeft: Radius.circular(30),
// //                         )),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         40.heightBox,
// //                         Row(
// //                           children: [
// //                             Text(
// //                               '${matchessController.exploreDetailsModel?.userInfo[0].firstName}, ${matchessController.exploreDetailsModel?.userInfo[0].age}',
// //                               style: TextStyle(
// //                                 color: Colors.black,
// //                                 fontSize: 20.sp,
// //                                 fontFamily: 'Inter',
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                             ),
// //                             const Spacer(),
// //                             InkWell(
// //                                 onTap: () {
// //                                   APIs.addChatUser(matchessController
// //                                       .exploreDetailsModel!.userInfo[0].id
// //                                       .toString());
// //                                   Get.to(() => const HomeScreen());
// //                                 },
// //                                 child: SvgPicture.asset(
// //                                     "assets/icons/Group 424.svg"))
// //                           ],
// //                         ),
// //                         const SizedBox(
// //                           height: 10,
// //                         ),
// //                         Row(
// //                           mainAxisAlignment:
// //                           MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Column(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               mainAxisSize: MainAxisSize.min,
// //                               crossAxisAlignment:
// //                               CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   'Location',
// //                                   style: TextStyle(
// //                                     color: Colors.black,
// //                                     fontSize: 14.sp,
// //                                     fontFamily: 'Inter',
// //                                     fontWeight: FontWeight.w400,
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   matchessController.exploreDetailsModel
// //                                       ?.userInfo[0].address ??
// //                                       'Chicago, IL United States',
// //                                   style: TextStyle(
// //                                     color: Colors.black
// //                                         .withOpacity(0.699999988079071),
// //                                     fontSize: 12.sp,
// //                                     fontFamily: 'Inter',
// //                                     fontWeight: FontWeight.w400,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             /*     Container(
// //                                 child: Text(
// //                                   '1 km',
// //                                   style: TextStyle(
// //                                     color: Color(0xFFFB4967),
// //                                     fontSize: 12,
// //                                     fontFamily: 'Inter',
// //                                     fontWeight: FontWeight.w400,
// //                                   ),
// //                                 ).centered(),
// //                                 width: 72.58,
// //                                 height: 34,
// //                                 decoration: ShapeDecoration(
// //                                   color: Color(0x1AE94057),
// //                                   shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(7)),
// //                                 ),
// //                               )*/
// //                           ],
// //                         ),
// //                         const SizedBox(
// //                           height: 10,
// //                         ),
// //                         const Text(
// //                           'About',
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 14,
// //                             fontFamily: 'Inter',
// //                             fontWeight: FontWeight.w400,
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 295,
// //                           child: Text(
// //                             "Description",
// //                             style: TextStyle(
// //                               color: Colors.black
// //                                   .withOpacity(0.699999988079071),
// //                               fontSize: 14,
// //                               fontFamily: 'Inter',
// //                               fontWeight: FontWeight.w400,
// //                             ),
// //                           ),
// //                         ),
// //                         21.heightBox,
// //                         /*Row(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             children: [
// //                               const Text(
// //                                 'Ratings',
// //                                 style: TextStyle(
// //                                   color: Colors.black,
// //                                   fontSize: 14,
// //                                   fontFamily: 'Inter',
// //                                   fontWeight: FontWeight.w400,
// //                                 ),
// //                               ),
// //                               10.widthBox,
// //                               Text(
// //                                 data?.totalReviewStar != null
// //                                     ? data!.totalReviewStar.toString()
// //                                     : "",
// //                                 style: const TextStyle(
// //                                   color: Colors.black,
// //                                   fontSize: 14,
// //                                   fontFamily: 'Inter',
// //                                   fontWeight: FontWeight.w700,
// //                                 ),
// //                               ),
// //                               10.widthBox,
// //                               Text(
// //                                 data!.allReviews.length.toString(),
// //                                 style: const TextStyle(
// //                                   color: Colors.black,
// //                                   fontSize: 14,
// //                                   fontFamily: 'Inter',
// //                                   fontWeight: FontWeight.w400,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           10.heightBox,*/
// //                         Row(
// //                           children: [
// //                             const Text(
// //                               '* * * * *  ',
// //                               style: TextStyle(
// //                                 color: Colors.black,
// //                                 fontSize: 14,
// //                                 fontFamily: 'Inter',
// //                                 fontWeight: FontWeight.w400,
// //                               ),
// //                             ),
// //                             const Spacer(),
// //                             InkWell(
// //                               onTap: () {
// //                                 showDialog(
// //                                     context: context,
// //                                     builder: (BuildContext context) {
// //                                       return Dialog(
// //                                         backgroundColor: Colors.white,
// //                                         shape: RoundedRectangleBorder(
// //                                             borderRadius:
// //                                             BorderRadius.circular(
// //                                                 20.0)), //this right here
// //                                         child: Container(
// //                                           height: 210,
// //                                           child: Padding(
// //                                             padding: const EdgeInsets.all(
// //                                                 12.0),
// //                                             child: Column(
// //                                               mainAxisAlignment:
// //                                               MainAxisAlignment
// //                                                   .center,
// //                                               // crossAxisAlignment: CrossAxisAlignment.start,
// //                                               children: [
// //                                                 const Text(
// //                                                   'Review',
// //                                                   textAlign:
// //                                                   TextAlign.center,
// //                                                   style: TextStyle(
// //                                                     color: Colors.black,
// //                                                     fontSize: 20.98,
// //                                                     fontFamily: 'Roboto',
// //                                                     fontWeight:
// //                                                     FontWeight.w700,
// //                                                     height: 0,
// //                                                   ),
// //                                                 ),
// //                                                 const SizedBox(
// //                                                   height: 10,
// //                                                 ),
// //                                                 RatingBar.builder(
// //                                                   itemSize: 30,
// //                                                   initialRating: 0,
// //                                                   minRating: 1,
// //                                                   direction:
// //                                                   Axis.horizontal,
// //                                                   allowHalfRating: false,
// //                                                   itemCount: 5,
// //                                                   itemPadding:
// //                                                   const EdgeInsets
// //                                                       .symmetric(
// //                                                       horizontal:
// //                                                       3.0),
// //                                                   itemBuilder:
// //                                                       (context, _) =>
// //                                                   const Icon(
// //                                                     Icons.star,
// //                                                     color: Colors.amber,
// //                                                   ),
// //                                                   onRatingUpdate:
// //                                                       (rating) {
// //                                                     setState(() {
// //                                                       ratingcount =
// //                                                           rating;
// //                                                     });
// //                                                   },
// //                                                 ),
// //                                                 const SizedBox(
// //                                                   height: 10,
// //                                                 ),
// //                                                 TextField(
// //                                                   controller: txt_comment,
// //                                                   decoration:
// //                                                   const InputDecoration(
// //                                                       hintText:
// //                                                       'Add Commment'),
// //                                                 ),
// //                                                 const SizedBox(
// //                                                   height: 10,
// //                                                 ),
// //                                                 Container(
// //                                                   height: 50,
// //                                                   // width: 200,
// //                                                   child: Align(
// //                                                       alignment: Alignment
// //                                                           .bottomRight,
// //                                                       child: Row(
// //                                                         children: [
// //                                                           TextButton(
// //                                                               onPressed:
// //                                                                   () {
// //                                                                 Navigator.pop(
// //                                                                     context); //close Dialog
// //                                                               },
// //                                                               child: const Text(
// //                                                                   "Cancel",
// //                                                                   style: TextStyle(
// //                                                                       color:
// //                                                                       Colors.black))),
// //                                                           TextButton(
// //                                                               onPressed:
// //                                                                   () {
// //                                                                 if (formKey
// //                                                                     .currentState!
// //                                                                     .validate()) {
// //                                                                   uploadFileToServerInfluencer();
// //                                                                 }
// //                                                                 // uploadFileToServerInfluencer();
// //                                                               },
// //                                                               child: const Text(
// //                                                                   "Save",
// //                                                                   style: TextStyle(
// //                                                                       color:
// //                                                                       Colors.black)))
// //                                                         ],
// //                                                       )),
// //                                                 )
// //                                               ],
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       );
// //                                     });
// //                               },
// //                               child: Opacity(
// //                                 opacity: 0.70,
// //                                 child: Text(
// //                                   'Add Review',
// //                                   style: TextStyle(
// //                                     color: Colors.black.withOpacity(.70),
// //                                     fontSize: 14,
// //                                     fontFamily: 'Inter',
// //                                     fontWeight: FontWeight.w600,
// //                                   ),
// //                                 ),
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                         10.heightBox,
// //                         /*   const Text(
// //                             'Review ',
// //                             style: TextStyle(
// //                               color: Colors.black,
// //                               fontSize: 14,
// //                               fontFamily: 'Inter',
// //                               fontWeight: FontWeight.w400,
// //                             ),
// //                           ),
// //                           10.heightBox,
// //
// //                           matchessController.exploreDetailsModel!.userInfo[0].allReviews.isEmpty
// //                               ? Container(
// //                                   margin:
// //                                       const EdgeInsets.only(top: 20, bottom: 20),
// //                                   child: const Center(
// //                                       child: Text(
// //                                     "No Review Found !!",
// //                                     style: TextStyle(
// //                                         fontSize: 16,
// //                                         fontWeight: FontWeight.w500,
// //                                         color: Colors.grey),
// //                                   )),
// //                                 )
// //                               : const SizedBox(),*/
// //                         for (int i = 0;
// //                         i < matchessController.displayedItemss.length;
// //                         i++)
// //                           matchessController.displayedItemss == null &&
// //                               matchessController.exploreDetailsModel
// //                                   ?.userInfo[0].allReviews ==
// //                                   null &&
// //                               matchessController.exploreDetailsModel!
// //                                   .userInfo[0].allReviews.isEmpty
// //                               ? const SizedBox()
// //                               : Container(
// //                               decoration: BoxDecoration(
// //                                   color:
// //                                   Colors.black12.withOpacity(.02),
// //                                   borderRadius:
// //                                   BorderRadius.circular(10)),
// //                               child: ListTile(
// //                                   leading: Container(
// //                                     height: 50,width: 50,
// //                                     child: CachedNetworkImage(
// //                                         imageUrl: matchessController
// //                                             .exploreDetailsModel
// //                                             ?.userInfo[0]
// //                                             .allReviews[i]
// //                                             .reviewerProfileImage ??
// //                                             "",
// //                                         imageBuilder: (context,
// //                                             imageProvider) =>
// //                                             CircleAvatar(
// //                                               radius: 25,
// //                                               backgroundImage: NetworkImage(
// //                                                   matchessController
// //                                                       .exploreDetailsModel
// //                                                       ?.userInfo[0]
// //                                                       .allReviews[i]
// //                                                       .reviewerProfileImage ??
// //                                                       ""),
// //                                             ),
// //                                         placeholder: (context, url) {
// //                                           return Center(
// //                                               child: Image.network(
// //                                                 "https://raw.githubusercontent.com/prafful98/vue3-shimmer/HEAD/assets/card.gif",
// //                                                 fit: BoxFit.fill,
// //                                                 alignment: Alignment.center,
// //                                                 height: 120,
// //                                                 width: double.infinity,
// //                                               ));
// //                                         },
// //                                         errorWidget: (context, url, error) =>
// //                                         const CircleAvatar(
// //                                           radius: 25,
// //                                           backgroundImage: AssetImage("assets/images/noImage.png"),
// //                                         )),
// //                                   ),
// //                                   title: Text(matchessController
// //                                       .exploreDetailsModel
// //                                       ?.userInfo[0]
// //                                       .allReviews[i]
// //                                       .review ??
// //                                       "Nice boy"),
// //                                   subtitle: Row(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     children: List.generate(
// //                                         matchessController
// //                                             .exploreDetailsModel!
// //                                             .userInfo[0]
// //                                             .allReviews[i]
// //                                             .ratingStar, (index) {
// //                                       int filledStars =
// //                                       matchessController
// //                                           .exploreDetailsModel!
// //                                           .userInfo[0]
// //                                           .allReviews[i]
// //                                           .ratingStar
// //                                           .floor();
// //                                       if (index < filledStars) {
// //                                         // Display a filled star
// //                                         return const Icon(
// //                                           Icons.star,
// //                                           color: Colors.amberAccent,
// //                                         );
// //                                       } else {
// //                                         // Display an outline star
// //                                         return const Icon(
// //                                           Icons.star_border,
// //                                           color: Colors.grey,
// //                                         );
// //                                       }
// //                                     }),
// //
// //                                     /*         Row(
// //                                       children: [
// //                                         Icon(Icons.star,
// //                                             size: 17,
// //                                             color:
// //                                                 data?.allReviews[i].ratingStar == 1
// //                                                     ? Colors.amber
// //                                                     : Colors.grey),
// //                                         Icon(Icons.star,
// //                                             size: 17,
// //                                             color:
// //                                                 data?.allReviews[i].ratingStar == 2
// //                                                     ? Colors.amber
// //                                                     : Colors.grey),
// //                                         Icon(Icons.star,
// //                                             size: 17,
// //                                             color:
// //                                                 data?.allReviews[i].ratingStar == 3
// //                                                     ? Colors.amber
// //                                                     : Colors.grey),
// //                                         Icon(Icons.star,
// //                                             size: 17,
// //                                             color:
// //                                                 data?.allReviews[i].ratingStar == 4
// //                                                     ? Colors.amber
// //                                                     : Colors.grey),
// //                                         Icon(Icons.star,
// //                                             size: 17,
// //                                             color:
// //                                                 data?.allReviews[i].ratingStar == 5
// //                                                     ? Colors.amber
// //                                                     : Colors.grey),
// //                                       ],
// //                                     )*/
// //                                   ))).paddingOnly(bottom: 10),
// //                         10.heightBox,
// //                         ElevatedButton(
// //                           onPressed: () {
// //                             // Toggle between showing limited and all items
// //                             setState(() {
// //                               showAllItemsss = !showAllItemsss;
// //                               matchessController.displayedItemss =
// //                               showAllItemsss
// //                                   ? List.from(matchessController
// //                                   .exploreDetailsModel!
// //                                   .userInfo[0]
// //                                   .allReviews)
// //                                   : matchessController
// //                                   .exploreDetailsModel!
// //                                   .userInfo[0]
// //                                   .allReviews
// //                                   .take(1)
// //                                   .toList();
// //                             });
// //                           },
// //                           child: Text(
// //                               showAllItemsss ? 'Show Less' : 'See More'),
// //                         ),
// //
// //                         /* if (!showAllItems)
// //                             TextButton(
// //                               onPressed: () {
// //                                 showAllItems = true;
// //                                 setState(() {
// //                                   // Show all items when the button is clicked
// //                                   visibleItemCount = data.allReviews.length;
// //                                 });
// //                               },
// //                               child: const Text('See More'),
// //                             ),*/
// //                         /* Text(
// //                             'Show all',
// //                             style: TextStyle(
// //                               color: Color(0xFFE94057),
// //                               fontSize: 12,
// //                               fontFamily: 'Inter',
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ).centered(),*/
// //                         20.heightBox,
// //                         const Text(
// //                           'Interests',
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 14,
// //                             fontFamily: 'Inter',
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         10.heightBox,
// //                         matchessController.exploreDetailsModel
// //                             ?.userInfo[0].insertdata ==
// //                             null
// //                             ? const Text("No Intrest Found !!")
// //                             : SizedBox(
// //                           height: 100,
// //                           child: GridView.builder(
// //                             itemCount: matchessController
// //                                 .exploreDetailsModel
// //                                 ?.userInfo[0]
// //                                 .insertdata
// //                                 .length !=
// //                                 0
// //                                 ? matchessController
// //                                 .exploreDetailsModel
// //                                 ?.userInfo[0]
// //                                 .insertdata
// //                                 .length
// //                                 : 0,
// //                             itemBuilder: (ctx, i) {
// //                               return Container(
// //                                 height: 50,
// //                                 child: DottedBorder(
// //                                   strokeWidth: 1,
// //                                   color: const Color(0xFFE94057),
// //                                   borderType: BorderType.RRect,
// //                                   radius: const Radius.circular(12),
// //                                   child: ClipRRect(
// //                                     borderRadius:
// //                                     const BorderRadius.all(
// //                                       Radius.circular(5),
// //                                     ),
// //                                     child: Center(
// //                                       child: Container(
// //                                         width: 92,
// //                                         height: 32,
// //                                         child: Text(
// //                                           matchessController
// //                                               .exploreDetailsModel
// //                                               ?.userInfo[0]
// //                                               .insertdata[i] ??
// //                                               "",
// //                                           style: const TextStyle(
// //                                             color:
// //                                             Color(0xFFE94057),
// //                                             fontSize: 12,
// //                                             fontFamily: 'Inter',
// //                                             fontWeight:
// //                                             FontWeight.w400,
// //                                             height: 0.11,
// //                                           ),
// //                                         ).centered(),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                             gridDelegate:
// //                             const SliverGridDelegateWithFixedCrossAxisCount(
// //                                 crossAxisCount: 3,
// //                                 mainAxisExtent: 30,
// //                                 crossAxisSpacing: 10),
// //                           ),
// //                         ),
// //
// //                         /*      Row(
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             children: [
// //                               DottedBorder(
// //                                 strokeWidth: 1,
// //                                 color: Color(0xFFE94057),
// //                                 borderType: BorderType.RRect,
// //                                 radius: Radius.circular(12),
// //                                 child: ClipRRect(
// //                                   borderRadius: BorderRadius.all(
// //                                     Radius.circular(5),
// //                                   ),
// //                                   child: Container(
// //                                     width: 92,
// //                                     height: 32,
// //                                     child: Text(
// //                                       'Travelling',
// //                                       style: TextStyle(
// //                                         color: Color(0xFFE94057),
// //                                         fontSize: 12,
// //                                         fontFamily: 'Inter',
// //                                         fontWeight: FontWeight.w400,
// //                                         height: 0.11,
// //                                       ),
// //                                     ).centered(),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Spacer(),
// //                               DottedBorder(
// //                                 strokeWidth: 1,
// //                                 color: Color(0xFFE94057),
// //                                 borderType: BorderType.RRect,
// //                                 radius: Radius.circular(12),
// //                                 child: ClipRRect(
// //                                   borderRadius: BorderRadius.all(
// //                                     Radius.circular(5),
// //                                   ),
// //                                   child: Container(
// //                                     width: 92,
// //                                     height: 32,
// //                                     child: Text(
// //                                       'Books',
// //                                       style: TextStyle(
// //                                         color: Color(0xFFE94057),
// //                                         fontSize: 12,
// //                                         fontFamily: 'Inter',
// //                                         fontWeight: FontWeight.w400,
// //                                         height: 0.11,
// //                                       ),
// //                                     ).centered(),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Spacer(),
// //                               DottedBorder(
// //                                 strokeWidth: 1,
// //                                 color: Color(0xFFE94057),
// //                                 borderType: BorderType.RRect,
// //                                 radius: Radius.circular(12),
// //                                 child: ClipRRect(
// //                                   borderRadius: BorderRadius.all(
// //                                     Radius.circular(5),
// //                                   ),
// //                                   child: Container(
// //                                     width: 92,
// //                                     height: 32,
// //                                     child: Text(
// //                                       'Music',
// //                                       style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontFamily: 'Inter',
// //                                         fontWeight: FontWeight.w400,
// //                                         height: 0.11,
// //                                       ),
// //                                     ).centered(),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),*/
// //                         10.heightBox,
// //                         20.heightBox,
// //                         const Text(
// //                           'Gallery',
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 14,
// //                             fontFamily: 'Inter',
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         20.heightBox,
// //                         matchessController.exploreDetailsModel
// //                             ?.userInfo[0].images.length !=
// //                             0 &&
// //                             matchessController.exploreDetailsModel
// //                                 ?.userInfo[0].images !=
// //                                 null
// //                             ? Container(
// //                           height: 300,
// //                           child: GridView.builder(
// //                               physics:
// //                               const NeverScrollableScrollPhysics(),
// //                               itemCount: matchessController
// //                                   .exploreDetailsModel
// //                                   ?.userInfo[0]
// //                                   .images
// //                                   .length,
// //                               gridDelegate:
// //                               const SliverGridDelegateWithFixedCrossAxisCount(
// //                                   crossAxisCount: 3,
// //                                   mainAxisSpacing: 10,
// //                                   crossAxisSpacing: 5),
// //                               itemBuilder: (ctx, index) {
// //                                 final data = matchessController
// //                                     .exploreDetailsModel!
// //                                     .userInfo[0]
// //                                     .images[index];
// //
// //                                 return CachedNetworkImage(
// //                                   imageUrl: data.profileImages,
// //                                   imageBuilder:
// //                                       (context, imageProvider) =>
// //                                       Container(
// //                                         decoration: BoxDecoration(
// //                                           image: DecorationImage(
// //                                               image: imageProvider,
// //                                               fit: BoxFit.cover,
// //                                               colorFilter:
// //                                               const ColorFilter
// //                                                   .mode(
// //                                                   Colors.white,
// //                                                   BlendMode
// //                                                       .colorBurn)),
// //                                         ),
// //                                       ),
// //                                   placeholder: (context, url) =>
// //                                   const Center(
// //                                       child:
// //                                       CircularProgressIndicator()),
// //                                   errorWidget:
// //                                       (context, url, error) =>
// //                                   const Icon(Icons.person_2_outlined),
// //                                 );
// //
// //                                 /*   Container(
// //                                       height: 106,
// //                                       // width: 106,
// //                                       decoration: BoxDecoration(
// //                                           borderRadius: BorderRadius.circular(15),
// //                                           image: DecorationImage(
// //                                               image: NetworkImage(
// //                                                   data?.profileImages ?? ""),
// //                                               fit: BoxFit.cover)),
// //                                     );*/
// //                               }),
// //                         )
// //                             : const Text("No Images Found !!"),
// //
// //                         /*      GridView.builder(
// //                               itemCount: data.images.length,
// //                               shrinkWrap: true,
// //                               physics: const NeverScrollableScrollPhysics(),
// //                               gridDelegate:
// //                                   const SliverGridDelegateWithFixedCrossAxisCount(
// //                                       childAspectRatio: .7, crossAxisCount: 3),
// //                               itemBuilder: (ctx, index) {
// //                                 return CachedNetworkImage(
// //                                   imageUrl: matchessController.matchessModel
// //                                           ?.myFriends[index].profileImage ??
// //                                       "http://via.placeholder.com/200x150",
// //                                   imageBuilder: (context, imageProvider) =>
// //                                       Container(
// //                                     decoration: ShapeDecoration(
// //                                       image: DecorationImage(
// //                                         image: NetworkImage(
// //                                           data.images[index].profileImages ??
// //                                               "https://via.placeholder.com/168x190",
// //                                         ),
// //                                         fit: BoxFit.fill,
// //                                       ),
// //                                       shape: RoundedRectangleBorder(
// //                                           borderRadius: BorderRadius.circular(5)),
// //                                     ),
// //                                   ).paddingAll(10),
// //                                   placeholder: (context, url) {
// //                                     return const Center(
// //                                         child: CircularProgressIndicator());
// //                                   },
// //                                   errorWidget: (context, url, error) =>
// //                                       const Center(
// //                                           child: CircularProgressIndicator()),
// //                                 );
// //
// //                                 */
// //
// //                         /*      Container(
// //                                   decoration: ShapeDecoration(
// //                                     image: DecorationImage(
// //                                       image: NetworkImage(
// //                                          data.images[index].profileImages?? "https://via.placeholder.com/168x190"),
// //                                       fit: BoxFit.fill,
// //                                     ),
// //                                     shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(5)),
// //                                   ),
// //                                 )*/ /*
// //                               }),*/
// //
// //                         30.heightBox,
// //                         InkWell(
// //                           onTap: () {
// //                             _showBottomSheet(
// //                                 context,
// //                                 matchessController
// //                                     .exploreDetailsModel!.userInfo[0].id
// //                                     .toString());
// //                           },
// //                           child: Container(
// //                             width: MediaQuery.of(context).size.width,
// //                             height: 56,
// //                             decoration: ShapeDecoration(
// //                               gradient: const LinearGradient(
// //                                 begin: Alignment(0.00, -1.00),
// //                                 end: Alignment(0, 1),
// //                                 colors: [
// //                                   Color(0xFFF65F51),
// //                                   Color(0xFFFB4967)
// //                                 ],
// //                               ),
// //                               shape: RoundedRectangleBorder(
// //                                 side: const BorderSide(
// //                                     width: 1, color: Colors.white),
// //                                 borderRadius: BorderRadius.circular(30),
// //                               ),
// //                             ),
// //                             child: const Text(
// //                               'Request Date',
// //                               textAlign: TextAlign.center,
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 15,
// //                                 fontFamily: 'Inter',
// //                                 fontWeight: FontWeight.w600,
// //                                 height: 0,
// //                               ),
// //                             ).centered(),
// //                           ),
// //                         ),
// //                         30.heightBox,
// //                       ],
// //                     ).paddingOnly(left: 20, right: 20),
// //                   ).paddingOnly(top: 385),
// //                   InkWell(
// //                     onTap: () {
// //                       Get.back();
// //                     },
// //                     child: Container(
// //                       width: 50,
// //                       height: 50,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(15.0),
// //                         border: Border.all(
// //                           color: const Color(0xFFE8E6EA),
// //                           // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
// //                           width: 1.0, // Border width
// //                         ),
// //                         color: const Color(
// //                             0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
// //                       ),
// //                       child: const Icon(Icons.arrow_back_ios_outlined,
// //                           color: colors.primary, size: 18),
// //                     ).paddingOnly(left: 20, top: 20),
// //                   )
// //                 ],
// //               ),
// //               15.heightBox,
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   double getRatingForItem(int index) {
// //     // Replace this logic with your actual rating retrieval logic
// //     // For example, return a different rating based on the item index
// //     return (index + 1).toDouble();
// //   }
// // }
//
//
// import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:dotted_border/dotted_border.dart';
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/services.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:get/get.dart';
// import 'package:realdating/chat/api/apis.dart';
// import 'package:realdating/chat/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import '../../../consts/app_colors.dart';
// import '../../../consts/app_urls.dart';
// import '../../../services/base_client01.dart';
// import '../../../validation/validation.dart';
// import '../../../widgets/custom_text_styles.dart';
// import '../../../widgets/custom_textfield.dart';
// import '../../swipcard/swip_controller.dart';
// import '../matches/invite/invite_for_date_controller.dart';
// import '../matches/matches_controller.dart';
//
//
// class TraindingDetailScreeen extends StatefulWidget {
//   String id;
//
//   TraindingDetailScreeen({super.key, required this.id});
//
//   @override
//   State<TraindingDetailScreeen> createState() => _TraindingDetailScreeenState();
// }
//
// class _TraindingDetailScreeenState extends State<TraindingDetailScreeen> {
//
//
//   SwipController swipController=Get.put(SwipController());
//   MatchessController matchessController = Get.put(MatchessController());
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
//   var comment;
//   var ratingcount;
//   TextEditingController txt_comment = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   // final List<String> allItems = List<String>.generate(100, (index) => "Item $index");
//   final int initialItemCount = 2;
//   bool showAllItems = false;
//   int visibleItemCount = 5;
//
//   @override
//   void initState() {
//     super.initState();
//     matchessController.get_user_by_id(widget.id);
//     print("getidd======>>>>>>>>>>>>>>>>>");
//     print(widget.id);
//   }
//
//   bool showAllItemsss = false;
//
//   @override
//   void dispose() {
//     _connectivitySubscription?.cancel();
//
//     super.dispose();
//   }
//
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       return;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }
//
//   void checkUserInList(String id) {
//     if (matchessController.exploreDetailsModel!.userInfo.contains(id)) {
//       // User is already in the list
//       Fluttertoast.showToast(msg: "mdkfmdlm");
//     } else {
//       // User is not in the list, you can add them here
//     }
//   }
//
//   void uploadFileToServerInfluencer() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     var userid = prefs.getInt('user_id');
//     print('user_id============== $userid');
//
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     if (_connectionStatus != null) {
//       // Internet Present Case
//       // showLoaderDialog(context);
//     } else {
//       Fluttertoast.showToast(
//           msg: "Please check your Internet connection!!!!",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.black,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//     bool isUserReviewed = matchessController.exploreDetailsModel!.userInfo[0].allReviews.any((review) => review.reviewBy == userid);
//     if(isUserReviewed){Fluttertoast.showToast(msg: "Review is already given in this post");}else{
//       final response = await BaseClient01().post(Appurls.review, {
//         "review": txt_comment.text.toString(),
//         "rating_star": ratingcount.toString() ?? 1,
//         "user_id": widget.id.toString()
//       });
//       // isLoadig(false);
//       bool status = response["success"];
//       var msg = response["message"];
//       if (status == true) {
//         matchessController.get_user_by_id(widget.id);
//
//         // ratingcount.clear();
//         txt_comment.clear();
//         await matchessController.get_user_by_id(widget.id);
//         Navigator.pop(context);
//       }
//     }
//
//     // User is not in the list, you can add them here
//   }
//   RxList tapItemIndex = [].obs;
//
//   final _formKey = GlobalKey<FormState>();
//   InvaiteForDatesController invaiteForDatesController =
//   Get.put(InvaiteForDatesController());
//   DateTime currentDate = DateTime.now();
//   final List<String> genderItems = [
//     'Sports Events',
//     'Concerts',
//     'Fine Dining',
//     'Coffee',
//   ];
//
//   var selectedValue = "Sports Events";
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: currentDate.subtract(
//         const Duration(days: (16 * 365) + 4),
//       ),
//       firstDate: DateTime(1950),
//       lastDate: DateTime(2040),
//     );
//
//     if (picked != null && picked != DateTime.now()) {
//       setState(() {
//         invaiteForDatesController.selectDateC.text =
//         "${picked.month.toString()}-${picked.day.toString()}-${picked.year.toString()}";
//       });
//     }
//   }
//
//   TimeOfDay _selectedTime = TimeOfDay.now();
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//         invaiteForDatesController.selectTimeC.text =
//         "${picked.hour.toString()} : ${picked.minute.toString()}";
//         ;
//       });
//     }
//   }
//
//   bool isloading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     // showAllItems ? allItems : allItems.sublist(0, initialItemCount);
//     void _showBottomSheet(BuildContext context, String userID) {
//       showModalBottomSheet(
//           isScrollControlled: true,
//           context: context,
//           builder: (BuildContext bc) {
//             return Form(
//               key: _formKey,
//               child: SafeArea(
//                 child: Container(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       10.h.heightBox,
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * .62,
//                         child: ListView(
//                           children: [
//                             10.h.heightBox,
//                             const Text(
//                               'Invite For Date',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 20,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0.04,
//                               ),
//                             ).centered(),
//                             47.h.heightBox,
//                             const Text('Select Date',
//                                 style: AppTextStyle.selectDateTextStyle),
//                             5.h.heightBox,
//                             TextFormField(
//                               onTap: () {
//                                 _selectDate(context);
//                               },
//                               readOnly: true,
//                               controller: invaiteForDatesController.selectDateC,
//                               validator: notEmptyValidator,
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(10),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.red,
//                                     )),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black,
//                                     )),
//
//                                 hintText: "MM-DD-YYYY",
//
//                                 hintStyle: TextStyle(
//                                     color: Colors.black.withOpacity(.40),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
//                                 suffixIcon: IconButton(
//                                   icon: const Icon(
//                                     Icons.calendar_month,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () => _selectDate(context),
//                                 ),
//                               ),
//                             ),
//                             10.h.heightBox,
//                             const Text('Select Time',
//                                 style: AppTextStyle.selectDateTextStyle),
//                             5.h.heightBox,
//                             TextFormField(
//                               onTap: () {
//                                 _selectTime(context);
//                               },
//                               readOnly: true,
//                               controller: invaiteForDatesController.selectTimeC,
//                               validator: notEmptyValidator,
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(10),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.red,
//                                     )),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black,
//                                     )),
//
//                                 hintText: "hh-mm",
//
//                                 hintStyle: TextStyle(
//                                     color: Colors.black.withOpacity(.40),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                                 labelStyle: TextStyle(
//                                     color: Colors.black.withOpacity(.40),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
//                                 suffixIcon: IconButton(
//                                   icon: const Icon(
//                                     Icons.access_time_outlined,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () => _selectTime(context),
//                                 ),
//                               ),
//                             ),
//                             10.h.heightBox,
//                             const Text('Select Activity',
//                                 style: AppTextStyle.selectDateTextStyle),
//                             5.h.heightBox,
//
//                             ///  dropdown start /////////////////////////////////////
//
//                             DropdownButtonFormField2<String>(
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(10),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black12,
//                                     )),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.red,
//                                     )),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       width: 1,
//                                       color: Colors.black,
//                                     )),
//                                 hintText: "Select Activity",
//
//                                 hintStyle: TextStyle(
//                                     color: Colors.black.withOpacity(.40),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                                 labelStyle: TextStyle(
//                                     color: Colors.black.withOpacity(.40),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14),
//                                 // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
//                               ),
//                               items: genderItems
//                                   .map((item) => DropdownMenuItem<String>(
//                                 value: item,
//                                 child: Text(
//                                   item,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ))
//                                   .toList(),
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please select activity';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 print("asdfgzsxdfghjhg");
//                                 selectedValue = value.toString();
//                                 print("$selectedValue + :::::::::::::::::::");
//                               },
//                               buttonStyleData: const ButtonStyleData(
//                                 padding: EdgeInsets.only(right: 8),
//                               ),
//                               iconStyleData: const IconStyleData(
//                                 icon: Icon(
//                                   Icons.arrow_downward_rounded,
//                                   size: 22,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                               dropdownStyleData: DropdownStyleData(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                               menuItemStyleData: const MenuItemStyleData(
//                                 padding: EdgeInsets.symmetric(horizontal: 16),
//                               ),
//                             ),
//                             10.h.heightBox,
//
//                             ///  dropdwon end /////////////////////////////////////
//                             const Text('Location',
//                                 style: AppTextStyle.selectDateTextStyle),
//                             5.h.heightBox,
//                             primaryTextfield(
//                                 validator: notEmptyValidator,
//                                 hintText: 'Location',
//                                 controller:
//                                 invaiteForDatesController.locationC),
//                             15.h.heightBox,
//                             Obx(
//                                   () => invaiteForDatesController.isLoading.value
//                                   ? Container(
//                                 width: 350,
//                                 height: 56,
//                                 decoration: ShapeDecoration(
//                                   gradient: const LinearGradient(
//                                     begin: Alignment(0.00, -1.00),
//                                     end: Alignment(0, 1),
//                                     colors: [
//                                       Color(0xFFF65F51),
//                                       Color(0xFFFB4967)
//                                     ],
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 1, color: Colors.white),
//                                     borderRadius:
//                                     BorderRadius.circular(30),
//                                   ),
//                                 ),
//                                 child: const CircularProgressIndicator(
//                                   color: Colors.white,
//                                 ).centered(),
//                               )
//                                   : Container(
//                                 width: 350,
//                                 height: 56,
//                                 decoration: ShapeDecoration(
//                                   gradient: const LinearGradient(
//                                     begin: Alignment(0.00, -1.00),
//                                     end: Alignment(0, 1),
//                                     colors: [
//                                       Color(0xFFF65F51),
//                                       Color(0xFFFB4967)
//                                     ],
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 1, color: Colors.white),
//                                     borderRadius:
//                                     BorderRadius.circular(30),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Invite',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                     height: 0,
//                                   ),
//                                 ).centered(),
//                               ).onTap(() {
//                                 if (_formKey.currentState!.validate()) {
//                                   print("validate");
//
//                                   invaiteForDatesController.invateForDate(
//                                     userID,
//                                     invaiteForDatesController
//                                         .selectDateC.text,
//                                     invaiteForDatesController
//                                         .selectTimeC.text,
//                                     "$selectedValue",
//                                     invaiteForDatesController
//                                         .locationC.text,
//                                   );
//                                 } else {
//                                   print("Not validatef");
//                                   // AppDialog.taostMessage("")
//                                 }
//                               }),
//                             ),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     bottom: MediaQuery.of(context)
//                                         .viewInsets
//                                         .bottom)),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           });
//     }
//
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Obx(
//               () => matchessController.isLoadingget_user_by_id.value
//               ? const Center(child: CircularProgressIndicator())
//               : ListView(
//             children: [
//               Stack(
//                 children: [
//                   matchessController.exploreDetailsModel?.userInfo[0]
//                       .profileImage ==
//                       null
//                       ? Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 415,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg"),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   )
//                       : Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 415,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(matchessController
//                             .exploreDetailsModel
//                             ?.userInfo[0]
//                             .profileImage ??
//                             "https://forreal.net:4000/profile/15471d74-dbc5-4c13-9202-78b7a24c76be.png"),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         )),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         40.heightBox,
//                         Row(
//                           children: [
//                             Text(
//                               '${matchessController.exploreDetailsModel?.userInfo[0].firstName}, ${matchessController.exploreDetailsModel?.userInfo[0].age}',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 20.sp,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const Spacer(),
//                             // InkWell(
//                             //     onTap: () {
//                             //       print("object${ matchessController.exploreDetailsModel!.userInfo[0].id.toString()}");
//                             //       APIs.addChatUser(matchessController.exploreDetailsModel!.userInfo[0].id.toString());
//                             //       Get.to(() => const HomeScreen());
//                             //     },
//                             //     child: SvgPicture.asset(
//                             //         "assets/icons/Group 424.svg"))
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Location',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14.sp,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text(
//                                   matchessController.exploreDetailsModel
//                                       ?.userInfo[0].address ??
//                                       'location',
//                                   style: TextStyle(
//                                     color: Colors.black
//                                         .withOpacity(0.699999988079071),
//                                     fontSize: 12.sp,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             /*     Container(
//                                 child: Text(
//                                   '1 km',
//                                   style: TextStyle(
//                                     color: Color(0xFFFB4967),
//                                     fontSize: 12,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ).centered(),
//                                 width: 72.58,
//                                 height: 34,
//                                 decoration: ShapeDecoration(
//                                   color: Color(0x1AE94057),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(7)),
//                                 ),
//                               )*/
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'About',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 295,
//                           child: Text(
//                             "Description",
//                             style: TextStyle(
//                               color: Colors.black
//                                   .withOpacity(0.699999988079071),
//                               fontSize: 14,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         21.heightBox,
//                         /*Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Ratings',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               10.widthBox,
//                               Text(
//                                 data?.totalReviewStar != null
//                                     ? data!.totalReviewStar.toString()
//                                     : "",
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               10.widthBox,
//                               Text(
//                                 data!.allReviews.length.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           10.heightBox,*/
//                         Row(
//                           children: [
//                             Text(
//                               'Total Review : ${matchessController.exploreDetailsModel?.userInfo[0].allReviews.length}.0',
//                               style:  TextStyle(
//                                 color:Colors.black.withOpacity(.70),
//                                 fontSize: 12,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const Spacer(),
//                             InkWell(
//                               onTap: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return Dialog(
//                                         backgroundColor: Colors.white,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.circular(
//                                                 20.0)), //this right here
//                                         child: Container(
//                                           height: 210,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(
//                                                 12.0),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .center,
//                                               // crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 const Text(
//                                                   'Review',
//                                                   textAlign:
//                                                   TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 20.98,
//                                                     fontFamily: 'Roboto',
//                                                     fontWeight:
//                                                     FontWeight.w700,
//                                                     height: 0,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 RatingBar.builder(
//                                                   itemSize: 30,
//                                                   initialRating: 0,
//                                                   minRating: 1,
//                                                   direction:
//                                                   Axis.horizontal,
//                                                   allowHalfRating: false,
//                                                   itemCount: 5,
//                                                   itemPadding:
//                                                   const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal:
//                                                       3.0),
//                                                   itemBuilder:
//                                                       (context, _) =>
//                                                   const Icon(
//                                                     Icons.star,
//                                                     color: Colors.amber,
//                                                   ),
//                                                   onRatingUpdate:
//                                                       (rating) {
//                                                     setState(() {
//                                                       ratingcount =
//                                                           rating;
//                                                     });
//                                                   },
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 TextField(
//                                                   controller: txt_comment,
//                                                   decoration:
//                                                   const InputDecoration(
//                                                       hintText:
//                                                       'Add Commment'),
//                                                 ),
//                                                 const SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Container(
//                                                   height: 50,
//                                                   // width: 200,
//                                                   child: Align(
//                                                       alignment: Alignment
//                                                           .bottomRight,
//                                                       child: Row(
//                                                         children: [
//                                                           TextButton(
//                                                               onPressed:
//                                                                   () {
//                                                                 Navigator.pop(
//                                                                     context); //close Dialog
//                                                               },
//                                                               child: const Text(
//                                                                   "Cancel",
//                                                                   style: TextStyle(
//                                                                       color:
//                                                                       Colors.black))),
//                                                           TextButton(
//                                                               onPressed:
//                                                                   () {
//                                                                 if (formKey
//                                                                     .currentState!
//                                                                     .validate()) {
//
//                                                                   uploadFileToServerInfluencer();
//
//
//                                                                   // if(matchessController.exploreDetailsModel.userInfo.contains())
//                                                                 }
//                                                                 // uploadFileToServerInfluencer();
//                                                               },
//                                                               child: const Text(
//                                                                   "Save",
//                                                                   style: TextStyle(
//                                                                       color:
//                                                                       Colors.black)))
//                                                         ],
//                                                       )),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     });
//                               },
//                               child: Opacity(
//                                 opacity: 0.70,
//                                 child: Text(
//                                   'Add Review',
//                                   style: TextStyle(
//                                     color: Colors.black.withOpacity(.70),
//                                     fontSize: 14,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         10.heightBox,
//                         /*   const Text(
//                             'Review ',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 14,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           10.heightBox,
//
//                           matchessController.exploreDetailsModel!.userInfo[0].allReviews.isEmpty
//                               ? Container(
//                                   margin:
//                                       const EdgeInsets.only(top: 20, bottom: 20),
//                                   child: const Center(
//                                       child: Text(
//                                     "No Review Found !!",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.grey),
//                                   )),
//                                 )
//                               : const SizedBox(),*/
//                         for (int i = 0;
//                         i < matchessController.displayedItemss.length;
//                         i++)
//                           matchessController.displayedItemss == null &&
//                               matchessController.exploreDetailsModel
//                                   ?.userInfo[0].allReviews ==
//                                   null &&
//                               matchessController.exploreDetailsModel!
//                                   .userInfo[0].allReviews.isEmpty
//                               ? const SizedBox()
//                               : Container(
//                               decoration: BoxDecoration(
//                                   color:
//                                   Colors.black12.withOpacity(.02),
//                                   borderRadius:
//                                   BorderRadius.circular(10)),
//                               child: ListTile(
//                                   leading: Container(
//                                     height: 50,
//                                     width: 50,
//                                     child: CachedNetworkImage(
//                                         imageUrl: matchessController
//                                             .exploreDetailsModel
//                                             ?.userInfo[0]
//                                             .allReviews[i]
//                                             .reviewerProfileImage ??
//                                             "",
//                                         imageBuilder: (context,
//                                             imageProvider) =>
//                                             CircleAvatar(
//                                               radius: 25,
//                                               backgroundImage: NetworkImage(
//                                                   matchessController
//                                                       .exploreDetailsModel
//                                                       ?.userInfo[
//                                                   0]
//                                                       .allReviews[
//                                                   i]
//                                                       .reviewerProfileImage ??
//                                                       ""),
//                                             ),
//                                         placeholder: (context, url) {
//                                           return Center(
//                                               child: Image.network(
//                                                 "https://raw.githubusercontent.com/prafful98/vue3-shimmer/HEAD/assets/card.gif",
//                                                 fit: BoxFit.fill,
//                                                 alignment:
//                                                 Alignment.center,
//                                                 height: 120,
//                                                 width: double.infinity,
//                                               ));
//                                         },
//                                         errorWidget: (context, url,
//                                             error) =>
//                                         const CircleAvatar(
//                                           radius: 25,
//                                           backgroundImage: AssetImage(
//                                               "assets/images/noImage.png"),
//                                         )),
//                                   ),
//                                   title: Text(
//                                     matchessController
//                                         .exploreDetailsModel
//                                         ?.userInfo[0]
//                                         .allReviews[i]
//                                         .review ??
//                                         "Nice boy",
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   subtitle: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: List.generate(
//                                         matchessController
//                                             .exploreDetailsModel!
//                                             .userInfo[0]
//                                             .allReviews[i]
//                                             .ratingStar, (index) {
//                                       int filledStars =
//                                       matchessController
//                                           .exploreDetailsModel!
//                                           .userInfo[0]
//                                           .allReviews[i]
//                                           .ratingStar
//                                           .floor();
//                                       if (index < filledStars) {
//                                         // Display a filled star
//                                         return const Icon(
//                                           Icons.star,
//                                           color: Colors.amberAccent,
//                                         );
//                                       } else {
//                                         // Display an outline star
//                                         return const Icon(
//                                           Icons.star_border,
//                                           color: Colors.grey,
//                                         );
//                                       }
//                                     }),
//
//                                     /*         Row(
//                                       children: [
//                                         Icon(Icons.star,
//                                             size: 17,
//                                             color:
//                                                 data?.allReviews[i].ratingStar == 1
//                                                     ? Colors.amber
//                                                     : Colors.grey),
//                                         Icon(Icons.star,
//                                             size: 17,
//                                             color:
//                                                 data?.allReviews[i].ratingStar == 2
//                                                     ? Colors.amber
//                                                     : Colors.grey),
//                                         Icon(Icons.star,
//                                             size: 17,
//                                             color:
//                                                 data?.allReviews[i].ratingStar == 3
//                                                     ? Colors.amber
//                                                     : Colors.grey),
//                                         Icon(Icons.star,
//                                             size: 17,
//                                             color:
//                                                 data?.allReviews[i].ratingStar == 4
//                                                     ? Colors.amber
//                                                     : Colors.grey),
//                                         Icon(Icons.star,
//                                             size: 17,
//                                             color:
//                                                 data?.allReviews[i].ratingStar == 5
//                                                     ? Colors.amber
//                                                     : Colors.grey),
//                                       ],
//                                     )*/
//                                   ))).paddingOnly(bottom: 10),
//                         10.heightBox,
//                         ElevatedButton(
//                           onPressed: () {
//                             // Toggle between showing limited and all items
//                             setState(() {
//                               showAllItemsss = !showAllItemsss;
//                               matchessController.displayedItemss =
//                               showAllItemsss
//                                   ? List.from(matchessController
//                                   .exploreDetailsModel!
//                                   .userInfo[0]
//                                   .allReviews)
//                                   : matchessController
//                                   .exploreDetailsModel!
//                                   .userInfo[0]
//                                   .allReviews
//                                   .take(1)
//                                   .toList();
//                             });
//                           },
//                           child: Text(
//                               showAllItemsss ? 'Show Less' : 'See More'),
//                         ),
//
//                         /* if (!showAllItems)
//                             TextButton(
//                               onPressed: () {
//                                 showAllItems = true;
//                                 setState(() {
//                                   // Show all items when the button is clicked
//                                   visibleItemCount = data.allReviews.length;
//                                 });
//                               },
//                               child: const Text('See More'),
//                             ),*/
//                         /* Text(
//                             'Show all',
//                             style: TextStyle(
//                               color: Color(0xFFE94057),
//                               fontSize: 12,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ).centered(),*/
//                         20.heightBox,
//                         const Text(
//                           'Interests',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         10.heightBox,
//                         matchessController.exploreDetailsModel
//                             ?.userInfo[0].insertdata ==
//                             null
//                             ? const Text("No Intrest Found !!")
//                             : SizedBox(
//                           height: 100,
//                           child: GridView.builder(
//                             itemCount: matchessController
//                                 .exploreDetailsModel
//                                 ?.userInfo[0]
//                                 .insertdata
//                                 .length !=
//                                 0
//                                 ? matchessController
//                                 .exploreDetailsModel
//                                 ?.userInfo[0]
//                                 .insertdata
//                                 .length
//                                 : 0,
//                             itemBuilder: (ctx, i) {
//                               return Container(
//                                 height: 50,
//                                 child: DottedBorder(
//                                   strokeWidth: 1,
//                                   color: const Color(0xFFE94057),
//                                   borderType: BorderType.RRect,
//                                   radius: const Radius.circular(12),
//                                   child: ClipRRect(
//                                     borderRadius:
//                                     const BorderRadius.all(
//                                       Radius.circular(5),
//                                     ),
//                                     child: Center(
//                                       child: Container(
//                                         width: 220,
//                                         height: 32,
//                                         child: Text(
//                                           matchessController
//                                               .exploreDetailsModel
//                                               ?.userInfo[0]
//                                               .insertdata[i] ??
//                                               "",
//                                           style: const TextStyle(
//                                             color:
//                                             Color(0xFFE94057),
//                                             fontSize: 8,
//                                             fontFamily: 'Inter',
//                                             fontWeight:
//                                             FontWeight.w400,
//                                             height: 0.11,
//                                           ),
//                                         ).centered(),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 mainAxisExtent: 30,
//                                 crossAxisSpacing: 10),
//                           ),
//                         ),
//                         const Text(
//                           'Gallery',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         20.heightBox,
//                         matchessController.exploreDetailsModel
//                             ?.userInfo[0].images.length !=
//                             0 &&
//                             matchessController.exploreDetailsModel
//                                 ?.userInfo[0].images !=
//                                 null
//                             ? Container(
//                           height: 300,
//                           child: GridView.builder(
//                               physics:
//                               const NeverScrollableScrollPhysics(),
//                               itemCount: matchessController
//                                   .exploreDetailsModel
//                                   ?.userInfo[0]
//                                   .images
//                                   .length,
//                               gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   mainAxisSpacing: 10,
//                                   crossAxisSpacing: 5),
//                               itemBuilder: (ctx, index) {
//                                 final data = matchessController
//                                     .exploreDetailsModel!
//                                     .userInfo[0]
//                                     .images[index];
//
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black12),
//                                     borderRadius: BorderRadius.circular(10),
//
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(10),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: CachedNetworkImage(
//                                         imageUrl: data.profileImages ?? "",
//                                         imageBuilder: (context, imageProvider) => Container(
//                                           decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                                 image: imageProvider,
//                                                 fit: BoxFit.cover,
//                                                 colorFilter: const ColorFilter.mode(
//                                                     Colors.white,
//                                                     BlendMode.colorBurn)),
//                                           ),
//                                         ),
//                                         placeholder: (context, url) => const Center(
//                                             child: CircularProgressIndicator()),
//                                         errorWidget: (context, url, error) =>
//                                         const Icon(Icons.person_2_outlined),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                                 CachedNetworkImage(
//                                   imageUrl: data.profileImages,
//                                   imageBuilder:
//                                       (context, imageProvider) =>
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image: imageProvider,
//                                               fit: BoxFit.cover,
//                                               colorFilter:
//                                               const ColorFilter
//                                                   .mode(
//                                                   Colors.white,
//                                                   BlendMode
//                                                       .colorBurn)),
//                                         ),
//                                       ),
//                                   placeholder: (context, url) =>
//                                   const Center(
//                                       child:
//                                       CircularProgressIndicator()),
//                                   errorWidget:
//                                       (context, url, error) =>
//                                   const Icon(Icons.person_2_outlined),
//                                 );
//
//
//                               }),
//                         )
//                             : const Text("No Images Found !!"),
//
//                         30.heightBox,
//                         InkWell(
//                           onTap: () {
//                             swipController.sendNotificationOnlyMatch(matchessController.exploreDetailsModel!.userInfo[0].id.toString());
//                             // _showBottomSheet(
//                             //     context,
//                             //     matchessController.exploreDetailsModel!.userInfo[0].id.toString());
//                           },
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 56,
//                             decoration: ShapeDecoration(
//                               gradient: const LinearGradient(
//                                 begin: Alignment(0.00, -1.00),
//                                 end: Alignment(0, 1),
//                                 colors: [
//                                   Color(0xFFF65F51),
//                                   Color(0xFFFB4967)
//                                 ],
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 side: const BorderSide(
//                                     width: 1, color: Colors.white),
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: const Text(
//                               'Send Request',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0,
//                               ),
//                             ).centered(),
//                           ),
//                         ),
//                         30.heightBox,
//                       ],
//                     ).paddingOnly(left: 20, right: 20),
//                   ).paddingOnly(top: 385),
//                   InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.0),
//                         border: Border.all(
//                           color: const Color(0xFFE8E6EA),
//                           // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
//                           width: 1.0, // Border width
//                         ),
//                         color: const Color(
//                             0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
//                       ),
//                       child: const Icon(Icons.arrow_back_ios_outlined,
//                           color: colors.primary, size: 18),
//                     ).paddingOnly(left: 20, top: 20),
//                   )
//                 ],
//               ),
//               15.heightBox,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   double getRatingForItem(int index) {
//     // Replace this logic with your actual rating retrieval logic
//     // For example, return a different rating based on the item index
//     return (index + 1).toDouble();
//   }
// }
