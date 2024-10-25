import 'dart:io';
import 'package:flutter/material.dart';
//todo 0000000000000
// import 'package:flutter_picker/picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:realdating/widgets/custom_textfiled.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../profile/profile_controller.dart';
import 'edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key,});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  EditProfileController editProfileController = Get.put(EditProfileController());
  ProfileController profileController = Get.put(ProfileController());
  bool isLoadig = false;
  int ? age;
  final List<String> genderItems = [
    'Feet',
    'CM',
  ];

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
  //         var  selectedHeight = picker.getSelectedValues().fold(0, (sum, value) => sum);
  //         editProfileController.height.text="${value[0]+3}.${value[1] + 0}";
  //         // var   selectedHeight1 = picker.getSelectedValues().fold(0, (sum, value) => sum + value);
  //       });
  //     },
  //   ).showDialog(context);
  // }
  //todo 0000000000000




  final ImagePicker _picker = ImagePicker();
  Future<void> _imagePicker({required ImageSource source}) async {
    final XFile ?  pickedFile = await _picker.pickImage(source: source);
     CroppedFile ? croppedFile = await ImageCropper().cropImage(
      sourcePath:  pickedFile!.path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   // CropAspectRatioPreset.ratio3x2,
      //   // CropAspectRatioPreset.original,
      //   // CropAspectRatioPreset.ratio4x3,
      //   // CropAspectRatioPreset.ratio16x9,
      // ],
      maxWidth: 600,
      maxHeight: 600,
    );
    if (croppedFile != null) {
      setState(() {
        editProfileController.profilepic = croppedFile.path;
        editProfileController.uploadImage(pickedFile);
      });
    }
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery '),
                      onTap: () {
                        _imagePicker(source: ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('Camera'),
                    onTap: () {
                      _imagePicker(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    profileController.profileDaitails();
    super.initState();
  }

  String? selectedValue;

  // String? profilepic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Edit Profile", context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Center(
                  child: Container(
                    child: editProfileController.profilepic == null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                              profileController.profileImage.value,
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(
                                File(editProfileController.profilepic!)),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                      child: InkWell(
                          onTap: () async {
                            _showPicker(context);
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ))),
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              StyledText(
                text: 'Unique User Name',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              editProfileTextField(
                  hintText: "Unique User Name",
                  controller: editProfileController.username,
                  validator: null),
              SizedBox(
                height: 20,
              ),
              StyledText(
                text: 'First Name',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              editProfileTextField(
                  hintText: "First Name",
                  controller: editProfileController.first_name,
                  validator: null),
              SizedBox(
                height: 20,
              ),
              StyledText(
                text: 'Last Name',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              editProfileTextField(
                  hintText: "Last Name",
                  controller: editProfileController.last_name,
                  validator: null),
              const SizedBox(
                height: 20,
              ),
              StyledText(
                text: 'Height',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 200,
              //       child: editProfileTextField(
              //           hintText: "Height",
              //           controller: editProfileController.height,
              //           validator: null,
              //           textInputType: TextInputType.phone),
              //     ),
              //     SizedBox(
              //       width: 120,
              //       height: 48,
              //       child: DropdownButtonFormField2<String>(
              //         isExpanded: true,
              //         decoration: InputDecoration(
              //           fillColor: Colors.redAccent,
              //           filled: true,
              //           contentPadding:
              //               const EdgeInsets.symmetric(vertical: 16),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //         ),
              //         hint: const Text(
              //           ' Feet',
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.white,
              //           ),
              //         ),
              //         items: genderItems
              //             .map((item) => DropdownMenuItem<String>(
              //                   value: item,
              //                   child: Text(
              //                     item,
              //                     style: const TextStyle(
              //                       fontSize: 14,
              //                     ),
              //                   ),
              //                 ))
              //             .toList(),
              //         validator: (value) {
              //           if (value == null) {
              //             return 'Please select gender.';
              //           }
              //           return null;
              //         },
              //         onChanged: (value) {},
              //         onSaved: (value) {
              //           selectedValue = value.toString();
              //         },
              //         buttonStyleData: const ButtonStyleData(
              //           padding: EdgeInsets.only(right: 8),
              //         ),
              //         iconStyleData: const IconStyleData(
              //           icon: Icon(
              //             Icons.arrow_drop_down_circle_outlined,
              //             size: 22,
              //             color: Colors.white,
              //           ),
              //           iconSize: 24,
              //         ),
              //         dropdownStyleData: DropdownStyleData(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         menuItemStyleData: const MenuItemStyleData(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 50,
                child: TextField(
                  controller: editProfileController.height,
                  decoration: InputDecoration(
                      suffixIcon: SizedBox(
                        height: 50,width: 70,
                        child: Row(
                          children: [
                            Center(
                              child: const Text(
                                "Feet",
                              ),
                            ),
                            10.widthBox,
                            Icon(Icons.height,
                              color: Colors.redAccent,
                            )
                          ],
                        ),
                      ),
                    contentPadding: EdgeInsets.all(10),
                    // filled: true,
                    // fillColor: Colors.grey.withOpacity(.25),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,color:Colors.black12,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,color: Colors.black12,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,color: Colors.red,
                        )),
                    focusedErrorBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,color: Colors.black,
                        )
                    ),
                    hintText: "Height",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(.55))),

                  readOnly: true,
                  onTap: () async {
                    //todo 0000000000000
                    print("clickedasdfghgertyuiuytrewert");
                    //_showHeightPicker();
                  },
                ),
              ),


              const SizedBox(
                height: 20,
              ),
              StyledText(
                text: 'DOB',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height:10,
              ),

              Container(
                width: 350,
                height: 48,
                constraints: const BoxConstraints(maxWidth: 350, maxHeight: 48),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: editProfileController.dateOfbrith,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      //i
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.redAccent,
                      ),
                      hintText: " MM - DD - YYYY",
                      focusColor: Colors.redAccent,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, top: 8)),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
                      print("only year = ${pickedDate.year}");
                       age =DateTime.now().year - pickedDate.year;
                      print("${age}");
                      //formatte
                      // d date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        editProfileController.dateOfbrith.text = formattedDate;

                        //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StyledText(
                text: 'Address',
                color: Colors.black,
                fontFamily: 'intel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10,
              ),
              editProfileTextField(
                  hintText: "Enter Address",
                  controller: editProfileController.Address,
                  validator: null),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
              ),
              Obx(
                () => customPrimaryBtn(
                  btnText: "Save Changes",
                  btnFun: () {
                    editProfileController.editProfile();
                    if(age!=null){
                      editProfileController.onlyage(age!);
                      age=null;

                    }

                  },
                  loading: editProfileController.isLoadig.value,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String text;
  final Color color;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;

  StyledText({
    required this.text,
    required this.color,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "  ${text}",
        style: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
