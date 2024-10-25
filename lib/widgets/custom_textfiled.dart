import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustumTextField extends StatelessWidget {
  var validator;
  String hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;

  TextEditingController controller;
  CustumTextField({super.key,
    required this.controller ,
    required this.validator,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      style: TextStyle(color: Colors.white),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
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
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.white,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,cursorColor: Colors.white,
    );
  }
}

// class CustumProfileTextField extends StatelessWidget {
//   var validator;
//   String hintText;
//   bool ? obscureText;
//   //String prefixIcon;
//   String? suffixIconn;
//   VoidCallback ? onTap;
//
//   TextEditingController controller;
//   CustumProfileTextField({super.key,
//     required this.controller ,
//     required this.validator,
//     // required this.prefixIcon,
//     this.suffixIconn,
//     this.obscureText,
//     this.onTap,
//     required this.hintText});
//
//   @override
//   Widget build(BuildContext context) {
//     return   TextFormField(
//       style: TextStyle(color: Colors.black),
//       // autovalidateMode: AutovalidateMode.onUserInteraction,
//       controller: controller,
//
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.all(10),
//         // filled: true,
//         // fillColor: Colors.grey.withOpacity(.25),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               width: 1,color:Colors.black12,
//             )),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               width: 1,color: Colors.black12,
//             )),
//         errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               width: 1,color: Colors.red,
//             )),
//         focusedErrorBorder:  OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//               width: 1,color: Colors.black,
//             )
//         ),
//
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
//         //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),
//
//         suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
//           onPressed: onTap,
//           icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.black,),
//         ),),
//       obscureText: obscureText ??  false,
//       validator: validator,
//     );
//   }
//   showbottombar(context){
//     return showBottomSheet(context: context, builder: (context) {
//       return Container();
//     },);
//   }
// }


class CustumProfileTextField extends StatelessWidget {
  var validator;
  String hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;

  TextEditingController controller;
  CustumProfileTextField({super.key,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    required this.hintText});

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      style: TextStyle(color: Colors.black),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color:Colors.black12,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.black12,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.red,
            )),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.black,
            )
        ),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.black,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,
    );
  }
  showbottombar(context){
    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}


class editProfileTextField extends StatelessWidget {
  var validator;
  String hintText;
  bool ? obscureText;
  //String prefixIcon;
  String? suffixIconn;
  VoidCallback ? onTap;
  TextEditingController controller;
  TextInputType ? textInputType;

  editProfileTextField({super.key,
    required this.hintText,
    required this.controller ,
    required this.validator,
    // required this.prefixIcon,
    this.suffixIconn,
    this.obscureText,
    this.onTap,
    this.textInputType


  });

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      onTap: onTap,
      keyboardType: textInputType ?? TextInputType.text,
      style: TextStyle(color: Colors.black),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(.25),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color:Colors.black12,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.black12,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.red,
            )),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,color: Colors.black,
            )
        ),

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(.55)),
        //  prefixIcon:Container(child: SvgPicture.asset('$prefixIcon',fit: BoxFit.none,)),

        suffixIcon: suffixIconn==null ? SizedBox(height: 1,width: 1,) : IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset('$suffixIconn',fit: BoxFit.none,color: Colors.black,),
        ),),
      obscureText: obscureText ??  false,
      validator: validator,
    );
  }
  showbottombar(context){
    return showBottomSheet(context: context, builder: (context) {
      return Container();
    },);
  }
}





// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});
//
//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }
//
// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   final TextEditingController colorController = TextEditingController();
//   ColorLabel? selectedColor;
//   IconLabel? selectedIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     // final List<DropdownMenuEntry<ColorLabel>> colorEntries =
//     // <DropdownMenuEntry<ColorLabel>>[];
//     // for (final ColorLabel color in ColorLabel.values) {
//     //   colorEntries.add(
//     //     DropdownMenuEntry<ColorLabel>(
//     //         value: color, label: color.label, enabled: color.label != 'Grey'),
//     //   );
//     // }
//     //
//     // final List<DropdownMenuEntry<IconLabel>> iconEntries =
//     // <DropdownMenuEntry<IconLabel>>[];
//     // for (final IconLabel icon in IconLabel.values) {
//     //   iconEntries
//     //       .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
//     // }
//
//     return Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     DropdownMenu<ColorLabel>(
//                       initialSelection: ColorLabel.green,
//                       controller: colorController,
//                       hintText:  'Gender',
//                       dropdownMenuEntries: [
//                         DropdownMenuEntry(value: "null"
//
//                       )],
//                       onSelected: (ColorLabel? color) {
//                         setState(() {
//                           selectedColor = color;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//             ],
//           );
//
//
//   }
// }
//
// enum ColorLabel {
//   blue('Blue', Colors.blue),
//   pink('Pink', Colors.pink),
//   green('Green', Colors.green),
//   yellow('Yellow', Colors.yellow),
//   grey('Grey', Colors.grey);
//
//   const ColorLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }
//
// enum IconLabel {
//   smile('Smile', Icons.sentiment_satisfied_outlined),
//   cloud(
//     'Cloud',
//     Icons.cloud_outlined,
//   ),
//   brush('Brush', Icons.brush_outlined),
//   heart('Heart', Icons.favorite);
//
//   const IconLabel(this.label, this.icon);
//   final String label;
//   final IconData icon;
// }
