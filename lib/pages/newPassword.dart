import 'package:flutter/material.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';

import '../../widgets/custom_textfiled.dart';
import 'a_frist_pages/changepassword/chanage_password_controller.dart';

class NewPasswordPage extends StatefulWidget {
  String email;

  NewPasswordPage({super.key, required this.email});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  ChangePasswordController cpController = Get.put(ChangePasswordController());

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppbar("Change Password", context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            customTextCommon(text: " New Password", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
            SizedBox(
              height: 48,
              child: CustumProfileTextField(
                onTap: () {
                  print("np");
                  setState(() {
                    cpController.NewPassowrdsee.value = !cpController.NewPassowrdsee.value;
                  });
                },
                controller: cpController.NPassword,
                validator: null,
                obscureText: cpController.NewPassowrdsee.value,
                suffixIconn: cpController.NewPassowrdsee.value == true ? 'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                hintText: '',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            customTextCommon(text: " Confirm Password", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
            SizedBox(
              height: 48,
              child: CustumProfileTextField(
                onTap: () {
                  print("cp");
                  setState(() {
                    cpController.ConfirmPassowrdsee.value = !cpController.ConfirmPassowrdsee.value;
                  });
                },
                controller: cpController.CPassword,
                validator: null,
                obscureText: cpController.ConfirmPassowrdsee.value,
                suffixIconn: cpController.ConfirmPassowrdsee.value == true ? 'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                hintText: '',
              ),
            ),
            const Spacer(),
            Obx(() => customPrimaryBtn(
                  btnText: "Save",
                  btnFun: () {
                    cpController.newPasswordApi(widget.email);
                  },
                  loading: cpController.isLoadig.value,
                )),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
