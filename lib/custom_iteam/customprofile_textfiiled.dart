import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustumProfileTextField1 extends StatelessWidget {
  var validator;
  String hintText;
  String? initialText;
  bool? obscureText;

  //String prefixIcon;
  String? suffixIconn;
  VoidCallback? onTap;
  int? maxlenght;
  TextInputType? keyboardType;
  Function(String)? onChanged;
  TextEditingController controller;
  final int? maxLine;

  CustumProfileTextField1(
      {super.key,
      required this.controller,
      required this.validator,
      // required this.prefixIcon,
      this.suffixIconn,
      this.obscureText,
      this.onTap,
      required this.hintText,
      this.onChanged,
      this.initialText,
      this.maxlenght,
      this.keyboardType,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      keyboardType: keyboardType ?? TextInputType.number,

      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')), // Allow numbers with up to 2 decimals
      // ],
      style: const TextStyle(color: Colors.black),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      initialValue: initialText,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            )),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  '$suffixIconn',
                  fit: BoxFit.none,
                  color: Colors.black,
                ),
              ),
      ),
      obscureText: obscureText ?? false,
      validator: validator,

      maxLength: maxlenght,
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

class CustumProfileAgeTextField1 extends StatelessWidget {
  var validator;
  String hintText;
  bool? obscureText;

  //String prefixIcon;
  String? suffixIconn;
  VoidCallback? onTap;

  TextEditingController controller;

  CustumProfileAgeTextField1(
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
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.black),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black12,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            )),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn == null
            ? const SizedBox(
                height: 1,
                width: 1,
              )
            : IconButton(
                onPressed: onTap,
                icon: SvgPicture.asset(
                  '$suffixIconn',
                  fit: BoxFit.none,
                  color: Colors.black,
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

class CustumDescriotionTextField1 extends StatelessWidget {
  var validator;
  String hintText;
  bool? obscureText;

  //String prefixIcon;
  String? suffixIconn;
  VoidCallback? onTap;

  TextEditingController controller;

  CustumDescriotionTextField1(
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
    return SizedBox(
      height: 133,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          // filled: true,
          // fillColor: Colors.grey.withOpacity(.25),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black12,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black12,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.black,
              )),

          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
          //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

          suffixIcon: suffixIconn == null
              ? const SizedBox(
                  height: 1,
                  width: 1,
                )
              : IconButton(
                  onPressed: onTap,
                  icon: SvgPicture.asset(
                    '$suffixIconn',
                    fit: BoxFit.none,
                    color: Colors.black,
                  ),
                ),
        ),
        obscureText: obscureText ?? false,
        validator: validator,
      ),
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
