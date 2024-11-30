import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/app_urls.dart';
import '../setting/settings_page.dart';
import 'profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // profileController.profileDaitails();
  }

  final picker = ImagePicker();

  Future getImages() async {
    final List<XFile> pickedFile = await picker.pickMultiImage(imageQuality: 10, maxHeight: 1000, maxWidth: 1000, limit: 6);
    uploadImage(context,
        selectedImages: pickedFile
            .map(
              (e) => File(e.path),
            )
            .toList());
    setState(
      () {},
    );
  }

  bool isLoading = false;

  /// upload images-----------------------------------
  void uploadImage(BuildContext context, {required List<File> selectedImages}) async {
    profileController.apiLoadingUploadImage.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest("POST", Appurls.addYourPhotoas);

    for (var file in selectedImages) {
      String fileName = file.path.split("/").last;
      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFileSign = http.MultipartFile('files', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
    }

    request.headers.addAll(headers);

    try {
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var responseBody = json.decode(responseData.body);
        String message = responseBody['message'] ?? "Upload successful";

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        await profileController.profileDaitails();
        setState(() {});
      } else if (response.statusCode == 400) {
        var responseBody = json.decode(responseData.body);
        String message = responseBody['message'] ?? "An error occurred";

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Internal server error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    profileController.apiLoadingUploadImage.value = false;
  }

  /// delete uploaded images--------------------------
  void deleteImage(String? imageId) async {
    if (imageId == null) return;

    profileController.apiLoadingUploadImage.value = true;
    try {
      Map<String, dynamic> apiData = await ApiCall.instance.callApi(
        url: "https://forreal.net:4000/users/deleteProfileImage",
        method: HttpMethod.POST,
        body: {"id": imageId},
        headers: await authHeader(),
      );
      Fluttertoast.showToast(
          msg: apiData['message'] ?? "Image deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      await profileController.profileDaitails();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to delete image: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      profileController.apiLoadingUploadImage.value = false; // Stop loading
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                },
                child: SvgPicture.asset('assets/icons/settings.svg')),
          ),
        ],
      ),
      body: Obx(
        () => profileController.isLoadig.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(children: [
                  CachedNetworkImage(
                    imageUrl: profileController.profileImage.value,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 100,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => const SizedBox(
                        height: 120,
                        width: 120,
                        child: Center(
                          child: CircularProgressIndicator(),
                        )),
                    errorWidget: (context, url, error) => Center(
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: SvgPicture.asset("assets/icons/Profile_02.svg"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "${profileController.firstName.value} ${profileController.lastName.value}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Obx(
                      () => Text(
                        "@${profileController.username.value}",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xffFB4967)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profileController.email.value,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xffAAAAAA)),
                      ),
                      /*const SizedBox(height: 15),
                      const Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffAAAAAA)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profileController.email.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),*/
                      const SizedBox(height: 15),
                      const Text(
                        "Address",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profileController.profileModel?.userInfo.address == "0"
                            ? "33 street  United State"
                            : profileController.profileModel!.userInfo.address.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xffAAAAAA)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Real Reveal",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Total Reveal = 10",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xffAAAAAA)),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffAAAAAA).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Remaining Reveal = 8",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return AbsorbPointer(
                          absorbing: profileController.apiLoadingUploadImage.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Uploaded Photos",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        getImages();
                                      },
                                      child: Image.asset(
                                        'assets/icons/addition.png',
                                        scale: 30,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 12),
                              Stack(
                                children: [
                                  Opacity(
                                    opacity: profileController.apiLoadingUploadImage.value ? 0.5 : 1,
                                    child: SizedBox(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: profileController.profileModel?.userInfo.newImages.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 10),
                                        itemBuilder: (ctx, index) {
                                          final data = profileController.profileModel?.userInfo.newImages;
                                          print('profile images----------$data');
                                          return Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black12),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data![index].profileImages,
                                                    imageBuilder: (context, imageProvider) => Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                    errorWidget: (context, url, error) => const Icon(Icons.person_2_outlined),
                                                  ),
                                                ),
                                              ),
                                              // Cross Icon (Delete Button)
                                              Positioned(
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (profileController.profileModel!.userInfo.newImages.length > 2) {
                                                        deleteImage(data[index].id.toString());
                                                      } else {
                                                        Fluttertoast.showToast(
                                                          msg: "You must have at least 2 photos uploaded.",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          backgroundColor: Colors.red,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding: const EdgeInsets.all(4),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  if (profileController.apiLoadingUploadImage.value)
                                    Center(
                                      child: Container(margin: const EdgeInsets.only(top: 50), child: const CircularProgressIndicator()),
                                    )
                                ],
                              ),
                              20.heightBox,
                              Row(
                                children: [
                                  const Text(
                                    'Interests',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/icons/addition.png',
                                        scale: 30,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              10.heightBox,
                              profileController.profileModel?.userInfo.interest == null
                                  ? const Text("No Intrest Found !!")
                                  : SizedBox(
                                      // height: 120,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: interestList().isNotEmpty ? interestList().length : 0,
                                        itemBuilder: (ctx, i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                              height: 50,
                                              child: DottedBorder(
                                                strokeWidth: 1,
                                                color: const Color(0xFFE94057),
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(12),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: 220,
                                                      height: 32,
                                                      child: Text(
                                                        interestList()[i] ?? "",
                                                        style: const TextStyle(
                                                          color: Color(0xFFE94057),
                                                          fontSize: 8,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 0.11,
                                                        ),
                                                      ).centered(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 34, crossAxisSpacing: 10),
                                      ),
                                    ),
                              20.heightBox,
                              Row(
                                children: [
                                  const Text(
                                    'Hobbies',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/icons/addition.png',
                                        scale: 30,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              10.heightBox,
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: hobbiesList().length ?? 0,
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SizedBox(
                                        height: 50,
                                        child: DottedBorder(
                                          strokeWidth: 1,
                                          color: const Color(0xFFE94057),
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(12),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                width: 220,
                                                height: 35,
                                                child: Text(
                                                  hobbiesList()[i] ?? "",
                                                  style: const TextStyle(
                                                    color: Color(0xFFE94057),
                                                    fontSize: 8,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.11,
                                                  ),
                                                ).centered(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 34, crossAxisSpacing: 10),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ]),
              ),
      ),
    );
  }

  List<String> interestList() => (profileController.profileModel?.userInfo.interest.trim().split(",") ?? [])
      .where(
        (element) => element.trim().isNotEmpty,
      )
      .toList();

  List<String> hobbiesList() => (profileController.profileModel?.userInfo.hobbies.trim().split(",") ?? [])
      .where(
        (element) => element.trim().isNotEmpty,
      )
      .toList();

  final speedNotifier = ValueNotifier<double>(1);
}
