import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../function/function_class.dart';
import '../../widgets/custom_text_styles.dart';
import '../buisness_profile/business_profile_controller.dart';

class BusinessButton extends StatefulWidget {
  const BusinessButton({Key? key}) : super(key: key);

  @override
  State<BusinessButton> createState() => _BusinessButtonState();
}

class _BusinessButtonState extends State<BusinessButton> {
  bool status = false;
  bool? isSwitched;
  final BusinessProfileController profileController =
      Get.put(BusinessProfileController());
  var days;

  bool switchB(days) {
    if (days == 2) {
      return isSwitched = true;
    } else {
      return isSwitched = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/icons/btn.svg'),
          ),
        ),
        title: const Text(
          'Business Hours',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Mon',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.modayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.modayDate = 2;
                        } else {
                          profileController.modayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Tus',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.tuesDayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.tuesDayDate = 2;
                        } else {
                          profileController.tuesDayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Wed',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.webnesdayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.webnesdayDate = 2;
                        } else {
                          profileController.webnesdayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Thu',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.thursdayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.thursdayDate = 2;
                        } else {
                          profileController.thursdayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Fri',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.friDayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.friDayDate = 2;
                        } else {
                          profileController.friDayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                    // trackColor: MaterialStateProperty.all(Appcolor.Redpink),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Sat',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.saturDayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.saturDayDate = 2;
                        } else {
                          profileController.saturDayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextCommon(
                  text: 'Sun',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                customTextCommon(
                  text: '10.00Am - 6:00 Pm',
                  fSize: 16,
                  fWeight: FontWeight.w600,
                  lineHeight: 16,
                ),
                Transform.scale(
                  scale: 1.0,
                  child: Switch(
                    value: switchB(profileController.sunDayDate),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isSwitched = value;
                        if (value == true) {
                          profileController.sunDayDate = 2;
                        } else {
                          profileController.sunDayDate = 1;
                        }
                      });
                      print(profileController.sunDayDate);
                    },
                    activeTrackColor: Appcolor.Redpink,

                    activeColor: Colors.white,
                    trackOutlineColor: isSwitched != true
                        ? MaterialStateProperty.all(Appcolor.ggrry)
                        : MaterialStateProperty.all(Appcolor.Redpink),
// trackColor:MaterialStateProperty.all(Appcolor.Redpink) ,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Color(0xffAAAAAA).withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
