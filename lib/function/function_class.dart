import 'dart:ui';
import 'package:flutter/material.dart';

class CustomTextStyle {
  double? fontSize;

  static const TextStyle simpletext = TextStyle(fontSize: 56, fontWeight: FontWeight.w500, color: Appcolor.backgroundclr);

  static const TextStyle titleText = TextStyle(
    fontSize: 48,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    color: Appcolor.green,
  );

  static const TextStyle LoginText = TextStyle(
    fontSize: 28,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    color: Appcolor.LoginText,
  );

  static const TextStyle LogiText = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: Appcolor.backgroundclr);

  static const TextStyle Logitext = TextStyle(fontSize: 31, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: Appcolor.backgroundclr);

  static const TextStyle LogiF = TextStyle(fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: Appcolor.backgroundclr);

  static const TextStyle Log = TextStyle(fontSize: 28, fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: Appcolor.backgroundclr);

  static const TextStyle Lightsd = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStyle Lhom = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Appcolor.Red);

  static const TextStyle gree = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Appcolor.primery);

  static const TextStyle tx = TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: Appcolor.tx);

  static const TextStyle hl = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStylelig = TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Appcolor.daek);

  static const TextStyle Texthom = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle crd = TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: Appcolor.backgroundclr);

  static const TextStyle crdd = TextStyle(fontSize: 24, fontFamily: 'SF Pro', fontWeight: FontWeight.w500, color: Appcolor.backgroundclr);

  static const TextStyle black = TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.w600, color: Appcolor.daek);

  static const TextStyle blackLoc = TextStyle(fontSize: 22, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Appcolor.daek);

  static const TextStyle blacky = TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Appcolor.daek);

  static const TextStyle blackyc = TextStyle(fontSize: 11, fontFamily: 'Inter', fontWeight: FontWeight.w400, color: Appcolor.daek);

  static const TextStyle blacky5 = TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Appcolor.daek);

  static const TextStyle blackyyy = TextStyle(fontSize: 34, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: Appcolor.daek);

  static const TextStyle bolte = TextStyle(fontSize: 16, fontFamily: 'SF Pro', fontWeight: FontWeight.w700, color: Appcolor.white);

  static const TextStyle blacki = TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.w600, color: Appcolor.daek);

  static const TextStyle ote = TextStyle(fontSize: 16, fontFamily: 'SF Pro', fontWeight: FontWeight.w600, color: Appcolor.otPink);

  static const TextStyle chec = TextStyle(fontSize: 16, fontFamily: 'SF Pro', fontWeight: FontWeight.w400, color: Appcolor.white);

  static const TextStyle TextF = TextStyle(
    fontSize: 16, fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    // color: Appcolor.TextF,
  );

  static const TextStyle TextPink = TextStyle(
    fontSize: 22,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: Appcolor.Redpink,
  );
  static const TextStyle TextIPink = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: Appcolor.Redpink,
  );
  static const TextStyle Dak = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: Appcolor.daek,
  );

  static const TextStyle TextWPink = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: Appcolor.backgroundclr,
  );

  static const TextStyle PRW = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: Appcolor.backgroundclr,
  );

  static const TextStyle blac5 = TextStyle(fontSize: 24, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Appcolor.daek);

  static const TextStyle blackLocF = TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: Appcolor.daek);

  static const TextStyle Gry = TextStyle(fontSize: 16, fontFamily: 'Muslin', fontWeight: FontWeight.w400, color: Appcolor.backgroundclr);

  static const TextStyle GryBlc = TextStyle(fontSize: 16, fontFamily: 'Muslin', fontWeight: FontWeight.w400, color: Appcolor.black);

  static const TextStyle ggy = TextStyle(fontSize: 12, fontFamily: 'Muslin', fontWeight: FontWeight.w400, color: Appcolor.ggrry);
}

class Appcolor {
  static const primery = Color(0Xff23AA49);
  static const backgroundclr = Color(0XffFFFFFF);
  static const green = Color(0Xff115023);
  static const LoginText = Color(0Xff1A2128);
  static const white = Color(0Xff1A2128);
  static const black = Color(0Xff323755);
  static const Red = Color(0XffFF4242);
  static const Redpink = Color(0XffFB4967);
  static const tx = Color(0xff1c273114);
  static const crd = Color(0Xff2C444D);
  static const daek = Color(0Xff111111);
  static const otPink = Color(0XffFB4967);
  static const ggrry = Color(0Xff969696);
}
