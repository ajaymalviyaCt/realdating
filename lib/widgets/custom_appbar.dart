import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/app_colors.dart';
import 'custom_text_styles.dart';

AppBar customAppbar(String title, context) {
  return AppBar(
    surfaceTintColor: Colors.white,
    title: customTextCommon(
      text: title,
      fSize: 24,
      fWeight: FontWeight.w600,
      lineHeight: 24,
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    leading: Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            print("Go back");
            Get.back();
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: const Color(0xFFE8E6EA), // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                width: 1.0, // Border width
              ),
              color: const Color(0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
            ),
            child: const Icon(Icons.arrow_back_ios_outlined, color: colors.primary, size: 18),
          ),
        ),
      ],
    ),
  );
}

AppBar customGenderAppbar(String title, context) {
  return AppBar(
    surfaceTintColor: Colors.white,
    title: customTextCommon(
      text: title,
      fSize: 24,
      fWeight: FontWeight.w600,
      lineHeight: 24,
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    leading: const Row(
      children: [
        SizedBox(
          width: 15,
        ),
        // InkWell(
        //   onTap: (){
        //     print("Go back");
        //     Get.back();
        //   },
        //   child: Container(
        //     width: 35,
        //     height: 35,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15.0),
        //       border: Border.all(
        //         color: Color(
        //             0xFFE8E6EA), // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
        //         width: 1.0, // Border width
        //       ),
        //       color: Color(
        //           0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
        //     ),
        //     child: Icon(Icons.arrow_back_ios_outlined,color: colors.primary,size: 18),
        //   ),
        // ),
      ],
    ),
  );
}
