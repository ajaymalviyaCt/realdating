import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realdating/controllers/forgetpassword.dart';
import 'package:realdating/pages/sign_up_page/signup.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../custom_iteam/customtextfield.dart';
import '../../../validation/validation.dart';
import '../../sign_up_page/signup_controller.dart';
import 'login_controller.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  LoginController loginController = Get.put(LoginController());
  SignUpController signUpController = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/Background 1.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 220.h,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 210.h,
                      ),
                      Center(child: Image.asset('assets/images/AppIcon-120px-40pt@3x 1.png')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      customTextCommon(
                        text: "Welcome to Login !",
                        fSize: 28,
                        fWeight: FontWeight.w600,
                        lineHeight: 31,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      customTextCommon(
                        text: "Sign in to continue",
                        fSize: 17,
                        fWeight: FontWeight.w400,
                        lineHeight: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustumTextField(
                        controller: loginController.emailController,
                        validator: validateEmailField,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Obx(
                        () => CustumTextField(
                          onTap: () {
                            loginController.seePassword.value = !loginController.seePassword.value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: loginController.passwordController,
                          validator: validatePassword,
                          suffixIconn: loginController.seePassword == true ? 'assets/icons/Eye Slash.svg' : 'assets/icons/eye.svg',
                          hintText: 'Password',
                          obscureText: loginController.seePassword.value,
                        ),
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      Obx(
                        () => customPrimaryBtn(
                          btnText: "Sign In",
                          btnclr: Colors.white,
                          btntextclr: Colors.black,
                          loading: loginController.isLoadig.value,
                          btnFun: () {
                            if (_formKey.currentState!.validate()) {
                              loginController.loginWithEmail();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      InkWell(
                        onTap: () {
                          loginController.emailController.clear();
                          loginController.passwordController.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword()));
                        },
                        child: Center(
                            child: customTextCommon(
                          text: "Forgot Password?",
                          fSize: 17,
                          fWeight: FontWeight.w600,
                          lineHeight: 17,
                          color: Colors.white,
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          signUpController.clearData();
                          loginController.emailController.clear();
                          loginController.passwordController.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), color: Colors.transparent, border: Border.all(color: Colors.white, width: 1)),
                          child: Center(
                            child: Text('Don’t have an user account? Sign Up',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Aboshi', color: HexColor('#FFFFFF'))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
