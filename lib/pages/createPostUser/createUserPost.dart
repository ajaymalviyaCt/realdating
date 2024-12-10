import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mime/mime.dart';
import 'package:realdating/custom_iteam/coustomtextcommon.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/home_page_new/home_page_new_controller.dart';
import 'package:realdating/pages/createPostUser/create_post_controller.dart';
import 'package:realdating/pages/profile/profile_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realdating/reel/common_import.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import '../../buisness_screens/buisness_home/ProfileData_modal.dart';
import '../../home_page_new/home_page_user_controller.dart';
import '../../validation/validation.dart';
import '../dash_board_page.dart';
import '../homepage/userHomeController.dart';
import '../swipcard/swip_controller.dart';
import 'mention/getFriendModel.dart';

class UserCreatePost extends StatefulWidget {
  const UserCreatePost({
    super.key,
  });

  @override
  State<UserCreatePost> createState() => _UserCreatePostState();
}

class _UserCreatePostState extends State<UserCreatePost> {
  BusinessInfo? profile_data;
  ProfileController profileController = Get.put(ProfileController());

  HomePageUserController postsC = Get.find<HomePageUserController>();

  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  var status, message, user_id, token, headers;

  String? PostImage;

  TextEditingController Content = TextEditingController();
  var reasonValidation = true;
  final myTextController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //  PickedFile? _imageFile;

