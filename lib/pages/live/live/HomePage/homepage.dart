import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

import '../../../dash_board_page.dart';
import '../agora/audience.dart';
import '../agora/host.dart';
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
  bool isDeviceConnected = false;
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    super.initState();
    getLiveUsers();
    checkExist();

    // Check initial connection
    checkConnectivity();

    // Listen for connectivity changes
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        isDeviceConnected = true;
      } else {
        isDeviceConnected = false;
      }
      setState(() {}); // Update the UI based on connectivity
    });
  }

  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    isDeviceConnected = result != ConnectivityResult.none;
    setState(() {}); // Update the UI based on initial connectivity
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
    FirebaseFirestore.instance.collection("Liveusers").snapshots().listen((result) {
      setState(() {
        list.clear();
        for (var element in result.docs) {
          list.add(Live(
            username: element.data()['username'],
            image: "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
            channelName: element.data()['channelname'],
            userid: element.data()['userid'],
          ));
        }
      });
    });
  }

  Future<void> goLive() async {
    if (!isDeviceConnected) {
      Get.snackbar("Error", "No internet connection", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // var status = await [Permission.camera, Permission.microphone].request();
    // if (!status[Permission.camera]!.isGranted || !status[Permission.microphone]!.isGranted) {
    //   Get.snackbar("Error", "Permissions are required to go live", snackPosition: SnackPosition.BOTTOM);
    //   return; // Stop if permissions are not granted
    // }




    var status = await [Permission.camera, Permission.microphone].request();
    if (status[Permission.camera]!.isGranted && status[Permission.microphone]!.isGranted) {
      String channel = generateRandomString(8);
      Get.offAll(() => Host(channelName: channel, userId: user!.displayName));
    } else {
      Get.snackbar("Error", "Camera and Microphone permissions are required to go live",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.offAll(()=>const DashboardPage());
              },
              child: const Icon(Icons.arrow_back)),
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
          onTap: goLive, // Call goLive on button tap
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
    for (Live user in list) {
      stories.add(getStory(user));
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
              Get.offAll(() => Audience(channelName: user.channelName, userId: user.username));
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
}
