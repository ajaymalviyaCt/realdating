//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../custom_iteam/customforgetpassword.dart';
// import '../function/function_class.dart';
// import '../pages/gender/gender.dart';
//
// class CreatePassword extends StatefulWidget {
//   const CreatePassword({Key? key}) : super(key: key);
//
//   @override
//   State<CreatePassword> createState() => _CreatePasswordState();
// }
//
// class _CreatePasswordState extends State<CreatePassword> {
//
//   TextEditingController NewPasswordController = TextEditingController();
//   TextEditingController ConfirmPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         leading:Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 20),
//           child: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: SvgPicture.asset('assets/icons/Vector (Stroke).svg',)),
//         ) ,
//       ),
//       body:Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 30,horizontal:120),
//             child: Image(image: AssetImage('assets/images/AppIcon-120px-40pt@3x 1.png')),
//           ),
//           SizedBox(height: 23),
//           Text('Create new  password',style: CustomTextStyle.black,),
//
//           Padding(padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 50),
//             child: CustumForgetTextField(
//               controller: NewPasswordController,
//               validator: null,
//               hintText: 'New Pasword',),
//           ),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 20,),
//             child: CustumForgetTextField(
//               controller: ConfirmPasswordController,
//               validator: null,
//               hintText: 'Confirm  Pasword',),
//           ),
//
//           Padding(
//             padding:  EdgeInsets.symmetric(vertical: 50,horizontal: 20),
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => GenderScreen()));
//               },
//               child: Container(
//                 decoration: BoxDecoration(color:Colors.redAccent,
//                     borderRadius: BorderRadius.circular(35)),
//                 width: MediaQuery.of(context).size.width,
//                 height: 56,
//                 child: Center(
//                   child: Text('Send',style:TextStyle(
//                       fontSize:18,fontWeight: FontWeight.w400,fontFamily: 'Aboshi',
//                       color: Colors.white ),),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ) ,
//     );
//   }
// }
