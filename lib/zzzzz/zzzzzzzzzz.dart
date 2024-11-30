import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
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
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/images/bg_profile.svg",
                width: 80,
                height: 80,
              ),
              Positioned(
                top: 6,
                left: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "https://fastly.picsum.photos/id/349/200/300.jpg?hmac=gEjHZbjuKtdD2GOM-qQtuaA95TCvDUs6iVvKraQ94nU",
                    width: 57,
                    height: 57,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
