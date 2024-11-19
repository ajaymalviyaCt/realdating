// import 'package:flutter_picker/flutter_picker.dart';
//todo 0000000000000
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/pages/edit_profle/edit_profile_controller.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'height_dob_controller.dart';

class HeightDOBpage extends StatefulWidget {
  const HeightDOBpage({Key? key}) : super(key: key);

  @override
  State<HeightDOBpage> createState() => _HeightDOBpageState();
}

class _HeightDOBpageState extends State<HeightDOBpage> {
  HeightDOBcontroller heightDOBcontroller = Get.put(HeightDOBcontroller());
  // EditProfileController editProfileController = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
  }

  final List<String> genderItems = ["Inch", "Feet"];

  String? selectedValue;
  int ? age;
  TextStyle myTextStyle =  TextStyle(
    color: const Color(0xFF111111),
    fontFamily: 'Inter',
    fontSize: 18.adaptSize,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );


  // void _showHeightPicker() {
  //   Picker(
  //     adapter: NumberPickerAdapter(data: [
  //       const NumberPickerColumn(begin: 3, end: 7, jump: 1),
  //       const NumberPickerColumn(begin: 0, end: 11, jump: 1),
  //     ]),
  //     delimiter: [
  //       PickerDelimiter(
  //         child: Container(
  //           width: 30.0,
  //           alignment: Alignment.center,
  //           child: Text('.'),
  //         ),
  //       ),
  //     ],
  //     hideHeader: true,
  //     title: Column(
  //       children: [
  //         Text('Select Height',style: TextStyle(fontSize: 18.adaptSize,)),
  //         SizedBox(height: 20,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Text("Feet",style: TextStyle(fontSize: 14.adaptSize,color: Colors.redAccent.shade400),),
  //             Text("Inch",style: TextStyle(fontSize: 14.adaptSize,color: Colors.redAccent.shade400),),
  //           ],)
  //       ],
  //     ),
  //
  //     onConfirm: (Picker picker, List<int> value) {
  //       setState(() {
  //         print("${value[0] + 3}");
  //         print("${value[1] + 0}");
  //         heightDOBcontroller.height.text="${value[0]+3}.${value[1] + 0}";
  //       });
  //     },
  //   ).showDialog(context);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar("", context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 20.h,),
              Text(
                '  Date of Birth',
                style: myTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 56,
                child: TextField(
                  controller: heightDOBcontroller.dateOfBirth,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                    //i
                    // con of text field
                    suffixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.redAccent,
                    ),
                    hintText: " MM-DD-YYYY",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusColor: Colors.redAccent,
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
                      setState(() {
                        heightDOBcontroller.dateOfBirth.text = formattedDate;
                        heightDOBcontroller.dob = pickedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' Height',
                style: myTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 56,
                child: TextField(
                  controller: heightDOBcontroller.height,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    // Allows only one decimal place
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      height: 50,width: 70,
                      child: Row(
                        children: [
                          const Center(
                            child: Text(
                              "Feet",
                            ),
                          ),
                          10.widthBox,
                          const Icon(Icons.height,
                            color: Colors.redAccent,
                          )
                        ],
                      ),
                    ),
                    hintText: "height",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusColor: Colors.redAccent,
                  ),
                ),
              ),

              const Spacer(),
              Obx(() => customPrimaryBtn(
                btnText: "Continue",
                btnFun: () {
                  print("pramod${heightDOBcontroller.height.text}");
                  print("pramod${heightDOBcontroller.dateOfBirth.text}");
                  if(heightDOBcontroller.dateOfBirth.text.toString() != ""){
                    if(heightDOBcontroller.height.text.toString() != ""){
                       // heightDOBcontroller.updateStatus();
                        heightDOBcontroller.upDateOfBrith();
                        heightDOBcontroller.updateStatus();
                    }else{
                      Fluttertoast.showToast(msg: "Please select Height", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.black, fontSize: 16.0,);
                    }

                  }else{
                    Fluttertoast.showToast(msg: "Please select Date of Birth", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.black, fontSize: 16.0,);
                  }

                },
                loading: heightDOBcontroller.isLoadig.value,
              )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}
