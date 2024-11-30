import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/pages/sign_up_page/signup_controller.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../custom_iteam/customtextfield.dart';
import '../../function/function_class.dart';
import '../../validation/validation.dart';
import '../a_frist_pages/login_page/login.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  SignUpController signUpController = Get.put(SignUpController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Form(
          // key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Background 1.png",
                    ),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220.h,
                    decoration: const BoxDecoration(
                        // color: Colors.white.withOpacity(.30),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 210.h,
                          decoration: const BoxDecoration(
                              //  color: Colors.white,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                        ),
                        Center(child: Image.asset('assets/images/AppIcon-120px-40pt@3x 1.png')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text(
                        'Welcome!',
                        style: CustomTextStyle.Logitext,
                      ),
                      const Text(
                        'Sign up to continue',
                        style: CustomTextStyle.crd,
                      ),
                      const SizedBox(height: 20),
                      CustumTextField(controller: signUpController.usernameController, validator: validateName, hintText: 'Unique User Name '),
                      const SizedBox(height: 15),
                      CustumTextField(controller: signUpController.firstNameController, validator: validateName, hintText: 'First Name '),
                      const SizedBox(height: 15),
                      CustumTextField(controller: signUpController.lastNameController, validator: validateName, hintText: 'Last Name '),
                      const SizedBox(height: 15),
                      CustumTextField(
                        maxLength: 15,
                        keyboardType: TextInputType.phone,
                        controller: signUpController.phonenoController,
                        validator: validateMobile,
                        hintText: 'Phone Number',
                      ),
                      const SizedBox(height: 15),
                      CustumTextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: signUpController.emailController,
                        validator: validateEmailField,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => CustumTextField(
                          keyboardType: TextInputType.text,
                          onTap: () {
                            signUpController.seePassword.value = !signUpController.seePassword.value;
                          },
                          controller: signUpController.passwordController,
                          validator: validatePassword,
                          suffixIconn: signUpController.seePassword == true ? 'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                          hintText: 'Password',
                          obscureText: signUpController.seePassword.value,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => CustumTextField(
                          keyboardType: TextInputType.text,
                          onTap: () {
                            signUpController.seePassword1.value = !signUpController.seePassword1.value;
                          },
                          controller: signUpController.confirmpasswordController,
                          validator: validatePassword,
                          suffixIconn: signUpController.seePassword1 == true ? 'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                          hintText: 'Confirm Password',
                          obscureText: signUpController.seePassword1.value,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Obx(
                        () => customPrimaryBtn(
                            btnText: "Sign Up",
                            btnFun: () {
                              if (signUpController.passwordController.value.text == signUpController.confirmpasswordController.value.text) {
                                /* if (_formKey.currentState!.validate()) {*/
                                signUpController.signUpfunction();
                                // }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "password and confirm password doesn't match",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            btnclr: Colors.white,
                            btntextclr: Colors.black,
                            loading: signUpController.isLoadig.value),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreenPage()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), color: Colors.transparent, border: Border.all(color: Colors.white, width: 0.5)),
                          child: Center(
                            child: Text('Already have an account? Sign In',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: HexColor('#FFFFFF'))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
