import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realdating/welcome_screen/splashscreens.dart';

import 'firebase_options.dart';
import 'messaing_service/messaging_service.dart';

late Size mq;
final navigatorKey = GlobalKey<NavigatorState>();
List<CameraDescription>? cameras;
final Logger kLogger = Logger();

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    cameras = await availableCameras();

    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print("Got a message in foreground");
      if (message.notification != null) {
        MessagingService.showSimpleNotification(title: message.notification!.title!, body: message.notification!.body!, payload: payloadData);
      }
    });

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

// MyApp widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> didChangeAppLifeCycle(AppLifecycleState state) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      switch (state) {
        case AppLifecycleState.detached:
          checkExist(user);
          break;
        case AppLifecycleState.resumed:
          // TODO: Handle this case.
          break;
        case AppLifecycleState.inactive:
          // TODO: Handle this case.
          break;
        case AppLifecycleState.paused:
          // TODO: Handle this case.
          break;
        // case AppLifecycleState.paused:
        case AppLifecycleState.hidden:
        // TODO: Handle this case.
      }
    }
  }

  void checkExist(User? user) async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance.collection("Liveusers").doc(user!.uid).get().then((doc) {
        exist = doc.exists;
      });
      if (exist) {
        FirebaseFirestore.instance.collection("Liveusers").doc(user.uid).delete();
      }
    } catch (e) {
      // Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final HomePageUserController postsC = Get.put(HomePageUserController());

    mq = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return ScreenUtilInit(
      designSize: const Size(346.97, 750.79),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(

          // routes: {'/notification': (context) =>  MyAllDatesPage()},
          debugShowCheckedModeBanner: false,
          title: 'real Dating',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            useMaterial3: true,
          ),
          home: const SplashPage(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
