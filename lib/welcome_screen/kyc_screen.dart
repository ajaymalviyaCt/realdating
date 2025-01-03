import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../function/function_class.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset('assets/icons/btn.svg'),
        ),
        title: const Text(
          'Face recognize',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
              child: DottedBorder(
                borderType: BorderType.Oval,
                color: HexColor('#FB4967'),
                dashPattern: const [10, 5, 10, 5, 10, 5],
                child: const ClipOval(
                  child: SizedBox(
                    height: 180,
                    width: 160,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.15),
                    border: Border.all(
                      color: HexColor('#FB4967'),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(' ID Proof                                                      ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: HexColor('#000000'))),
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: DottedBorder(
                dashPattern: const [10, 5, 10, 5, 10, 5],
                strokeWidth: 1,
                radius: const Radius.circular(10),
                color: HexColor('#FB4967'),
                child: Container(
                  height: 141,
                  width: 350,
                  decoration: const BoxDecoration(
                      //  borderRadius: BorderRadius.circular(10)
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/file-plus.svg'),
                      const Center(child: Text('Upload document here')),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(35)),
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: const Center(
                  child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
