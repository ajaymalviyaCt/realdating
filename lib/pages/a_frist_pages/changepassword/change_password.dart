
import 'package:flutter/material.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_textfiled.dart';
import 'chanage_password_controller.dart';

class ChangePasswordPagePage extends StatefulWidget {
  const ChangePasswordPagePage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPagePage> createState() => _ChangePasswordPagePageState();
}

class _ChangePasswordPagePageState extends State<ChangePasswordPagePage> {


  ChangePasswordController cpController =Get.put(ChangePasswordController());


  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppbar("Change Password", context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            customTextCommon(text: " Old Password", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
            SizedBox(
              height: 48,
              child: CustumProfileTextField(
                onTap: (){
                  print("OP");
                  setState(() {
                    cpController.OldPassowrdsee.value = !cpController.OldPassowrdsee.value;
                  });
                  },
                controller: cpController.OldPassword,
                validator: null,
                obscureText: cpController.OldPassowrdsee.value,
                // prefixIcon: 'assets/icons/Lock.svg',
                suffixIconn: cpController.OldPassowrdsee.value==true ?  'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                hintText: '',),
            ),

            SizedBox(height: 10,),
            customTextCommon(text: " New Password", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
            SizedBox(
              height: 48,
              child: CustumProfileTextField(
                onTap: (){
                  print("np");
                  setState(() {
                    cpController.NewPassowrdsee.value =!cpController.NewPassowrdsee.value;
                  });
                },
                controller: cpController.NPassword,
                validator: null,
                obscureText: cpController.NewPassowrdsee.value,
                suffixIconn: cpController.NewPassowrdsee.value==true ?  'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                hintText: '',),
            ),

            SizedBox(height: 10,),
            customTextCommon(text: " Confirm Password", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
            SizedBox(
              height: 48,
              child: CustumProfileTextField(
                onTap: (){
                  print("cp");
                  setState(() {
                   cpController.ConfirmPassowrdsee.value  =! cpController.ConfirmPassowrdsee.value ;
                  });
                },
                controller: cpController.CPassword,
                validator: null,
                obscureText: cpController.ConfirmPassowrdsee.value,
                suffixIconn: cpController.ConfirmPassowrdsee.value==true ?  'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                hintText: '',),
            ),
            Spacer(),

            Obx(()=> customPrimaryBtn(btnText: "Save", btnFun: (){cpController.loginwithEmail();},loading: cpController.isLoadig.value,)),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
