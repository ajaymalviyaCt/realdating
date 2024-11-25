import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_urls.dart';
import '../setting/settings_page.dart';
import 'profile_controller.dart';
import 'package:async/async.dart';
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
  List<File> selectedImages = [];
  final picker = ImagePicker();

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 10, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
            print('Selected images-----${selectedImages}');
            uploadImage(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }



  bool isLoading = false;

  void uploadImage(context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest("POST", Appurls.addYourPhotoas);
    // request.fields['user_id'] = stringValue.toString();

    for (var file in selectedImages) {
      String fileName = file.path.split("/").last;
      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFileSign = http.MultipartFile('files', stream, length, filename: fileName);request.files.add(multipartFileSign);
    }

    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          Fluttertoast.showToast(
            msg: "Photos added Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            isLoading = false;
            profileController.profileDaitails();
          });

        /// call api here--------
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Internal sever Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print(e.toString());
        }
      });
    });
    request.headers.addAll(headers);
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
                        builder: (context) => SettingsPage(),
                      ));
                },
                child: SvgPicture.asset('assets/icons/settings.svg')),
          ),
        ],
      ),
      body: Obx(
            () =>
        profileController.isLoadig.value
            ? const Center(
            child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            CachedNetworkImage(
              imageUrl: profileController.profileImage.value,
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: imageProvider,
                  ),
              placeholder: (context, url) =>
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://www.yiwubazaar.com/resources/assets/images/default-product.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: SvgPicture.asset(
                            "assets/icons/Profile_02.svg"),
                      ),
                    ),
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${profileController.firstName.value} ${profileController
                    .lastName.value}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Obx(
                    () =>
                    Text(
                      "@${profileController.username.value}",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFB4967)),
                    ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Unique Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  profileController.username.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffAAAAAA)
                  ),
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
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color:Colors.black),
                ),
                const SizedBox(height: 8),
                Text(profileController.profileModel?.userInfo.address == "0"
                    ? "33 street  United State"
                    : profileController.profileModel!.userInfo.address
                    .toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffAAAAAA)
                  ),
                ),
                SizedBox(height: 10,),
                const Text(
                  "Real Reveal",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color:Colors.black),
                ),
                const SizedBox(height: 8),
                const Text("Total Reveal = 10",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffAAAAAA)
                  ),
                ),


                const SizedBox(height:15),
                Container(
                  height:40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffAAAAAA).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text("Remaining Reveal = 8",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Uploaded Photos",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color:Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          getImages();
                        },
                        child: Image.asset('assets/icons/addition.png',scale:30,color: Colors.black,))
                  ],
                ),
                const SizedBox(height:12),

                SizedBox(
                  height: 300,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileController
                          .profileModel?.userInfo.images.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing:5,
                          crossAxisSpacing:10),
                      itemBuilder: (ctx, index) {
                        final data = profileController
                            .profileModel?.userInfo.images[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: data?.profileImages ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.person_2_outlined),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
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


  final speedNotifier = ValueNotifier<double>(1);




}