import 'dart:async';
import 'dart:math';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realdating/chat/api/apis.dart';
import '../../../dash_board_page.dart';
import '../agora/audience.dart';
import '../agora/host.dart';
import '../constant/liveusercard.dart';
   // Host screen import

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Live> liveUsers = [];
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isDeviceConnected = false;
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  @override
  void initState() {
    super.initState();
    checkInitialConnectivity();
    listenToConnectivityChanges();
    fetchLiveUsers();
    removeExistingUserIfNeeded();
  }

  void checkInitialConnectivity() async {
    isDeviceConnected = await Connectivity().checkConnectivity() != ConnectivityResult.none;
    setState(() {});
  }

  void listenToConnectivityChanges() {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isDeviceConnected = result != ConnectivityResult.none;
      setState(() {});
    });
  }

  void fetchLiveUsers() {
    FirebaseFirestore.instance.collection("Liveusers").snapshots().listen((snapshot) {
      setState(() {
        liveUsers = snapshot.docs.map((doc) => Live.fromDocument(doc)).toList();
      });
    });
  }

  Future<void> removeExistingUserIfNeeded() async {
    try {
      bool exists = (await FirebaseFirestore.instance.collection("Liveusers").doc(currentUser!.uid).get()).exists;
      if (exists) {
        await FirebaseFirestore.instance.collection("Liveusers").doc(currentUser!.uid).delete();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
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
      Get.offAll(() => Host(channelName: channelName, userId:user_uid));
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
        Live liveUser = liveUsers[index];
        return buildLiveUserTile(liveUser);
      },
    );
  }

  Widget buildLiveUserTile(Live liveUser) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Get.offAll(() => Audience(channelName: liveUser.channelName, userId: liveUser.userId)),
        child: LiveUserCard(
          broadcasterName: liveUser.username,
          image: liveUser.image,
        ),
      ),
    );
  }
}

class Live {
  final String username;
  final String image;
  final String channelName;
  final String userId;

  Live({required this.username, required this.image, required this.channelName, required this.userId});

  factory Live.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Live(
      username: data['username'],
      image: data['userimage'] ?? "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg",
      channelName: data['channelname'],
      userId: data['userid'],
    );
  }
}
