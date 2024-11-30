import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/explore/matches/matches_controller.dart';

class ProfileMatches extends StatefulWidget {
  String id;

  ProfileMatches({super.key, required this.id});

  @override
  State<ProfileMatches> createState() => _ProfileMatchesState();
}

class _ProfileMatchesState extends State<ProfileMatches> {
  MatchessController matchessController = Get.put(MatchessController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // matchessController.exploreDetailsApi(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Stack(children: [
        SvgPicture.asset("assets/images/Background Pattern.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/images/Group 2053.png"),
            ),
          ],
        ),
      ]),
    );
  }
}
