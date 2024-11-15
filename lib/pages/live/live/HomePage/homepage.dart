import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realdating/chat/api/apis.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../../../../zego_live_stream_chat/live_page.dart';
import '../../../dash_board_page.dart';
import '../agora/audience.dart';
import '../constant/liveusercard.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LiveUser> liveUsers = [];
  User? currentUser ;
  bool isDeviceConnected = false;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  @override
  void initState() {
    super.initState();
    setupConnectivityListener();
    fetchLiveUsers();
    removeExistingUserIfNeeded();

    print('live users data------------${liveUsers}');

  }

  void setupConnectivityListener() {
    Connectivity().checkConnectivity().then((result) {
      isDeviceConnected = result != ConnectivityResult.none;
      setState(() {});
    });
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isDeviceConnected = result != ConnectivityResult.none;
      setState(() {});
    });
  }


  void fetchLiveUsers() {
    FirebaseFirestore.instance.collection("Liveusers").snapshots().listen((snapshot) {
      setState(() {
        liveUsers = snapshot.docs.map((doc) => LiveUser.fromDocument(doc)).toList();
        print('Live users loaded: $liveUsers');
      });
    });
  }



  Future<void> removeExistingUserIfNeeded() async {
    if (currentUser != null) {
      bool exists = (await FirebaseFirestore.instance.collection("Liveusers").doc(currentUser!.uid).get()).exists;
      if (exists) {
        await FirebaseFirestore.instance.collection("Liveusers").doc(currentUser!.uid).delete();
      }
    }
  }


  Future<void> goLive() async {
    if (!isDeviceConnected) {
      Get.snackbar("Error", "No internet connection", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Map<Permission, PermissionStatus> statuses = await [Permission.camera, Permission.microphone].request();
    if (statuses[Permission.camera]!.isGranted && statuses[Permission.microphone]!.isGranted) {
      String channelName = generateRandomString(8);

      /// Add live user to Firestore------
      await FirebaseFirestore.instance.collection("Liveusers").doc(user_uid).set({
        'username':currentUser?.displayName,
        'userimage': 'https://www.yiwubazaar.com/resources/assets/images/default-product.jpg',
        'channelname': channelName,
        'userid':currentUser?.uid,
      });

      if (ZegoUIKitPrebuiltLiveStreamingController().minimize.isMinimizing) {
        return;
      }

      jumpToLivePage(
        context,
        liveID:'12345',
        isHost: true,
      );


    } else {
      Get.snackbar("Permission Error", "Camera and Microphone permissions are required to go live",
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  String generateRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentUser=FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.offAll(() => const DashboardPage()),
          ),
          backgroundColor: Colors.redAccent,
          title: const Text("Live Users", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        body: Center(child: buildLiveUserList()),
        floatingActionButton: buildGoLiveButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildGoLiveButton() {
    return InkWell(
      onTap: goLive,
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
            Icon(Icons.video_call, size: 30),
            Text("Go Live", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget buildLiveUserList() {
    return ListView.builder(
      itemCount: liveUsers.length,
      itemBuilder: (context, index) {
        LiveUser liveUser = liveUsers[index];
        return buildLiveUserTile(liveUser);
      },
    );
  }

  // Widget buildLiveUserTile(LiveUser liveUser) {
  //   return Container(
  //     margin: const EdgeInsets.all(10),
  //     child: InkWell(
  //       child: LiveUserCard(
  //         broadcasterName: liveUser.userName,
  //         image: liveUser.image,
  //       ),
  //     ),
  //   );
  // }


  Widget buildLiveUserTile(LiveUser liveUser) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Get.to(() => const LivePage(liveID:'12345', isHost: false,));
        },
        child: LiveUserCard(
          broadcasterName: liveUser.userName,
          image: liveUser.image,
        ),
      ),
    );
  }


}

class LiveUser {
  final String userName;
  final String image;
  final String channelName;
  final String userId;

  LiveUser({
    required this.userName,
    required this.image,
    required this.channelName,
    required this.userId,
  });

  factory LiveUser.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return LiveUser(
      userName: data['username'] ?? 'Not found',
      image: data['userimage'] ?? "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
      channelName: data['channelname'],
      userId: data['userid'],
    );
  }
}

void jumpToLivePage(BuildContext context,
    {required String liveID, required bool isHost}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LivePage(liveID: liveID, isHost: isHost),
    ),
  );
}






