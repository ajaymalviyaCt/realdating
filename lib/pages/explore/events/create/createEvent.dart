import 'dart:async';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/pages/dash_board_page.dart';
import 'package:realdating/validation/validation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../button.dart';
import '../../../../const.dart';
import '../../../../custom_iteam/coustomtextcommon.dart';
import '../../../../custom_iteam/customprofile_textfiiled.dart';
import '../../../../function/function_class.dart';
import '../../explore.dart';
import '../../trainding/trainding_details.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var eventTitle, eventType, selectTime, description;
   DateTime? startDate;
   DateTime? endDate;
  TextEditingController txt_eventTitle = TextEditingController();
  TextEditingController txt_eventType = TextEditingController();
  TextEditingController txt_selectTime = TextEditingController();
  TextEditingController txt_startDate = TextEditingController();
  TextEditingController txt_endDate = TextEditingController();
  TextEditingController txt_description = TextEditingController();

  String? CreateDeal;

  // final _formkey = GlobalKey<FormState>();

  String? user_id = "";
  var status, message, data;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future? _future;
  String? _validatemobile = null;

  _imgFromGallery() async {
    final XFile? image = (await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20));
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,

      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      maxWidth: 600,
      maxHeight: 600,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
        print(_image.toString());
        testCompressFile(_image!);
      });
    }
  }

  _imgFromCamera() async {
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: photo!.path,
      //
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      maxWidth: 600,
      maxHeight: 600,
    );
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        print(_image.toString());
        testCompressFile(_image!);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print('??????????????');
    print(file.lengthSync());
    print(result!.length);
    return result;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    // _connectivitySubscription?.cancel();
    super.dispose();
  }

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     return;
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  final List<String> eventtypeItems = ["Online", "Offline"];
  String? selectedValue;

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void uploadFileToServerInfluencer() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // user_id = prefs.getString('user_id');
      //  print('user_id==============' + user_id!);
    });
    print("CLICKED 123 ==");

    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // if (_connectionStatus != null) {
    //   // Internet Present Case
    //   showLoaderDialog(context);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Please check your Internet connection!!!!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
    showLoaderDialog(context);
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://forreal.net:4000/users/create_event"));

    // Event_Title:dating night
    // Event_Type:online
    // Select_Time:23/5/23

    // Start_Date:10AM - 12PM
    // End_Date:10AM - 12PM
    // Description:Description
    print("line 246");
    print((selectedValue??"").trim());

    request.fields['Event_Title'] = txt_eventTitle.text.toString();
    request.fields['Event_Type'] =(selectedValue??"").trim();
    //request.fields['Event_Type'] = selectedValue.toString();
    request.fields['Select_Time'] = txt_selectTime.text.toString();
    request.fields['Start_Date'] = txt_startDate.text.toString();
    request.fields['End_Date'] = txt_endDate.text.toString();
    request.fields['Description'] = txt_description.text.toString();

    if (_image == null) {
      request.fields['file'] = "";
    } else {
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));
    }
    print("??????????????${request.fields.toString()}");
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        try {
          Navigator.pop(context);

          print("response.statusCod");

          print(onValue.body);
          // _future = myprofile();
          //Rahul
          //  _willPopCallback();
          if(response.statusCode==200){
            Get.to(() => DashboardPage());
            Fluttertoast.showToast(
                msg: "Events Created successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }else if(response.statusCode==400){
            Fluttertoast.showToast(
                msg: "Please Select Valid End Date!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }


        } catch (e) {
          Fluttertoast.showToast(
              msg: "Something went wrong....",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: const Color(0xffC83760),
              textColor: Colors.white,
              fontSize: 16.0);
          // handle exeption
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/btn.svg'),
            ),
          ),
          title: const Text(
            'Create Events',
            style: CustomTextStyle.black,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const SizedBox(
                          height: 30,
                        ),
                        customTextC(
                            text: "Upload Image",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: _image == null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 135,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: HexColor('#D9D9D9'),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ))
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 135,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: HexColor('#D9D9D9'),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image:
                                                  FileImage(File(_image!.path)),
                                              fit: BoxFit.fill)),
                                    ),
                            ),
                            Container(
                              height: 141,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //  SvgPicture.asset('assets/icons/file-plus.svg'),
                                  InkWell(
                                    onTap: () {
                                      _showPicker(context);
                                    },

                                    // onTap: () async {
                                    //   final XFile? pickImage = await ImagePicker()
                                    //       .pickImage(
                                    //           source: ImageSource.gallery,
                                    //           imageQuality: 50);
                                    //   if (pickImage != null) {
                                    //     setState(() {
                                    //       CreateDeal = pickImage.path;
                                    //     });
                                    //   }
                                    // },

                                    child: SvgPicture.asset(
                                      'assets/icons/image-add (1).svg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text('Upload Image',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey))
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        customTextC(
                            text: "Event Title",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        SizedBox(
                          height: 70,
                          child: CustumProfileTextField1(
                            controller: txt_eventTitle,
                            validator: validateTitle,
                            hintText: 'Please Enter Title',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        customTextC(
                          text: "Event Type",
                          fSize: 16,
                          fWeight: FontWeight.w500,
                          lineHeight: 36,
                         ),
                        SizedBox(
                          height: 70,
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hint: const Text(
                              ' Online',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            items: eventtypeItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Please select type.';
                            //   }
                            //   return null;
                            // },

                            onChanged: (value) {
                              selectedValue = value;
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                size: 22,
                                color: Colors.black,
                              ),
                              iconSize: 24,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),

                          // CustumProfileTextField1(
                          //   controller: txt_eventType,
                          //   validator: validatePrice,
                          //   hintText: 'Please Enter Type',
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextC(
                            text: "Select Time",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        SizedBox(
                            height: 70,
                            child: TextFormField(
                              validator: validTimeTitle,
                              controller: txt_selectTime,
                              style: TextStyle(color: Colors.black),
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusColor: Colors.black,
                                  suffixIcon: Icon(
                                    Icons.timer,
                                    color: Colors.black,
                                  ),
                                  //icon of text field
                                  labelText: "Enter Time" //label text of field

                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  print(pickedTime
                                      .format(context)); //output 10:51 PM
                                  //print(pickedTime);   //output 10:51 PM
                                  // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                  //converting to DateTime so that we can further format on different pattern.
                                  // print(parsedTime); //output 1970-01-01 22:53:00.000
                                  // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                  String formattedTime =
                                      pickedTime.format(context);
                                  print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                  setState(() {
                                    txt_selectTime.text =
                                        formattedTime; //set the value of text field.
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            )

                            // CustumProfileTextField1(
                            //   controller: txt_selectTime,
                            //   validator: validateDeal,
                            //   hintText: 'Please Enter Time',
                            // ),
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextC(
                            text: "Select Start Date",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            validator: notEmptyValidator,
                            controller: txt_startDate,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                              //i
                              // con of text field
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
                              hintText: " MM - DD - YYYY",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusColor: Colors.black,
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: startDate??DateTime.now(),
                                  firstDate: DateTime.now(),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2999));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('MM-dd-yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  startDate = pickedDate;
                                  txt_startDate.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          // CustumProfileTextField1(
                          //   controller: txt_startDate,
                          //   validator: validateDeal,
                          //   hintText: 'Please Enter Start Date',
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextC(
                            text: "Select End Date",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        SizedBox(
                          height: 70,
                          child: TextFormField(
                            validator: notEmptyValidator,
                            controller: txt_endDate,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                              //i
                              // con of text field
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
                              hintText: " MM - DD - YY",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusColor: Colors.black,
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: endDate ??  DateTime.now(),
                                  firstDate: DateTime(1900),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2999));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('MM-dd-yy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  endDate=pickedDate;
                                  txt_endDate.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          // CustumProfileTextField1(
                          //   controller: txt_endDate,
                          //   validator: validateDeal,
                          //   hintText: 'Please Enter End Date',
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextC(
                            text: "Description",
                            fSize: 16,
                            fWeight: FontWeight.w500,
                            lineHeight: 36),
                        SizedBox(
                          height: 70,
                          child: CustumProfileTextField1(
                            controller: txt_description,
                            validator: validateDescriptionn,
                            hintText: 'Please Enter Description',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        updateBtn(context),
                        const SizedBox(
                          height: 30,
                        ),
                      ])),
                )),
          ],
        ));
  }

  Widget updateBtn(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Button(
        btnColor: Colors.redAccent,
        buttonName: 'CREATE',
        btnstyle: textstylesubtitle2(context)!
            .copyWith(color: colorWhite, fontFamily: 'Poppins'),
        borderRadius: BorderRadius.circular(30.00),
        btnWidth: deviceWidth(context),
        btnHeight: 60,
        // btnColor: colorbutton,
        onPressed: () {
          //Get.to(() => Reset_Pass());
          // uploadFileToServerInfluencer();
          if (formKey.currentState!.validate()) {
    if (startDate!.isAfter(endDate!)) {
      Fluttertoast.showToast(msg: "Start date cannot be greater than end date.");
    }else{
      if(_image==null ){
        Fluttertoast.showToast(msg: "Please select any image");

      }else{
        uploadFileToServerInfluencer();
      }

    }
          }

          // else{
          //   Fluttertoast.showToast(
          //       msg: "Please Match Password",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       backgroundColor: Colors.black,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
        },
      ),
    );
  }
}
