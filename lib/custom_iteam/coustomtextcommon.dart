import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextC extends StatelessWidget {
  String text;
  String? centertext;
  double fSize;
  FontWeight fWeight;
  double lineHeight;
  double? letterSpacing;
  Color? color;
  int? fweight;

  customTextC({
    super.key,
    required this.text,
    this.centertext,
    required this.fSize,
    required this.fWeight,
    required this.lineHeight,
    this.color,
    this.letterSpacing,
    this.fweight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fSize,
        fontWeight: fWeight ?? FontWeight.bold,
        height: lineHeight / fSize,
        // This is equivalent to line-height in CSS
        letterSpacing: letterSpacing ?? 0.0,
        color: color ?? Colors.black,
      ),
    );
  }
}
