import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/widgets/custom_buttons.dart';

import 'hobbies_controller.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({Key? key}) : super(key: key);

  @override
  State<HobbiesPage> createState() => _Interest_ScreenState();
}

class _Interest_ScreenState extends State<HobbiesPage> {
  HobbiesController hobbiesController = Get.put(HobbiesController());

  List<bool> active = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true];

  List<String> InterestS = [
    "Gaming,",
    "Dancing,",
    "Language,",
    "Music,",
    "Movie,",
    "Photography,",
    "Fashion,",
    "Architecture,",
    "Book,",
    "Writing,",
    "Animals,",
    "Football,",
    'Gym & Fitness,',
    'Travel & Places,',
  ];
  List<String> AllInters = [
    "Gaming,",
    "Dancing,",
    "Language,",
    "Music,",
    "Movie,",
    "Photography,",
    "Fashion,",
    "Architecture,",
    "Book,",
    "Writing,",
    "Animals,",
    "Football,",
    'Gym & Fitness,',
    'Travel & Places,',
  ];

  List<String> FinalInterest = [];
  var hobbies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              'assets/icons/btn.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text(
          'Your Hobby',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
              child: Text(
                'Select your hobby to match with users who '
                '\nhave similar things in common.',
                style: CustomTextStyle.blacky,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    active[0] = !active[0];
                    setState(() {
                      InterestS[0] = "Gaming,";
                      //print(InterestS.toString());
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[0] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('🎮   Gaming', style: TextStyle(color: active[0] ? Colors.red : Colors.white, fontSize: 18))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    active[1] = !active[1];
                    setState(() {
                      InterestS[1] = "Dancing,";
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[1] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '💃🏻 Dancing',
                      style: TextStyle(color: active[1] ? Colors.red : Colors.white, fontSize: 18),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    active[2] = !active[2];
                    setState(() {
                      InterestS[2] = "Language,";
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[2] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '🗣 Language',
                      style: TextStyle(color: active[2] ? Colors.red : Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                InkWell(
                    onTap: () {
                      active[3] = !active[3];
                      setState(() {
                        InterestS[3] = "Music,";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 160,
                      decoration: BoxDecoration(
                          color: active[3] ? Colors.white : Colors.redAccent,
                          border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        '🎵 Music',
                        style: TextStyle(color: active[3] ? Colors.red : Colors.white, fontSize: 18),
                      )),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    active[4] = !active[4];
                    setState(() {
                      InterestS[4] = "Movie,";
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[4] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '🎬 Movie',
                      style: TextStyle(color: active[4] ? Colors.red : Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                InkWell(
                    onTap: () {
                      active[5] = !active[5];
                      setState(() {
                        InterestS[5] = "Photography,";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 160,
                      decoration: BoxDecoration(
                          color: active[5] ? Colors.white : Colors.redAccent,
                          border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        '📸 Photography',
                        style: TextStyle(color: active[5] ? Colors.red : Colors.white, fontSize: 18),
                      )),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    active[6] = !active[6];
                    setState(() {
                      InterestS[6] = "Fashion,";
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[6] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '👗 Fashion',
                      style: TextStyle(color: active[6] ? Colors.red : Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                InkWell(
                    onTap: () {
                      active[7] = !active[7];
                      setState(() {
                        InterestS[7] = "Architecture,";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 160,
                      decoration: BoxDecoration(
                          color: active[7] ? Colors.white : Colors.redAccent,
                          border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        '🏛 Architecture',
                        style: TextStyle(color: active[7] ? Colors.red : Colors.white, fontSize: 18),
                      )),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    active[8] = !active[8];
                    setState(() {
                      InterestS[8] = "Book,";
                    });
                  },
                  child: Container(
                    height: 43,
                    width: 160,
                    decoration: BoxDecoration(
                        color: active[8] ? Colors.white : Colors.redAccent,
                        border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '📚 Book',
                      style: TextStyle(color: active[8] ? Colors.red : Colors.white, fontSize: 18),
                    )),
                  ),
                ),
                InkWell(
                    onTap: () {
                      active[9] = !active[9];
                      setState(() {
                        InterestS[9] = "Writing,";
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 160,
                      decoration: BoxDecoration(
                          color: active[9] ? Colors.white : Colors.redAccent,
                          border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text('✍🏻 Writing', style: TextStyle(color: active[9] ? Colors.red : Colors.white, fontSize: 18))),
                    ))
              ],
            ),
            SizedBox(
              height: 180.h,
            ),
            customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  for (int i = 0; i < AllInters.length; i++) {
                    if (active[i] == false) {
                      FinalInterest.add(AllInters[i]);
                    }
                  }
                  hobbies = FinalInterest.join();
                  hobbiesController.hobbiesSelect("$hobbies");
                }),
          ],
        ),
      ),
    );
  }
}
