import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../function/function_class.dart';
import 'otp_controller.dart';

class OtpPage extends StatefulWidget {
  String number;
  String otp;
  OtpPage(  {Key? key, required this.number,required this.otp}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpController otpController = Get.put(OtpController());

  String otp = '';

  final _formKey = GlobalKey<FormState>();

  // Future<otp_verify> OTPaccount() async {
  //   check().then((intenet) {
  //     if (intenet != null && intenet) {
  //       // Internet Present Case
  //       showLoaderDialog(context);
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Please check your Internet connection!!!!",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           backgroundColor: HexColor('#ED1D22'),
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   }
  //   );
  //
  //   Map toMap() {
  //     var map = new Map<String, dynamic>();
  //
  //     map["code"] = Codecontroller.text.toString();
  //     map["phone_number"] = widget.number.toString();
  //     return map;
  //   }
  //   print('LLLL');
  //   var response = await http.post(
  //     Uri.parse("https://forreal.net:4000/users/phone_code_verification"),
  //
  //     // (" ${AppUrl.baseurl}/signup")
  //     body: toMap(),
  //   );
  //   print('MMMMM');
  //
  //   Navigator.pop(context);
  //   success = (otp_verify.fromJson(json.decode(response.body)).success);
  //   message = (otp_verify.fromJson(json.decode(response.body)).message);
  //
  //   print('NNNNn');
  //
  //   print("success 123 ==${success}");
  //   print("success 123 ==${message}");
  //   if (success == true) {
  //     if (success == true) {
  //       print("success 123 ==${success}");
  //       //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>BottomBar_Screen()));
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreenPage()),);
  //     }
  //   } else {
  //     Navigator.pop(context);
  //     print('else==============');
  //   }
  //   print('OOOO');
  //   return otp_verify.fromJson(json.decode(response.body));
  // }
  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //           margin: EdgeInsets.only(left: 7), child: Text("Login ...",),),
  //       ],
  //     ),
  //   );
  //   print('PPPPPP');
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  void initState() {
    print("${widget.number}");
    print("otp geeta user signup${widget.otp}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                'assets/icons/btn.svg',
              )),
        ),
      ),
      body: Form(
        // key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                customTextCommon(
                    text: "Type the verification code",
                    fSize: 18,
                    fWeight: FontWeight.w500,
                    lineHeight: 20),
                customTextCommon(
                    text: " we’ve sent you",
                    fSize: 18,
                    fWeight: FontWeight.w500,
                    lineHeight: 20),
                SizedBox(height: 140.h),
                Text("OTP : ${widget.otp}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                InkWell(
                    onTap: () {
                      // otpController.otpverify("${widget.number}");
                    },
                    child: Text(
                      'Send again',
                      style: CustomTextStyle.ote,
                    )),
                // TextButton(onPressed: (){
                //   OTPaccount();
                //   print("sdfghfd");
                //   print(Codecontroller.value.text);
                // }, child: Text("sumbit")),
                Spacer(),
                customPrimaryBtn(
                    btnText: "Submit",
                    btnFun: () {
                      print(otpController.Codecontroller.value.text);
                      otpController.otpverify("${widget.number}");
                    }),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
