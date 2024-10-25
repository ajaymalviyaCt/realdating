import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../consts/app_colors.dart';

class InviteFriendPage extends StatefulWidget {
  const InviteFriendPage({super.key});

  @override
  State<InviteFriendPage> createState() => _InviteFriendPageState();
}

class _InviteFriendPageState extends State<InviteFriendPage> {
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
          text: 'Invite Friends',
          fSize: 24,
          fWeight: FontWeight.w600,
          lineHeight: 24,
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/undraw_love_re_mwbq 1.png')),
          SizedBox(height: 50),
          customTextCommon(
              text: 'Share With Friends',
              fSize: 24,
              fWeight: FontWeight.w600,
              lineHeight: 30),
          SizedBox(height: 44),
          customTextCommon(
              text:
              ' "Share app, invite friends, together \n explore endless possibilities. Enjoy!" ',
              fSize: 16,
              fWeight: FontWeight.w500,
              lineHeight: 22),
          Spacer(),
          InkWell(
            onTap: () {
              final String linkToShare = 'I am Pramod Vishawakarma'; // Replace
              Share.share(linkToShare);
// with your link
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Center(
                child: Text(
                  'Share',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ).paddingOnly(left: 20, right: 20),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  PreferredSize preferredSizeAppBar(String title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(114.h), // preferred height for the app bar
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
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
              child: Center(
                  child: SvgPicture.asset("assets/icons/backbtttonIcon.svg")),
            ).paddingOnly(
              left: 16.w,
            ),
          ),
          Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 20.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Spacer(),
          Container(
            width: 54.08.h * .90,
            height: 52.h * .90,
          ).paddingOnly(
            right: 16.w,
          ),
        ],
      ).paddingOnly(top: 50.h, bottom: 14.h),
    );
  }
}
