import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../controllers/forgetpassword.dart';
import '../../../custom_iteam/customtextfield.dart';
import '../../../validation/validation.dart';
import '../../../widgets/custom_buttons.dart';
import '../../../widgets/custom_text_styles.dart';
import '../buisness_signup/buisness_signup.dart';
import '../buisness_signup/buisness_signupcontroller.dart';
import 'buisness_logincontroller.dart';

class BuisnessLogin extends StatefulWidget {
  const BuisnessLogin({super.key});

  @override
  State<BuisnessLogin> createState() => _BuisnessLoginState();
}

class _BuisnessLoginState extends State<BuisnessLogin> {
  BuisnessLoginController buissnesloginController =
      Get.put(BuisnessLoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BuisnessSignUpController buisbnesssignUpController =
  Get.put(BuisnessSignUpController());
  Future<bool> _onWillPop() async {return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Background 1.png",
                ),
                fit: BoxFit.fill)),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220.h,
                  child: Stack(
                    children: [
                      Center(
                          child:
                              //SvgPicture.asset('assets/icons/AppIcon-120px-40pt@3x 1.svg'),
                              Image.asset(
                                  'assets/images/AppIcon-120px-40pt@3x 1.png')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        customTextCommon(
                          text: "Welcome to Business Login !",
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
                          controller:
                              buissnesloginController.buisnessemailController,
                          validator: validateEmailField,
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Obx(
                          () => CustumTextField(
                            onTap: () {
                              buissnesloginController.seePassword.value =
                                  !buissnesloginController.seePassword.value;
                            },
                            controller: buissnesloginController
                                .buisnesspasswordController,
                            validator: validatePassword,
                            suffixIconn:
                                buissnesloginController.seePassword == true
                                    ? 'assets/icons/Eye Slash.svg'
                                    : 'assets/icons/eye.svg',
                            hintText: 'Password',
                            obscureText:
                                buissnesloginController.seePassword.value,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        Obx(
                          () => customPrimaryBtn(
                            btnText: "Sign In",
                            btnFun: () {

                              if (formKey.currentState!.validate()) {
                                buissnesloginController.BussinessloginwithEmail();
                              }
                              setState(() {});
                            },
                            btnclr: Colors.white,
                            btntextclr: Colors.black,
                            loading: buissnesloginController.isLoadigLogin.value,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        InkWell(
                          onTap: () {
                            buissnesloginController.buisnesspasswordController.clear();
                            buissnesloginController.buisnessemailController.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword(business: 1)));
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
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            buissnesloginController.buisnessemailController.clear();
                            buissnesloginController.buisnesspasswordController.clear();
                            buisbnesssignUpController.clearDataUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BuisnessSignUp()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),

                            // height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.white, width: 1)),
                            child: Center(
                              child: Text('Don’t have a business account? Sign Up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Aboshi',
                                      color: HexColor('#FFFFFF'))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
