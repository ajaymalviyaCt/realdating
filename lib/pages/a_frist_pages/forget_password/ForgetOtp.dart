
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../function/function_class.dart';
import 'forgetPass_control.dart';

class ForgetOtp extends StatefulWidget {
  String? email;
  ForgetOtp({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgetOtp> createState() => _ForgetOtpState();
}

class _ForgetOtpState extends State<ForgetOtp> {

  ForgetOtpController otpController=Get.put(ForgetOtpController());

  String otp = '';


  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    print("rahul"+"${widget.email}");
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading:Padding(
          padding:  const EdgeInsets.symmetric(horizontal:8 ,vertical: 5),
          child: InkWell(
              onTap: (){
                Get.back();
              },
              child: SvgPicture.asset('assets/icons/btn.svg',)),
        ),
      ),
      body: Form(
        // key: _formKey,
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                customTextCommon(text: "Type the verification code", fSize: 18, fWeight: FontWeight.w500, lineHeight: 20),
                customTextCommon(text: " we’ve sent you", fSize: 18, fWeight: FontWeight.w500, lineHeight: 20),
                SizedBox(height: 140.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    enablePinAutofill: true,
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                        print("$value");
                      });
                    },
                    pinTheme: PinTheme(
                      activeColor: Colors.redAccent,
                      selectedColor: Colors.redAccent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15),
                      fieldHeight: 65,
                      fieldWidth: 62,
                      activeFillColor: Colors.purpleAccent,
                      inactiveFillColor: Colors.grey,
                      selectedFillColor: Colors.yellowAccent,
                    ),
                    animationType: AnimationType.fade,
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    controller: otpController.Codecontroller,
                  ),
                ),

                SizedBox(height: 20),
                Text('Send again',style: CustomTextStyle.ote,),
                // TextButton(onPressed: (){
                //   OTPaccount();
                //   print("sdfghfd");
                //   print(Codecontroller.value.text);
                // }, child: Text("sumbit")),
                Spacer(),
                customPrimaryBtn(btnText: "Sumbit", btnFun: (){
                  print(otpController.Codecontroller.value.text);
                  otpController.otpverify("${widget.email}");
                }),
                SizedBox(height: 30,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}


