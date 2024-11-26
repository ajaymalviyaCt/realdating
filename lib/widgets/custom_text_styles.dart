import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:realdating/widgets/size_utils.dart';
import '../consts/app_colors.dart';
Text textBold(String data, context, double  fSize,[Color? tcolor,]){
  return Text(data,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize:fSize,
        fontFamily: "bold",
        color: tcolor ?? colors.white,
        letterSpacing: .78
    ),
  );
}
class AppTextStyle {
  static const TextStyle selectDateTextStyle = TextStyle(
    color: Color(0xFF111111),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    height: 0,
  );
}

Text textsemiBold(String data, context, double fSize,[Color? tcolor,]){
  return Text(data,
    style: TextStyle(
        fontSize: fSize ?? 14 ,
        fontFamily: "sbold",
        color:tcolor ?? colors.white,
        letterSpacing: .78
    ),);
}
Text textMedium(String data, context, double  fSize,[Color? tcolor,]){
  return Text(data,
    textAlign: TextAlign.center,
    style: TextStyle(

        fontSize: fSize,
        fontFamily: "medium",
        color: tcolor ?? colors.white,
        letterSpacing: .58

    ),);
}
Text secTitleText(String data, context, double size,[Color ? tcolor] ){
  return Text(data,
    style:  TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: tcolor ?? colors.white,      //Theme.of(context).colorScheme.fontColor,
    ),);
}










class customTextCommon extends StatelessWidget {
  String text;
  String ? centertext;
  double fSize;
  FontWeight fWeight;
  double lineHeight;
  double ? letterSpacing;
  Color ? color;
  int ? fweight;
  int ? maxLine;
  TextOverflow? textOverflow;
  customTextCommon({super.key,
    required this.text,
    this.centertext,
    required this.fSize,
    required this.fWeight,
    required this.lineHeight,
    this.color,
    this.letterSpacing,
     this.fweight,
     this.maxLine,
    this.textOverflow

  });

  @override
  Widget build(BuildContext context) {
    return  Text("$text",style: TextStyle(
      fontFamily: 'Inter',
      overflow: textOverflow,
      fontSize: fSize.adaptSize,
      fontWeight: fWeight ??  FontWeight.bold,
      height:  lineHeight/fSize, // This is equivalent to line-height in CSS
      letterSpacing: letterSpacing ?? 0.0 ,
      color:  color ?? Colors.black,
    ),maxLines: maxLine,);
  }
}