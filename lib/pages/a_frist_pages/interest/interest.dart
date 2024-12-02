import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';

import '../../../function/function_class.dart';
import 'interest_controller.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key, this.selectedInterest});

  final List<String>? selectedInterest;

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<({String emoji, String interest, RxBool selected})> allInterest = <({String emoji, String interest, RxBool selected})>[
    (emoji: "🎮", interest: "Gaming", selected: false.obs),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InterestController interestController = Get.put(InterestController(selectedInterest: widget.selectedInterest));
    widget.selectedInterest?.forEach(
      (e) {
        allInterest
            .firstWhereOrNull(
              (element) => element.interest.trim().toLowerCase() == e.toString().toLowerCase().trim(),
            )
            ?.selected
            .value = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    InterestController interestController = Get.find();
    return Scaffold(
      appBar: customAppbar("Your Interest", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                'Select your interests to match with users who have similar things in common.',
                style: CustomTextStyle.blacky,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).size.width / 165).floor(),
                  mainAxisSpacing: 20, // Spacing between rows
                  crossAxisSpacing: 10, // Spacing between columns
                  childAspectRatio: 165 / 43, // Aspect ratio of each item
                ),
                itemCount: allInterest.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
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
                  });
                  return Container();
                },
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            customPrimaryBtn(
              btnText: "Continue",
              btnFun: () {
                if (allInterest
                    .where(
                      (element) => element.selected.value == true,
                    )
                    .toList()
                    .isEmpty) {
                  Fluttertoast.showToast(msg: "You must select at least one interest to continue.");
                  return;
                }
                interestController.interestSelect((allInterest
                        .where(
                          (element) => element.selected.value == true,
                        )
                        .toList())
                    .map(
                      (e) => e.interest,
                    )
                    .join(","));
              },
              loading: interestController.isLoadig.value,
            ),
          ],
        ),
      ),
    );
  }
}
