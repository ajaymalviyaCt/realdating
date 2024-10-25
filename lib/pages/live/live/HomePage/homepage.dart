import 'dart:math';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:realdating/pages/live/live/agora/audience.dart';
import 'package:realdating/pages/live/live/agora/host.dart';

import '../../../dash_board_page.dart';
import '../constant/live.dart';
import '../constant/liveusercard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getLiveUsers();
    checkExist();
  }

  void checkExist() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .collection("Liveusers")
          .doc(user!.uid)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      if (exist) {
        FirebaseFirestore.instance
            .collection("Liveusers")
            .doc(user!.uid)
            .delete();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void getLiveUsers() async {
    FirebaseFirestore.instance
        .collection("Liveusers")
        .snapshots()
        .listen((result) {
      for (var element in result.docs) {
        setState(() {
          list.add(Live(
            username: element.data()['username'],
            image: "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
            channelName: element.data()['channelname'],
            userid: element.data()['userid'],
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.offAll(()=>DashboardPage());
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.redAccent,
          title: const Text(
            "Live Users",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Center(
          child: getStories(),
        ),
        floatingActionButton: InkWell(
          onTap: () {
           // connectionChecker();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(40),
            ),
            height: 50,
            width: 150,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call,
                  size: 30,
                ),
                Text(
                  "Go Live",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget getStories() {
    return ListView(
      children: getUserStories(),
    );
  }

  List<Widget> getUserStories() {
    List<Widget> stories = [];
    for (Live Users in list) {
      stories.add(getStory(Users));
    }
    return stories;
  }

  Widget getStory(Live user) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.offAll(() => Audience(
                  channelName: user.channelName, userId: user.username));
            },
            child: LiveUserCard(
              broadcasterName: user.username,
              image: user.image,
            ),
          )
        ],
      ),
    );
  }

  // void connectionChecker() async {
  //   bool check = await InternetConnectionChecker().hasConnection;
  //   if (check) {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     String channel = generateRandomString(8);
  //     await [Permission.camera, Permission.microphone].request().then((value) {
  //       Get.offAll(() => Host(channelName: channel, userId: user!.displayName));
  //     });
  //   } else {
  //     Get.snackbar("Error", "No internet Connection",
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
