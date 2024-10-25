import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/custom_iteam/customprofile_textfiiled.dart';
import 'package:realdating/validation/validation.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../function/function_class.dart';
import '../../pages/edit_profle/edit_profile.dart';
import '../buisness_hourbutton/buisness_hourbutton.dart';
import 'business_profile_controller.dart';

class BusinessProfile extends StatefulWidget {
  const BusinessProfile({Key? key}) : super(key: key);

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  XFile? coverImage;

  final BusinessProfileController profileController = Get.put(BusinessProfileController());


  Future<void>  updateProfilePic() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
    // setState(() {
    //   profileController.businessProfileImage = croppedFile?.path;
    // });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');


    var headers = {
      'Authorization': 'Bearer $token'
    };
    var data = FormData.fromMap({
      'file': [await MultipartFile.fromFile('${croppedFile!.path}', filename: 'qwer')
      ],
      'business_id': '$userId',
    });

    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/add_profile_photo',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("uploadprofile" + json.encode(response.data));
      profileController.myProfile();
    }
    else {
      print(response.statusMessage);
    }
  }
  Future<void>  updateCoverphoto() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
    // setState(() {
    //   profileController.businessProfileImage = croppedFile?.path;
    // });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');


    var headers = {
      'Authorization': 'Bearer $token'
    };
    var data = FormData.fromMap({
      'file': [await MultipartFile.fromFile(croppedFile!.path, filename: 'qwer')],
      'business_id': '$userId',
    });

    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/add_cover_photo',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("uploadprofile" + json.encode(response.data));
      profileController.myProfile();
    }
    else {
      print(response.statusMessage);
    }
  }




  @override
  void initState() {
    super.initState();
    profileController.myProfile();
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Obx(
          () => customPrimaryBtn(
            btnText: profileController.isLoadingupdateProfile.value ? "Loading..." : "Save",
            btnFun: () async {
             profileController.updateProfile();
            },
          ),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Obx(
            () => profileController.isLoadigGetProfile.value
                ?  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height:25,width: 25,child: CircularProgressIndicator(strokeWidth: 2, )),
                        Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
                      ],
                    ),)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 269,
                            child: Stack(children: [
                              Center(
                                child: ClipPath(
                                  clipper: WaveClipperTwo(),
                                  child: InkWell(
                                    onTap: (){
                                      updateCoverphoto();
                                    },
                                    child: Container(
                                        height: 270,
                                        width: MediaQuery.of(context).size.width,
                                        color: HexColor('#EDEDED'),
                                      child:CachedNetworkImage(
                                        imageUrl: profileController.profileData?.businessInfo?.coverPhoto?.toString() ?? "",
                                        placeholder: (context, url) =>
                                        const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 1,))),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.add_photo_alternate_outlined),
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.fill,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 180),
                            child: Column(
                              children: [
                                Center(
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(300),
                                              border: Border.all(
                                                  color: Appcolor.Redpink)),
                                          child: InkWell(
                                              onTap: () {
                                                updateProfilePic();
                                              },
                                              child: true ?SizedBox(
                                                height: 120,
                                                width: 120,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(100),
                                                  child:  Obx(
                                                        ()=> CachedNetworkImage(
                                                      imageUrl: profileController.bussinessProfilepic.toString(),
                                                      placeholder: (context, url) => const Center(
                                                          child: SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 1,
                                                              ))),
                                                      errorWidget: (context, url, error) => SizedBox(height: 40, child: const Icon(Icons.person_2_outlined,color: Vx.red200,)),
                                                      filterQuality: FilterQuality.low,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : CircleAvatar(
                                                      radius: 60,
                                                      backgroundColor: Colors.grey[300],
                                                      child: Icon(
                                                              Icons
                                                                  .camera_alt,
                                                              size: 40,
                                                              color: Colors
                                                                  .grey[700],
                                                            )
                                                    )),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 75, left: 85),
                                            child: Image.asset(
                                              'assets/images/verified.png',
                                              fit: BoxFit.fill,
                                              height: 36,
                                              width: 36,
                                            )
                                            //SvgPicture.asset('assets/icons/verifyd.svg', color: Colors.blue,height: 20,width: 20, fit: BoxFit.fill,),
                                            ),
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          StyledText(
                                            text: "Business Name",
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            child: CustumProfileTextField1(
                                              // initialText:  profileController
                                              //     .businessNameController.text,
                                              controller: profileController.businessNameController,
                                              validator: validateName,
                                              hintText:profileController.profileData?.businessInfo?.businessName ??
                                                  "Faucet",
                                              // 'Fauget',
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Business Hours',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 48,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 48),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextField(
                                              controller: profileController
                                                  .weekController,
                                              //editing controller of this TextField
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5),
                                                          borderSide:
                                                              BorderSide
                                                                  .none),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        BorderSide.none,
                                                  ),
                                                  prefixIcon: const Icon(
                                                    Icons
                                                        .watch_later_outlined,
                                                    color: Appcolor.Redpink,
                                                  ),
                                                  suffixIcon: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      const BusinessButton()),
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        color: Colors.black,
                                                      )),
                                                  hintText: "Schedule hours",
                                                  focusColor:
                                                      Colors.redAccent,
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 20, top: 8)),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {},
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          StyledText(
                                            text: 'Description',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, bottom: 20),
                                              //width: 350,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  maxHeight: 100),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffD9D9D9)),
                                                color: const Color(0xffEDEDED)
                                                    .withOpacity(.20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    maxLines: 5,
                                                    // validator: validateDescriptionn,
                                                    cursorColor:
                                                        Colors.redAccent,
                                                    controller: profileController
                                                        .businessDescriptionController,
                                                    decoration:
                                                        InputDecoration
                                                            .collapsed(
                                                      hintText: profileController.profileData
                                                              ?.businessInfo
                                                              ?.description ??
                                                          '   Enter Your Description...',
                                                    )),
                                              )),
                                          StyledText(
                                            text: 'Number',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            // width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController.businessNumberController,
                                              // validator: "",
                                              decoration: InputDecoration(
                                                  hintText: profileController.profileData
                                                          ?.businessInfo
                                                          ?.phoneNumber ??
                                                      'Number',
                                                  border: InputBorder.none),
                                              /*    hintText: profileData
                                                        ?.businessInfo?.phoneNumber ??
                                                    '+91 9876543210',*/
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Category',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController
                                                  .businessCategoryController,
                                              // validator: "",
                                              decoration: InputDecoration(
                                                  hintText:
                                                      " ${profileController.profileData?.businessInfo?.category ?? 'Category'}",
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Instagram',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            // height: 48,
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController
                                                  .businessInstagramController,
                                              // validator: "",
                                              decoration: InputDecoration(
                                                  hintText: profileController.profileData
                                                          ?.businessInfo
                                                          ?.instagramLink ??
                                                      'https://instagram.com/username',
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Facebook',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController
                                                  .businessFaceBookController,
                                              // validator: "",
                                              decoration: InputDecoration(
                                                  hintText: profileController.profileData
                                                          ?.businessInfo
                                                          ?.facebookLink ??
                                                      'https://facebook.com/username',
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Twitter',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController
                                                  .businessTwitterController,
                                              // validator: "",
                                              decoration: InputDecoration(
                                                  hintText: profileController.profileData
                                                          ?.businessInfo
                                                          ?.twitterLink ??
                                                      'https://twitter.com/username',
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                          StyledText(
                                            text: 'Website',
                                            color: Colors.black,
                                            fontFamily: 'intel',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            // height: 48,
                                            padding: const EdgeInsets.only(
                                                left: 5),
                                            //width: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                maxHeight: 100),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: const Color(
                                                      0xffD9D9D9)),
                                              color: const Color(0xffEDEDED)
                                                  .withOpacity(.20),
                                            ),
                                            child: TextFormField(
                                              controller: profileController
                                                  .businessWebsiteController,
                                              // validator: validateInsta,
                                              decoration: InputDecoration(
                                                  hintText: profileController.profileData
                                                          ?.businessInfo
                                                          ?.website ??
                                                      'https://wwww.mywebsite.com',
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ])),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25,top: 40),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset('assets/icons/btn.svg')),
                            ),
                          ),

                        ]),
                      ],
                    ),
                  ),
          )),
    );
  }
}
