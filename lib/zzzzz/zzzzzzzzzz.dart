import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green.withOpacity(0.2),
        body: Center(
          child: SizedBox(
            child: Stack(
              children: [
                SvgPicture.asset(
                  "assets/images/bg_profile.svg",
                  width: 100,
                  height: 100,
                ),
                Positioned(
                  top: 8.5,
                  left: 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "https://fastly.picsum.photos/id/349/200/300.jpg?hmac=gEjHZbjuKtdD2GOM-qQtuaA95TCvDUs6iVvKraQ94nU",
                      width: 70,
                      height: 70,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
