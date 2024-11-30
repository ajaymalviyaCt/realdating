//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustumForgetTextField extends StatelessWidget {
  var validator;
  String hintText;
  bool? obscureText;

  //String prefixIcon;
  String? suffixIconn;
  VoidCallback? onTap;

  TextEditingController controller;

  CustumForgetTextField(
      {super.key,
      required this.controller,
      required this.validator,
      // required this.prefixIcon,
      this.suffixIconn,
      this.obscureText,
      this.onTap,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(.15),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Colors.black,
            )),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black12),
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn == null
            ? SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  '$suffixIconn',
                  fit: BoxFit.none,
                  color: Colors.white,
                ),
              ),
      ),
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }

  showbottombar(context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }
}