  UserHomeController userHomeController = Get.put(UserHomeController());
  HomePageNewController homePageNewController = Get.find<HomePageNewController>();
  List<MyFriends>? myFriends;

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
                        Get.find<CreatePostController>().onTapGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: const Text('Video'),
                    onTap: () {
                      final controller = Get.find<CreatePostController>();
                      controller.onTapVideo();
                      Navigator.of(context).pop();
                    },
                  ),
                  Obx(() {
                    final controller = Get.find<CreatePostController>();
                    return controller.isLoading.value
                        ? const Center(
                      child: CircularProgressIndicator(color:Colors.red,),
                    )
                        : const SizedBox.shrink();
                  }),

                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      Get.find<CreatePostController>().onTapCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      leading: const Icon(Icons.bookmark_border),
                      title: const Text('Tag people'),
                      onTap: () {
                        // _videoFromGallery();
                        Navigator.pop(context);
                        _showPickerMention(context, myList, myListId);
                        // Get.to(() => mention());
                      })
                ],
              ),
            ),
          );
        });
  }

  String getVideoNameFromPath(String videoPath) {
    List<String> pathSegments = videoPath.split('/');
    return pathSegments.last;
  }

  Future<void> compressVideo(String videoPath) async {
    try {
      String videoName = getVideoNameFromPath(videoPath);
      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        videoName,
        quality: VideoQuality.DefaultQuality,
      );

      print('Original: ${mediaInfo?.path}');
      print('Compressed: $mediaInfo');
    } catch (e) {
      print('Error compressing video: $e');
    }
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 10,
      rotate: 90,
    );
    compressVideo(file.path);
    print('??????????????');
    print(file.lengthSync());
    print(result!.length);
    setState(() {});
    return result;
  }

  @override
  void initState() {
    super.initState();
    CreatePostController controller = Get.put(CreatePostController());
    userHomeController.getMyFriendsPost();
    myTextController.addListener(() {
      setState(() {
        reasonValidation = myTextController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    //  _connectivitySubscription?.cancel();
    super.dispose();
    Get.delete<CreatePostController>();
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
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

  String commaSeparatedString = "";
  final TextEditingController _controller = TextEditingController();
  final myTextControllerMini = TextEditingController();
  SwipController swipController = Get.put(SwipController());

  String postType() {
    if (Get.find<CreatePostController>().selectedFileType.value == fileTypeName.video) {
      return "video";
    } else if (Get.find<CreatePostController>().selectedFileType.value == fileTypeName.Image) {
      return "Image";
    } else {
      return "miniBlog";
    }
  }

  void uploadFileToServerUHome(File file) async {
    EasyLoading.show(status: loadingString.tr);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    // print("sffsfsfsfsf${widget.reel.path}");

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://forreal.net:4000/create_post'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.fields['post_type'] = postType();
    if (myTextController.text.isNotEmpty) {
      request.fields['miniblogs'] = myTextController.text.trim();
    }

    if (myList.isNotEmpty) {
      print(commaSeparatedString);
      commaSeparatedString = myListId.join(', ');
      print("data====>");
      print(commaSeparatedString);
      print(myListId);
      request.fields['mentions'] = commaSeparatedString ?? "";
      print("mentionDataHere=====>");
      print(request.fields['mentions']);
      setState(() {
        myListId.clear();
        commaSeparatedString.isEmpty;
      });

      print(myListId);
    } else {
      request.fields['mentions']?.isEmpty;
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //_videoPlayerController?.dispose();
      print(await response.stream.bytesToString());
      print("uploadscuessfully");

      // postsC.firstLoad();
      Get.offAll(() => const DashboardPage());
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardPage(),
      //   ),
      // );
    } else {
      print(response.reasonPhrase);
    }
    //Ezay for
    EasyLoading.dismiss();
  }

  void uploadFileToServerUHomeImage() async {
    if (myTextController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Caption can't be empty");
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.get('token');
    print(tokens);
    try {
      setState(() {
        commaSeparatedString = "";
        commaSeparatedString.isEmpty;
        // print('user_id==============' + user_id!);
      });

      showLoaderDialog(context);

      headers = {
        'Authorization': 'Bearer $tokens',
      };

      var request = http.MultipartRequest("POST", Uri.parse("https://forreal.net:4000/create_post"));
      print(commaSeparatedString);
      commaSeparatedString = myListId.join(', ');

      print(commaSeparatedString);
      print(myListId);
      request.headers.addAll(headers);
      request.fields['post_type'] = postType();

      print(postType());
      if (myList.isNotEmpty) {
        request.fields['mentions'] = commaSeparatedString ?? "";

        setState(() {
          myListId.clear();
          commaSeparatedString.isEmpty;
        });

        print(myListId);
      } else {
        request.fields['mentions']?.isEmpty;
      }
      if (myTextController.text.trim().isNotEmpty) {
        request.fields['miniblogs'] = myTextController.text.trim();
      }

      if (Get.find<CreatePostController>().selectedFile.value == null) {
        print("object");
        request.fields['file']?.isEmpty;
      } else if (Get.find<CreatePostController>().selectedFile.value != null) {
        request.files
            .add(await http.MultipartFile.fromPath('file', Get.find<CreatePostController>().selectedFile.value!.path ?? ""));
      }
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) async {
          if (response.statusCode == 200) {
            sendNotification(request.fields['mentions'].toString(), "like");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const DashboardPage(),
            //   ),
            // );
            Get.offAll(() => const DashboardPage());
            setState(() {
              myListId.clear();
              myList.clear();
            });
            print("response.statusCod");
            print(myListId);
            print(onValue.body);
            postsC.firstLoad();
            if (request.fields['mentions'] != null) {
              swipController.sendNotification(myList, "tag");
            }
            Fluttertoast.showToast(
                msg: "Post has been uploaded successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);

            request.fields['mentions']?.isEmpty;
            commaSeparatedString.isEmpty;
            commaSeparatedString == null;
            myTextController.clear();
          } else {
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
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // List<String> _hashtags = [];

  List<String> availableData = ['@john_doe', '@jane_doe', '@user123', '@flutter_dev', '@developer_xyz'];

  List<String> filteredList = [];

  void filterList(String query) {
    setState(() {
      if (query.isEmpty || !query.startsWith('@')) {
        filteredList = availableData;
      } else {
        filteredList = availableData.where((item) => item.toLowerCase().startsWith(query.toLowerCase())).toList();
      }
    });
  }

  String selectedTag = "";
  final List<String> myList = [];
  final List<String> myListId = [];

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: () {
                  Get.find<CreatePostController>().selectedFile.value = null;
                  myTextController.clear();
                  myList.clear();
                  myListId.clear();
                  // Navigator.pop(context);
                  Get.offAll(() => const DashboardPage());
                },
                child: SvgPicture.asset('assets/icons/btn.svg')),
          ),
          title: const Text(
            'Create post',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: IconButton(
                onPressed: () {
                  print(myTextController.text);
                  if (Get.find<CreatePostController>().selectedFile.value != null || myTextController.text.isNotEmpty) {
                    uploadFileToServerUHomeImage();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please select image or Text..",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0xffC83760),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                icon: Image.asset('assets/icons/Share.png'),
              ),
            ),

            // SvgPicture.asset('assets/icons/Share.svg'),
            const SizedBox(width: 20)
          ],
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        customTextC(
                          text: "Upload",
                          fSize: 16,
                          fWeight: FontWeight.w500,
                          lineHeight: 36,
                        ),

                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Center(
                              child: Get.find<CreatePostController>().selectedFile.value == null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: HexColor('#D9D9D9')),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    )
                                  : Get.find<CreatePostController>().selectedFileType.value == fileTypeName.video
                                      ? Get.find<CreatePostController>().videoPlayerController.value!.value.isInitialized
                                          ? Container(
                                              margin: const EdgeInsets.only(top: 130),
                                              height: 300,
                                              child: AspectRatio(
                                                aspectRatio: Get.find<CreatePostController>()
                                                    .videoPlayerController
                                                    .value!
                                                    .value
                                                    .aspectRatio,
                                                child: VideoPlayer(Get.find<CreatePostController>().videoPlayerController.value!),
                                              ),
                                            )
                                          : Container()
                                      : Stack(
                                          children: [
                                            Get.find<CreatePostController>().videoPlayerController .value== null
                                                ? Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 306,
                                                    margin: const EdgeInsets.only(top: 100),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: HexColor('#D9D9D9')),
                                                      borderRadius: BorderRadius.circular(15),
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                            File(Get.find<CreatePostController>().selectedFile.value!.path!)),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    margin: const EdgeInsets.only(top: 80),
                                                    height: 306,
                                                    child: AspectRatio(
                                                      aspectRatio: Get.find<CreatePostController>()
                                                          .videoPlayerController
                                                          .value!
                                                          .value
                                                          .aspectRatio,
                                                      child: VideoPlayer(
                                                          Get.find<CreatePostController>().videoPlayerController.value!),
                                                    ),
                                                  ),
                                          ],
                                        ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Get.find<CreatePostController>().selectedFile.value == null
                                    ? Colors.transparent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            profileController.profileImage.value,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profileController.firstName.value,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          _showPicker(context);
                                        },
                                        icon: const Icon(Icons.attachment_sharp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),

                        const SizedBox(height: 60),

                        SizedBox(
                          child: TextFormField(
                            validator: notEmptyValidator,
                            controller: myTextController,
                            onChanged: (value) {
                              if (value.startsWith(' ')) {
                                myTextController.text = value.trim();
                                myTextController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: myTextController.text.trim().length),
                                );
                              }

                              // if (value.trim().isNotEmpty) {
                              //   myTextController.text.trim();
                              // }
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1, color: Colors.black12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1, color: Colors.black12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1, color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1, color: Colors.black),
                              ),
                              hintText: 'Type your caption here...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // updateBtn(context),
                      ],
                    ),
                  ),
                ),
                myList == null
                    ? const Text("data")
                    : SizedBox(
                        height: 150,
                        child: GridView.builder(
                          itemCount: myList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.5,
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "@${myList == null ? "NO Tag" : myList[index]}",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showPickerMention(context, parameter1, parameter2) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Tag People",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.done),
                          color: Appcolor.Redpink,
                          iconSize: 25,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TypeAheadField<MyFriends>(
                      // key: GlobalKey(),
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                          hintText: selectedTag.isNotEmpty ? selectedTag : "Tag People..",
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return userHomeController.userFriend
                            .where((userFriend) => userFriend.friendFirstName!.toLowerCase().contains(pattern.toLowerCase()));
                      },

                      itemBuilder: (context, MyFriends? suggestion) {
                        return ListTile(
                          title: Text(suggestion?.friendFirstName ?? ""),
                        );
                      },
                      onSuggestionSelected: (MyFriends? suggestion) {
                        setState(() => selectedTag = suggestion!.friendFirstName.toString());
                        myList.add(selectedTag);
                        myListId.add(suggestion?.friendId.toString() ?? "1");
                        print(selectedTag);

                        print('Selected user: ${suggestion?.friendFirstName.toString()}');

                        print('Selected userId: ${myListId.toList()}');
                      },
                    ),
                  ),
                  Expanded(
                    // height: 150,
                    child: ListView.builder(
                      itemCount: myList.length,
                      itemBuilder: (context, index) {
                        print("jfkrejgirotugoi");
                        print(myList);
                        return ListTile(
                          title: Text(
                            "@${myList == null ? "NO Tag" : myList[index]}",
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                          ),
                          // subtitle: Text(widget.dataP.parameter2[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class MyData {
  final List<String> parameter1;
  final List<String> parameter2;

  MyData(this.parameter1, this.parameter2);
}

fileTypeName? fileTypeCheckk(String filePath) {
  String? mimeType = lookupMimeType(filePath);

  if (mimeType != null) {
    if (mimeType.startsWith('image/')) {
      return fileTypeName.Image;
    } else if (mimeType.startsWith('video/')) {
      return fileTypeName.video;
    }
  }
  print("fileType");
  print(mimeType);
  return null;
}

enum fileTypeName {
  Image,
  video,
}
