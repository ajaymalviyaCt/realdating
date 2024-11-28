import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustumTextField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final String? suffixIconn;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;

  CustumTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.suffixIconn,
    this.keyboardType,
    this.obscureText,
    this.onTap,
    this.maxLength,
    required this.hintText,
    this.onChange, // Added onChange property
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      onChanged: onChange,
      maxLength: maxLength ?? 200,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        filled: true,
        fillColor: Colors.white.withOpacity(.15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        errorStyle: const TextStyle(color: Colors.white),
        suffixIcon: suffixIconn == null
            ? const SizedBox(height: 1, width: 1)
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
      cursorColor: Colors.white,
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


class CustumNumberField extends StatelessWidget {
  var validator;
  String hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;
  TextInputType ? keyboardType ;
  int ? maxLength ;
  TextEditingController controller;
  CustumNumberField({super.key,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.keyboardType,
    this.obscureText,
    this.onTap,
    this.maxLength,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(

      style: TextStyle(color: Colors.white),
      maxLength: maxLength ?? 200,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType:keyboardType ?? TextInputType.number,

      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),  //
        filled: true,
        fillColor: Colors.white.withOpacity(.15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color:Colors.white,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )
        ),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        errorStyle:TextStyle(color: Colors.white) ,
        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.white,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,cursorColor: Colors.white,
    );
  }
  showbottombar(context){

    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}




class CustumSelectCategoryField extends StatelessWidget {
  var validator;
  String ? hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;

  TextEditingController controller;
  CustumSelectCategoryField({super.key,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      style: TextStyle(color: Colors.white),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),  //
        filled: true,
        fillColor: Colors.white.withOpacity(.15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color:Colors.white,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )
        ),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        errorStyle:TextStyle(color: Colors.white) ,
        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.white,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,cursorColor: Colors.white,
    );
  }
  showbottombar(context){

    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}

class CustumCITYField extends StatelessWidget {
  var validator;
  String ? hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;

  TextEditingController controller;
  CustumCITYField({super.key,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      style: TextStyle(color: Colors.white),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),  //
        filled: true,
        fillColor: Colors.white.withOpacity(.15),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color:Colors.white,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )
        ),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        errorStyle:TextStyle(color: Colors.white) ,
        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.white,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,cursorColor: Colors.white,
    );
  }
  showbottombar(context){

    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}

class CustumCountryTextField extends StatelessWidget {
  var validator;
  String ? hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;

  TextEditingController controller;
  CustumCountryTextField({super.key,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return     IntlPhoneField(
      flagsButtonPadding: const EdgeInsets.all(8),
      dropdownIconPosition: IconPosition.trailing,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),  //
        filled: true,
        fillColor:Colors.white12,
        // Colors.white.withOpacity(.15),
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color:Colors.white,
            )
        ),

        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),

        errorBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )),

        focusedErrorBorder:  OutlineInputBorder(
          //  borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,color: Colors.white,
            )
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        print(phone.completeNumber);

      },
    );
  }
  showbottombar(context){

    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}