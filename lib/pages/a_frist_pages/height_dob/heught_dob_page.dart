// import 'package:flutter_picker/flutter_picker.dart';
//todo 0000000000000
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import 'height_dob_controller.dart';

class HeightDOBpage extends StatefulWidget {
  const HeightDOBpage({super.key});

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
  int? age;
  TextStyle myTextStyle = TextStyle(
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
                    DateTime? pickedDate =
                        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());

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
                    // Regular expression to allow up to two decimal places
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
                    // LengthLimitingTextInputFormatter(5), // Limits input length to 5 characters (i.e., 11.99)
                    // LengthLimitingTextInputFormatter(5), // Limits input length to 5 characters (i.e., 11.99)
                  ],
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      print("Line 160");
                    } else {
                      try {
                        print("line 160");
                        print(value);

                        double? height = double.tryParse(value);
                        if (height != null) {
                          if (height > 11) {
                            // If value is greater than 11.99, set it back to 11.99
                            heightDOBcontroller.height.text = '11';
                            heightDOBcontroller.height.selection = const TextSelection.collapsed(offset: 5); // Moves the cursor to the end
                          }
                        }
                      } catch (e) {}
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      height: 50,
                      width: 70,
                      child: Row(
                        children: [
                          const Center(
                            child: Text(
                              "Feet",
                            ),
                          ),
                          10.widthBox,
                          const Icon(
                            Icons.height,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    hintText: "Height",
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
                      if (heightDOBcontroller.dateOfBirth.text.toString() != "") {
                        if (heightDOBcontroller.height.text.toString() != "") {
                          // heightDOBcontroller.updateStatus();
                          heightDOBcontroller.upDateOfBrith();
                          heightDOBcontroller.updateStatus();
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please select Height",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please select Date of Birth",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
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
