import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

TextFormField primaryTextfield({
  required String hintText,
  required controller,
  var validator,
  int? maxLines,
  String? suffixIconn,
  bool? obscureText,
  VoidCallback? onTap,
  TextInputType? textInputType,
  bool? enabled,
  String? initialValue,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextFormField(
    enabled: enabled ?? true,
    // onTap: onTap,
    initialValue: initialValue,
    keyboardType: textInputType ?? TextInputType.text,
    style: const TextStyle(color: Colors.black),
    inputFormatters: inputFormatters ?? null,
    //
    // Apply the custom formatter
    maxLines: maxLines ?? 1,
    // autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,

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
      hintStyle: TextStyle(color: Colors.black.withOpacity(.40), fontWeight: FontWeight.bold, fontSize: 14),
      // prefixIcon: Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

      suffixIcon: suffixIconn == null
          ? const SizedBox(
              height: 1,
              width: 1,
            )
          : IconButton(
              onPressed: onTap,
              icon: SvgPicture.asset(
                suffixIconn,
                fit: BoxFit.none,
                color: Colors.black54,
              ),
            ),
    ),

    obscureText: obscureText ?? false,
    // validator: validator,
  );
}
