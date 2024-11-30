import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:get/get.dart';
import 'gender_controller.dart';

class SelectGenderPage extends StatefulWidget {
  const SelectGenderPage({Key? key}) : super(key: key);

  @override
  State<SelectGenderPage> createState() => _SelectGenderPageState();
}

class _SelectGenderPageState extends State<SelectGenderPage> {
  GenderController genderController = Get.put(GenderController());
  String? gender;
  List<bool> gender1 = [false, false, false];

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: customGenderAppbar("Select Gender", context),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      gender1[0] = true;
                      gender1[1] = false;
                      gender1[2] = false;
                      setState(() {
                        genderController.gender.value = "WOMEN";
                      });
                    },
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: gender1[0] ? Colors.redAccent : Colors.white,
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text('Women                                                           ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: gender1[0] ? Colors.white : Colors.black)),
                          ),
                          gender1[0]
                              ? SvgPicture.asset(
                                  'assets/icons/click.svg',
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: .1,
                                  height: .1,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      gender1[1] = true;
                      gender1[0] = false;
                      gender1[2] = false;
                      setState(() {
                        genderController.gender.value = "MEN";
                      });
                    },
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: gender1[1] ? Colors.redAccent : Colors.white,
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text('Men                                                           ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: gender1[1] ? Colors.white : Colors.black)),
                          ),
                          gender1[1]
                              ? SvgPicture.asset(
                                  'assets/icons/click.svg',
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: .1,
                                  height: .1,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      gender1[2] = true;
                      gender1[1] = false;
                      gender1[0] = false;

                      setState(() {
                        genderController.gender.value = "OTHER";
                      });
                    },
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: gender1[2] ? Colors.redAccent : Colors.white,
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text('Other                                                           ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: gender1[2] ? Colors.white : Colors.black)),
                          ),
                          gender1[2]
                              ? SvgPicture.asset(
                                  'assets/icons/click.svg',
                                  color: Colors.white,
                                )
                              : SizedBox(
                                  width: .1,
                                  height: .1,
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Obx(
              () => customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  genderController.selectGender();
                },
                loading: genderController.isLoadig.value,
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
