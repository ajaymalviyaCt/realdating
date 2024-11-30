import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/widgets/custom_buttons.dart';

import 'hobbies_controller.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key, this.selectedHobby});

  final List<String>? selectedHobby;

  @override
  State<HobbiesPage> createState() => _Interest_ScreenState();
}

class _Interest_ScreenState extends State<HobbiesPage> {
  List<({String emoji, String interest, RxBool selected})> allInterest = <({String emoji, String interest, RxBool selected})>[
    (emoji: "🎮", interest: "Gaming,", selected: false.obs),
    (emoji: "💃🏻", interest: "Dancing", selected: false.obs),
    (emoji: "🗣", interest: "Language", selected: false.obs),
    (emoji: "🎵", interest: "Music", selected: false.obs),
    (emoji: "🎬", interest: "Movie", selected: false.obs),
    (emoji: "✍🏻", interest: "Photography", selected: false.obs),
    (emoji: "👗", interest: "Fashion", selected: false.obs),
    (emoji: "📚", interest: "Architecture", selected: false.obs),
    (emoji: "🐼", interest: "Book", selected: false.obs),
    (emoji: "✍🏻", interest: "Writing,", selected: false.obs),
    (emoji: "🐼", interest: "Animals", selected: false.obs),
    (emoji: "⚽", interest: "Football", selected: false.obs),
    (emoji: "💪", interest: "Gym & Fitness", selected: false.obs),
    (emoji: "🌇", interest: "Travel & Places", selected: false.obs),
  ];

  // "Gaming,",
  // "Dancing,",
  // "Language,",
  // "Music,",
  // "Movie,",
  // "Photography,",
  // "Fashion,",
  // "Architecture,",
  // "Book,",
  // "Writing,",
  // "Animals,",
  // "Football,",
  // 'Gym & Fitness,',
  // 'Travel & Places,',

  @override
  void initState() {
    super.initState();

    HobbiesController hobbiesController = Get.put(HobbiesController(selectedHobby: widget.selectedHobby));
  }

  @override
  Widget build(BuildContext context) {
    HobbiesController hobbiesController = Get.find();
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery
                      .of(context)
                      .size
                      .width / 165).floor(),
                  mainAxisSpacing: 20, // Spacing between rows
                  crossAxisSpacing: 10, // Spacing between columns
                  childAspectRatio: 165 / 43, // Aspect ratio of each item
                ),
                itemCount: allInterest.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      allInterest[index].selected.value = !allInterest[index].selected.value;

                      setState(() {
                        //print(InterestS.toString());
                      });
                    },
                    child: Container(
                      height: 43,
                      width: 160,
                      decoration: BoxDecoration(
                          color: allInterest[index].selected.value == false ? Colors.white : Colors.redAccent,
                          border: Border.all(style: BorderStyle.solid, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(allInterest[index].emoji + (allInterest[index].interest),
                              style: TextStyle(color: allInterest[index].selected.value == false ? Colors.red : Colors.white, fontSize: 18))),
                    ),
                  );
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: 140.h,
            ),
            customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  /*
                  FinalInterest.clear();
                  for (int i = 0; i < allInterest.length; i++) {
                    if (active[i] == false) {
                      FinalInterest.add(allInterest[i]);
                    }
                  }
                  print("line 333");
                  print(FinalInterest.length);

                  hobbies = FinalInterest.join();

                  */
                  if (allInterest
                      .where(
                        (element) => element.selected.value == true,
                  )
                      .toList()
                      .isEmpty) {
                    Fluttertoast.showToast(msg: "You must select at least one hobby to continue.");
                    return;
                  }
                  hobbiesController.hobbiesSelect(allInterest
                      .where(
                        (element) => element.selected.value == true,
                  )
                      .toList()
                      .join(","));
                }),
          ],
        ),
      ),
    );
  }
}
