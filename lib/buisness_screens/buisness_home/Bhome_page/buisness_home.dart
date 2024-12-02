import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_home/model/allBusinessPost_model.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/home_page_new/home_page_new_controller.dart';
import 'package:realdating/welcome_screen/optionButton.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../consts/app_urls.dart';
import '../../../pages/video_screen/video_player_iten.dart';
import '../../../services/base_client01.dart';
import '../../buisness_controller/buisness_login/buisness_logincontroller.dart';
import '../../buisness_create_ads/all_ads/all_ads.dart';
import '../../buisness_create_ads/create_ads.dart';
import '../../buisness_createdeal/create_deal.dart';
import '../../buisness_dashboard/buisness_dashboard.dart';
import '../../buisness_post/buisness_post.dart';
import '../../buisness_profile/buisness_profile.dart';
import '../../buisness_profile/business_profile_controller.dart';
import '../deals/edit_deal.dart';
import 'comment_screen.dart';
import 'homepage_bussiness_controller.dart';
import '../controller/business_home_controller.dart';
import '../deals/all_top_deals.dart';
import 'package:http/http.dart' as http;

class BuisnessHomePage extends StatefulWidget {
  const BuisnessHomePage({super.key});

  @override
  State<BuisnessHomePage> createState() => _BuisnessHomePageState();
}

class _BuisnessHomePageState extends State<BuisnessHomePage> {
  HomepageBusinessController postsC = Get.put(HomepageBusinessController());
  final BusinessProfileController profileController = Get.put(BusinessProfileController());
  final HomePageNewController homePageNewController = Get.put(HomePageNewController());

  var businessId;

  void getBussinessID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    businessId = prefs.get('user_id');
  }

  MyDealController myDealController = Get.put(MyDealController());
  var profile_image, business_name;
  ChewieController? chewieController;

  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription? _connectivitySubscription;

  AllBusinessPostModel? allDataBusiness;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBussinessID();
    myDealController.MYDeal();
  }

  //
  // Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  //   setState(() {
  //     _connectionStatus = result.first;
  //   });
  // }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Please Wait...")),
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

  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<void> initConnectivity() async {
  //   late List<ConnectivityResult> result;
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

  void uploadFileToServerBHome(post, miniblog, postType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var userId = prefs.get('user_id');
      var token = prefs.get('token');
      // print('user_id==============' + user_id!);

      print("CLICKED 123 ==");

      // initConnectivity();
      // _connectivitySubscription =
      //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
      //
      // if (_connectionStatus != null) {
      //   // Internet Present Case
      //   // showLoaderDialog(context);
      // } else {
      //   Fluttertoast.showToast(
      //       msg: "Please check your Internet connection!!!!",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       backgroundColor: Colors.black,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // }

      //  headers = {
      //    'Authorization': 'Bearer $token',
      // };
      showLoaderDialog(context);
      var request = http.MultipartRequest("POST", Uri.parse("https://forreal.net:4000/create_business_post"));
      final headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      request.headers.addAll(headers);
      if (miniblog.isNotEmpty) {
        request.fields['caption'] = miniblog.toString();
      }

      request.fields['post_type'] = postType;

      request.fields['business_id'] = (userId ?? 11).toString();
      // request.headers.addAll(headers);
      if (post == null) {
        request.fields['file']?.isEmpty;
      } else if (post != null && post != "") {
        var response = await http.get(Uri.parse(post));

        request.files.add(http.MultipartFile.fromBytes(
          'file',
          response.bodyBytes,
          filename: post,
          // Adjust the content type based on your file type
        ));
      }
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) async {
          if (response.statusCode == 200) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BuisnessHomePage(),
            //   ),
            // );

            print("response.statusCod");
            print(onValue.body);

            print('Lower APi');

            // _future = myprofile();
            //Rahul
            //  _willPopCallback();
            // myDealController.getAllBusinessPost(_pagingController.nextPageKey!);
            Fluttertoast.showToast(
              msg: "Post has been uploaded successfully.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
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
    } catch (e, s) {
      print(s);
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    super.dispose();
  }

  BuisnessLoginController buissnesloginController = Get.put(BuisnessLoginController());

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Logout"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoginB", false);
        buissnesloginController.buisnessemailController.clear();
        buissnesloginController.buisnesspasswordController.clear();
        buissnesloginController.isLoadigLogin.value = false;
        Get.offAll(() => const OptionScreen());
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure, do you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  height(lenght) {
    if (lenght < 5) {
      return MediaQuery.of(context).size.height * 1;
    } else if (lenght > 5 && lenght < 10) {
      return MediaQuery.of(context).size.height * 2;
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Stay in the app
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // Exit the app
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // final _pagingController = PagingController<int, Post>(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDealController>(
      initState: (state) {
        MyDealController();
      },
      builder: (controller) {
        return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              drawer: Drawer(
                child: ListView(children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: HexColor('#EDEDED'),
                        child: Obx(
                          () => CachedNetworkImage(
                            imageUrl: profileController.bussinessCoverprofilepic.toString(),
                            placeholder: (context, url) => const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ))),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Vx.red200,
                            ),
                            filterQuality: FilterQuality.low,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 90,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Vx.red200),
                            color: Colors.transparent,
                          ),
                          child: Obx(
                            () => SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: profileController.bussinessProfilepic.toString(),
                                  placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ))),
                                  errorWidget: (context, url, error) => const SizedBox(
                                      height: 40,
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color: Vx.red200,
                                      )),
                                  filterQuality: FilterQuality.low,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 160,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(.5), borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  profileController.bussinessName.value.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Aboshi",
                                    color: Appcolor.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SvgPicture.asset('assets/icons/home-04.svg'), const Text('       Home')],
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SvgPicture.asset('assets/icons/dashb.svg'), const Text('       Dashboard')],
                    ),
                    onTap: () {
                      Get.to(() => const DashBaordScreen());
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SvgPicture.asset('assets/icons/profile.svg'), const Text('       My Profile')],
                    ),
                    onTap: () {
                      Get.to(() => const BusinessProfile());
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SvgPicture.asset('assets/icons/allAds.svg'), const Text('       All Ads')],
                    ),
                    onTap: () {
                      Get.to(() => const All_Ads());
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SvgPicture.asset('assets/icons/logout.svg'), const Text('       Logout')],
                    ),
                    onTap: () async {
                      showAlertDialog(context);
                    },
                  ),
                ]),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  postsC.page.value = 1;
                  postsC.hasNextPage.value = true;
                  postsC.firstLoad();
                  myDealController.MYDeal();
                },
                child: ListView(
                  controller: postsC.controller,
                  children: [
                    8.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Builder(builder: (context) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Container(
                                height: 52.ah,
                                width: 52.aw,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Vx.red100),
                                  borderRadius: BorderRadius.circular(300),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Obx(
                                      () => CachedNetworkImage(
                                        imageUrl: profileController.bussinessProfilepic.value.toString(),
                                        placeholder: (context, url) => const Center(
                                            child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ))),
                                        errorWidget: (context, url, error) => const Icon(Icons.person_2_outlined),
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.fill,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Image.network(myDealController.allDataBusiness?.posts?[0].profileImage ?? "",),
                            );
                          }),
                          const SizedBox(
                            width: 5,
                          ),
                          Obx(
                            () => customTextCommon(
                              text: profileController.bussinessName.value.toString(),
                              fSize: 20,
                              fWeight: FontWeight.w600,
                              lineHeight: 29,
                            ),
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            surfaceTintColor: Colors.white,
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 1,
                                // row with 2 children
                                child: InkWell(
                                    onTap: () {
                                      Get.to(() => const CreateDeal());
                                      /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateDeal()));*/
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // SvgPicture.asset('assets/icons/Iconb.svg'),
                                        Text('    Create Deals')
                                      ],
                                    )
                                    //Text("Block")
                                    ),
                              ),

                              // PopupMenuItem 2
                              PopupMenuItem(
                                value: 2,
                                // row with two children
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const CreateAads());
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // SvgPicture.asset('assets/icons/Iconb.svg'),
                                      Text('    Create Ad')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            child: const Icon(
                              Icons.add,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 22.ah,
                          ),
                          /*                  IconButton(
                            onPressed: () {
                              Get.to(() => const NotificationPageBusiness());
                            },
                            icon: SvgPicture.asset('assets/icons/notification.svg'))*/
                        ],
                      ),
                    ),
                    29.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customTextCommon(text: "Top Deals", fSize: 24, fWeight: FontWeight.w600, lineHeight: 24),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const BuiusnessTopDeals()));
                            },
                            child: customTextCommon(
                              text: "See All",
                              fSize: 18,
                              fWeight: FontWeight.w600,
                              lineHeight: 24,
                              color: HexColor('#AAAAAA'),
                            ),
                          )
                        ],
                      ),
                    ),
                    12.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Obx(
                        () => controller.isLoadigDeal.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : topDealsList(controller),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => postsC.isFirstLoadRunning.value
                          ? const Center(
                              child: SizedBox(
                                  height: 250,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ))),
                            )
                          : Column(
                              children: [
                                Obx(
                                  () => postsC.bHomePagetModel.posts.isEmpty
                                      ? SizedBox(
                                          height: 300.ah,
                                          child: const Center(
                                            child: Text("No Post Found"),
                                          ))
                                      : RefreshIndicator(
                                          onRefresh: () async {
                                            postsC.firstLoad();
                                          },
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: postsC.bHomePagetModel.posts.length,
                                              itemBuilder: (_, index) {


                                                print('user proifile image --------${postsC.bHomePagetModel.posts[index].profileImage}');

                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      if (postsC.bHomePagetModel.posts[index].postType == "Image")
                                                        Container(
                                                          width: 350.aw,
                                                          decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            shadows: const [
                                                              BoxShadow(
                                                                color: Color(0x19000000),
                                                                blurRadius: 15,
                                                                offset: Offset(0, 10),
                                                                spreadRadius: 0,
                                                              )
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(20.0.adaptSize),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                10.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color: Colors.red.shade200,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(35)),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(35),
                                                                        child: SizedBox(
                                                                          height: 35,
                                                                          width: 35,
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: postsC.bHomePagetModel.posts[index].profileImage.toString(),
                                                                            placeholder: (context, url) => const Center(
                                                                                child: SizedBox(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: CircularProgressIndicator(
                                                                                      strokeWidth: 1,
                                                                                    ))),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset('assets/images/business_image_icon.png'),
                                                                            filterQuality: FilterQuality.low,
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    10.aw.widthBox,
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].businessName}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF111111),
                                                                            fontSize: 14.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w600,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].createdAt!.day}-${postsC.bHomePagetModel.posts[index].createdAt!.month}-${postsC.bHomePagetModel.posts[index].createdAt!.year}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFAAAAAA),
                                                                            fontSize: 10.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    if ("$businessId" == postsC.bHomePagetModel.posts[index].businessId.toString())
                                                                      InkWell(
                                                                        onTap: () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                      title: const Text("Are you sure you want to delete this post?"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            deletePost(
                                                                                                postId: postsC.bHomePagetModel.posts[index].id.toString(),
                                                                                                context: context);
                                                                                            // setState(() {});
                                                                                            // myDealController.fetchPage(myDealController.pagingController.nextPageKey!);
                                                                                            // Navigator.pop(context);
                                                                                            // Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text("Yes",
                                                                                              style: TextStyle(color: Appcolor.Redpink, fontSize: 16)),
                                                                                        ),
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: const Text(
                                                                                              "No",
                                                                                              style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                                                                                            ))
                                                                                      ]));
                                                                        },
                                                                        child: const Icon(
                                                                          Icons.delete,
                                                                          color: Appcolor.Redpink,
                                                                        ),
                                                                      )

                                                                    // if ("${homePageNewController.userId}" ==
                                                                    //     "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                                    //   deletePost(index)
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                '${postsC.bHomePagetModel.posts[index].caption}' == "default_caption"
                                                                    ? const SizedBox()
                                                                    : Text(
                                                                        '${postsC.bHomePagetModel.posts[index].caption}',
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 12.adaptSize,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          height: 0,
                                                                          letterSpacing: -0.30,
                                                                        ),
                                                                      ),
                                                                '${postsC.bHomePagetModel.posts[index].miniblogs}' == "default_miniblogs"
                                                                    ? const SizedBox()
                                                                    : Text(
                                                                        '${postsC.bHomePagetModel.posts[index].miniblogs}',
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 12.adaptSize,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          height: 0,
                                                                          letterSpacing: -0.30,
                                                                        ),
                                                                      ),
                                                                15.ah.heightBox,
                                                                '${postsC.bHomePagetModel.posts[index].post}' == "default_post_image"
                                                                    ? const SizedBox()
                                                                    : Container(
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(color: Vx.red100),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                        ),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          child: SizedBox(
                                                                            width: MediaQuery.of(context).size.width,
                                                                            child: CachedNetworkImage(
                                                                              imageUrl: postsC.bHomePagetModel.posts[index].post.toString(),
                                                                              placeholder: (context, url) => const Center(
                                                                                  child: SizedBox(
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                      child: CircularProgressIndicator(
                                                                                        strokeWidth: 1,
                                                                                      ))),
                                                                              errorWidget: (context, url, error) =>
                                                                                  Image.asset('assets/images/business_image_icon.png'),
                                                                              filterQuality: FilterQuality.low,
                                                                              fit: BoxFit.fill,
                                                                              height: 300,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                // SizedBox(
                                                                //   height: double.parse("${8 * postsC.bHomePagetModel.posts[index].!.length}") + 20,
                                                                //   child: GridView(
                                                                //     physics: const NeverScrollableScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                                                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 30),
                                                                //     children: [
                                                                //       for (int i = 0;
                                                                //       postsC
                                                                //           .bHomePagetModel
                                                                //           .posts[
                                                                //       index]
                                                                //           .mentionsData!
                                                                //           .length >
                                                                //           i;
                                                                //       i++)
                                                                //         InkWell(
                                                                //           onTap: () {
                                                                //             // Get.to(
                                                                //             //       () => MatchDetails(
                                                                //             //       id: postsC
                                                                //             //           .homePageModel
                                                                //             //           .posts[index]
                                                                //             //           .mentionsData![i]
                                                                //             //           .id
                                                                //             //           .toString()),
                                                                //             // );
                                                                //           },
                                                                //           child:
                                                                //           Padding(
                                                                //             padding: const EdgeInsets
                                                                //                 .only(
                                                                //                 bottom:
                                                                //                 4.0),
                                                                //             child: Text(
                                                                //               "@${postsC.bHomePagetModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                //               style:
                                                                //               const TextStyle(
                                                                //                 color: Colors
                                                                //                     .blue,
                                                                //               ),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                                15.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    postsC.bHomePagetModel.posts[index].likedByUser == "Y"
                                                                        ? InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "N";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! - 1);
                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "0",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/heartwhite.svg"),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "Y";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! + 1);
                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "1",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/pramod_unlike_icon.svg"),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                    20.widthBox,
                                                                    InkWell(
                                                                      onTap: () {
                                                                        // homePageNewController.getAllCommentBYpostID(postID: '${postsC.bHomePagetModel.posts[index].id}', alreadlyLoad: true, indexx: index);
                                                                        Get.to(
                                                                          () => BCommentPage(
                                                                            indexxx: index,
                                                                            postId: '${postsC.bHomePagetModel.posts[index].id}',
                                                                            userId: '${postsC.bHomePagetModel.posts[index].businessId}',
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: 40,
                                                                        height: 40,
                                                                        decoration: ShapeDecoration(
                                                                          gradient: const LinearGradient(
                                                                            begin: Alignment(0.00, -1.00),
                                                                            end: Alignment(0, 1),
                                                                            colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                          ),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: SvgPicture.asset("assets/icons/pramod_comment_icon.svg"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Spacer(),

                                                                    // InkWell(
                                                                    //   onTap: (){
                                                                    //     showDialog(
                                                                    //         context: context,
                                                                    //         builder: (BuildContext
                                                                    //         context) =>
                                                                    //             AlertDialog(
                                                                    //               title: const Text(
                                                                    //                   "Are you sure you want to Re-Share this Post?"),
                                                                    //               actions: [
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     uploadFileToServerUHome("${posts[index].post}","${posts[index].miniblogs}","${posts[index].postType}");
                                                                    //                     Navigator.pop(context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "Yes",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     Navigator.pop(
                                                                    //                         context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "No",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //               ],
                                                                    //             ));
                                                                    //   },
                                                                    //   child: Container(
                                                                    //     width: 40,
                                                                    //     height: 40,
                                                                    //     decoration: ShapeDecoration(
                                                                    //       gradient: const LinearGradient(
                                                                    //         begin: Alignment(0.00, -1.00),
                                                                    //         end: Alignment(0, 1),
                                                                    //         colors: [
                                                                    //           Color(0xFFF65F51),
                                                                    //           Color(0xFFFB4967)
                                                                    //         ],
                                                                    //       ),
                                                                    //       shape: RoundedRectangleBorder(
                                                                    //         borderRadius:
                                                                    //         BorderRadius.circular(100),
                                                                    //       ),
                                                                    //     ),
                                                                    //     child: Padding(
                                                                    //       padding: const EdgeInsets.all(8.0),
                                                                    //       child: SvgPicture.asset(
                                                                    //           "assets/icons/pramod_share_icon.svg"),
                                                                    //     ),
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                Text(
                                                                  '  ${postsC.bHomePagetModel.posts[index].totalLikes} likes',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 12.adaptSize,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w500,
                                                                    height: 0,
                                                                    letterSpacing: -0.30,
                                                                  ),
                                                                ),
                                                                8.ah.heightBox,
                                                                Obx(
                                                                  () => postsC.bHomePagetModel.posts[index].totalComments == 0
                                                                      ? const SizedBox.shrink()
                                                                      : Text(
                                                                          '  View all ${postsC.bHomePagetModel.posts[index].totalComments} comment',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFAAAAAA),
                                                                            fontSize: 12.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            height: 0,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      if (postsC.bHomePagetModel.posts[index].postType == "miniBlog")
                                                        Container(
                                                          width: 350.aw,
                                                          decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            shadows: const [
                                                              BoxShadow(
                                                                color: Color(0x19000000),
                                                                blurRadius: 15,
                                                                offset: Offset(0, 10),
                                                                spreadRadius: 0,
                                                              )
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(20.0.adaptSize),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                10.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(35)),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(35),
                                                                        child: SizedBox(
                                                                          height: 35,
                                                                          width: 35,
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: postsC.bHomePagetModel.posts[index].profileImage.toString(),
                                                                            placeholder: (context, url) => const Center(
                                                                                child: SizedBox(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: CircularProgressIndicator(
                                                                                      strokeWidth: 1,
                                                                                    ))),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset('assets/images/business_image_icon.png'),
                                                                            filterQuality: FilterQuality.low,
                                                                            fit: BoxFit.fill,
                                                                            height: 300,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    10.aw.widthBox,
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].businessName}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF111111),
                                                                            fontSize: 14.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w600,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].createdAt!.day}-${postsC.bHomePagetModel.posts[index].createdAt!.month}-${postsC.bHomePagetModel.posts[index].createdAt!.year}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFAAAAAA),
                                                                            fontSize: 10.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    // if ("${homePageNewController.userId}" ==
                                                                    //     "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                                    //   deletePost(index)
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                postsC.bHomePagetModel.posts[index].miniblogs != "default_miniblogs"
                                                                    ? Text(
                                                                        '${postsC.bHomePagetModel.posts[index].miniblogs}',
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16.adaptSize,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w400,
                                                                          height: 0,
                                                                          letterSpacing: -0.30,
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
                                                                15.ah.heightBox,
                                                                // SizedBox(
                                                                //   height: double.parse(
                                                                //       "${10 * postsC.bHomePagetModel.posts[index].mentionsData!.length}") +
                                                                //       20,
                                                                //   child: GridView(
                                                                //     physics:
                                                                //     const NeverScrollableScrollPhysics(
                                                                //         parent:
                                                                //         NeverScrollableScrollPhysics()),
                                                                //     gridDelegate:
                                                                //     const SliverGridDelegateWithFixedCrossAxisCount(
                                                                //         crossAxisCount:
                                                                //         3,
                                                                //         mainAxisExtent:
                                                                //         30),
                                                                //     children: [
                                                                //       for (int i = 0;
                                                                //       postsC
                                                                //           .homePageModel
                                                                //           .posts[
                                                                //       index]
                                                                //           .mentionsData!
                                                                //           .length >
                                                                //           i;
                                                                //       i++)
                                                                //         InkWell(
                                                                //           onTap: () {
                                                                //             Get.to(
                                                                //                   () => MatchDetails(
                                                                //                   id: postsC
                                                                //                       .homePageModel
                                                                //                       .posts[index]
                                                                //                       .mentionsData![i]
                                                                //                       .id
                                                                //                       .toString()),
                                                                //             );
                                                                //           },
                                                                //           child:
                                                                //           Padding(
                                                                //             padding: const EdgeInsets.only(bottom: 4.0),
                                                                //             child: Text("@${postsC.homePageModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                //               style: const TextStyle(color: Colors.blue,),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                                15.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    postsC.bHomePagetModel.posts[index].likedByUser == "Y"
                                                                        ? InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "N";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! - 1);

                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "0",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/heartwhite.svg"),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "Y";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! + 1);

                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "1",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/pramod_unlike_icon.svg"),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                    20.widthBox,
                                                                    InkWell(
                                                                      onTap: () {
                                                                        // homePageNewController.getAllCommentBYpostID(
                                                                        //     postID:
                                                                        //     '${postsC.bHomePagetModel.posts[index].id}',
                                                                        //     alreadlyLoad:
                                                                        //     true,
                                                                        //     indexx:
                                                                        //     index);
                                                                        Get.to(
                                                                          () => BCommentPage(
                                                                            postId: '${postsC.bHomePagetModel.posts[index].id}',
                                                                            userId: '${postsC.bHomePagetModel.posts[index].id}',
                                                                            indexxx: index,
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        width: 40,
                                                                        height: 40,
                                                                        decoration: ShapeDecoration(
                                                                          gradient: const LinearGradient(
                                                                            begin: Alignment(0.00, -1.00),
                                                                            end: Alignment(0, 1),
                                                                            colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                          ),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: SvgPicture.asset("assets/icons/pramod_comment_icon.svg"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    // InkWell(
                                                                    //   onTap: (){
                                                                    //     showDialog(
                                                                    //         context: context,
                                                                    //         builder: (BuildContext
                                                                    //         context) =>
                                                                    //             AlertDialog(
                                                                    //               title: const Text(
                                                                    //                   "Are you sure you want to Re-Share this Post?"),
                                                                    //               actions: [
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     uploadFileToServerUHome("${posts[index].post}","${posts[index].miniblogs}","${posts[index].postType}");
                                                                    //                     Navigator.pop(context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "Yes",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     Navigator.pop(
                                                                    //                         context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "No",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //               ],
                                                                    //             ));
                                                                    //   },
                                                                    //   child:    Container(
                                                                    //     width: 40,
                                                                    //     height: 40,
                                                                    //     decoration: ShapeDecoration(
                                                                    //       gradient: const LinearGradient(
                                                                    //         begin: Alignment(0.00, -1.00),
                                                                    //         end: Alignment(0, 1),
                                                                    //         colors: [
                                                                    //           Color(0xFFF65F51),
                                                                    //           Color(0xFFFB4967)
                                                                    //         ],
                                                                    //       ),
                                                                    //       shape: RoundedRectangleBorder(
                                                                    //         borderRadius:
                                                                    //         BorderRadius.circular(100),
                                                                    //       ),
                                                                    //     ),
                                                                    //     child: Padding(
                                                                    //       padding: const EdgeInsets.all(8.0),
                                                                    //       child: SvgPicture.asset(
                                                                    //           "assets/icons/pramod_share_icon.svg"),
                                                                    //     ),
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                Text(
                                                                  '  ${postsC.bHomePagetModel.posts[index].totalLikes} likes',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 12.adaptSize,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w500,
                                                                    height: 0,
                                                                    letterSpacing: -0.30,
                                                                  ),
                                                                ),
                                                                8.ah.heightBox,
                                                                postsC.bHomePagetModel.posts[index].totalComments == 0
                                                                    ? const SizedBox.shrink()
                                                                    : Text(
                                                                        '  View all ${postsC.bHomePagetModel.posts[index].totalComments} comment',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFFAAAAAA),
                                                                          fontSize: 12.adaptSize,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w500,
                                                                          height: 0,
                                                                          letterSpacing: -0.30,
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      if (postsC.bHomePagetModel.posts[index].postType == "AD")
                                                        Container(
                                                          width: 350.aw,
                                                          decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            shadows: const [
                                                              BoxShadow(
                                                                color: Color(0x19000000),
                                                                blurRadius: 15,
                                                                offset: Offset(0, 10),
                                                                spreadRadius: 0,
                                                              )
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(20.0.adaptSize),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(35)),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(35),
                                                                        child: SizedBox(
                                                                          height: 35,
                                                                          width: 35,
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: postsC.bHomePagetModel.posts[index].profileImage.toString(),
                                                                            placeholder: (context, url) => const Center(
                                                                                child: SizedBox(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: CircularProgressIndicator(
                                                                                      strokeWidth: 1,
                                                                                    ))),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset('assets/images/business_image_icon.png'),
                                                                            filterQuality: FilterQuality.low,
                                                                            fit: BoxFit.fill,
                                                                            height: 300,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    10.aw.widthBox,
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].caption}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF111111),
                                                                            fontSize: 14.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w600,
                                                                            height: 0,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                        6.heightBox,
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].createdAt}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFAAAAAA),
                                                                            fontSize: 10.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            height: 0,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                10.heightBox,
                                                                ClipRRect(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width,
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: postsC.bHomePagetModel.posts[index].businessName.toString(),
                                                                      placeholder: (context, url) => const Center(
                                                                          child: SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 1,
                                                                              ))),
                                                                      errorWidget: (context, url, error) => const Icon(Icons.person_2_outlined),
                                                                      filterQuality: FilterQuality.low,
                                                                      fit: BoxFit.fill,
                                                                      height: 300,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      if (postsC.bHomePagetModel.posts[index].postType == "video")
                                                        Container(
                                                          width: 350.aw,
                                                          decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            shadows: const [
                                                              BoxShadow(
                                                                color: Color(0x19000000),
                                                                blurRadius: 15,
                                                                offset: Offset(0, 10),
                                                                spreadRadius: 0,
                                                              )
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(20.0.adaptSize),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                10.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color: Colors.red.shade200,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(35)),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(35),
                                                                        child: SizedBox(
                                                                          height: 35,
                                                                          width: 35,
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: postsC.bHomePagetModel.posts[index].profileImage.toString(),
                                                                            placeholder: (context, url) => const Center(
                                                                                child: SizedBox(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: CircularProgressIndicator(
                                                                                      strokeWidth: 1,
                                                                                    ))),
                                                                            errorWidget: (context, url, error) =>
                                                                                Image.asset('assets/images/business_image_icon.png'),
                                                                            filterQuality: FilterQuality.low,
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    10.aw.widthBox,
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].businessName}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFF111111),
                                                                            fontSize: 14.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w600,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${postsC.bHomePagetModel.posts[index].createdAt!.day}-${postsC.bHomePagetModel.posts[index].createdAt!.month}-${postsC.posts[index].createdAt!.year}',
                                                                          style: TextStyle(
                                                                            color: const Color(0xFFAAAAAA),
                                                                            fontSize: 10.adaptSize,
                                                                            fontFamily: 'Inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            letterSpacing: -0.30,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    if ("$businessId" == postsC.bHomePagetModel.posts[index].businessId.toString())
                                                                      InkWell(
                                                                        onTap: () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                      title: const Text("Are you sure you want to delete this post?"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            deletePost(
                                                                                                postId: postsC.bHomePagetModel.posts[index].id.toString(),
                                                                                                context: context);
                                                                                            // setState(() {});
                                                                                            // myDealController.fetchPage(myDealController.pagingController.nextPageKey!);
                                                                                            // Navigator.pop(context);
                                                                                            // Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text("Yes",
                                                                                              style: TextStyle(color: Appcolor.Redpink, fontSize: 16)),
                                                                                        ),
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: const Text(
                                                                                              "No",
                                                                                              style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                                                                                            ))
                                                                                      ]));
                                                                        },
                                                                        child: const Icon(
                                                                          Icons.delete,
                                                                          color: Appcolor.Redpink,
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                Text(
                                                                  postsC.bHomePagetModel.posts[index].miniblogs != "default_miniblogs"
                                                                      ? '${postsC.bHomePagetModel.posts[index].miniblogs}'
                                                                      : "",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 12.adaptSize,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 0,
                                                                    letterSpacing: -0.30,
                                                                  ),
                                                                ),
                                                                15.ah.heightBox,
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: Vx.red100),
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: SizedBox(
                                                                      height: 200,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      child: VideoPlayerItem(videoUrl: postsC.bHomePagetModel.posts[index].post ?? ""),
                                                                    ),
                                                                  ),
                                                                ),
                                                                15.ah.heightBox,
                                                                // Text("${homePageNewController.posts[index].mentionsData!.length}"),
                                                                // SizedBox(
                                                                //   height: double.parse("${8 * postsC.bHomePagetModel.posts[index].mentionsData!.length}") + 20,
                                                                //   child: GridView(
                                                                //     physics: const NeverScrollableScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                                                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 30),
                                                                //     children: [
                                                                //       for (int i = 0;
                                                                //       postsC
                                                                //           .bHomePagetModel
                                                                //           .posts[
                                                                //       index]
                                                                //           .mentionsData!
                                                                //           .length >
                                                                //           i;
                                                                //       i++)
                                                                //         InkWell(
                                                                //           onTap: () {
                                                                //             Get.to(
                                                                //                   () => MatchDetails(
                                                                //                   id: postsC
                                                                //                       .bHomePagetModel
                                                                //                       .posts[index]
                                                                //                       .mentionsData![i]
                                                                //                       .id
                                                                //                       .toString()),
                                                                //             );
                                                                //           },
                                                                //           child:
                                                                //           Padding(
                                                                //             padding: const EdgeInsets
                                                                //                 .only(
                                                                //                 bottom:
                                                                //                 4.0),
                                                                //             child: Text(
                                                                //               "@${postsC.bHomePagetModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                //               style:
                                                                //               const TextStyle(
                                                                //                 color: Colors
                                                                //                     .blue,
                                                                //               ),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //     ],
                                                                //   ),
                                                                // ),

                                                                // like comment share row
                                                                15.ah.heightBox,
                                                                Row(
                                                                  children: [
                                                                    postsC.bHomePagetModel.posts[index].likedByUser == "Y"
                                                                        ? InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "N";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! - 1);
                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "0",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/heartwhite.svg"),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : InkWell(
                                                                            onTap: () {
                                                                              postsC.bHomePagetModel.posts[index].likedByUser = "Y";
                                                                              setState(() {
                                                                                postsC.bHomePagetModel.posts[index].totalLikes =
                                                                                    (postsC.bHomePagetModel.posts[index].totalLikes! + 1);

                                                                                likePost(
                                                                                  "${postsC.bHomePagetModel.posts[index].id}",
                                                                                  "1",
                                                                                );
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 40,
                                                                              decoration: ShapeDecoration(
                                                                                gradient: const LinearGradient(
                                                                                  begin: Alignment(0.00, -1.00),
                                                                                  end: Alignment(0, 1),
                                                                                  colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: SvgPicture.asset("assets/icons/pramod_unlike_icon.svg"),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                    20.widthBox,
                                                                    InkWell(
                                                                      onTap: () async {
                                                                        // homePageNewController.getAllCommentBYpostID(
                                                                        //     postID:
                                                                        //     '${postsC.bHomePagetModel.posts[index].id}',
                                                                        //     alreadlyLoad:
                                                                        //     true,
                                                                        //     indexx:
                                                                        //     index);
                                                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                        var userId = prefs.get('user_id');
                                                                        Get.to(() => BCommentPage(
                                                                              postId: '${postsC.bHomePagetModel.posts[index].id}',
                                                                              userId: '$userId',
                                                                              indexxx: index,
                                                                            ));
                                                                        print('posts${postsC.bHomePagetModel.posts[index].id}');
                                                                        print('posts${postsC.bHomePagetModel.posts[index].businessId}');
                                                                        print('posts$index');
                                                                        // homePageNewController.getAllCommentBYpostID(postID: '2', alreadlyLoad: true, indexx: 0);
                                                                      },
                                                                      child: Container(
                                                                        width: 40,
                                                                        height: 40,
                                                                        decoration: ShapeDecoration(
                                                                          gradient: const LinearGradient(
                                                                            begin: Alignment(0.00, -1.00),
                                                                            end: Alignment(0, 1),
                                                                            colors: [Color(0xFFF65F51), Color(0xFFFB4967)],
                                                                          ),
                                                                          shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(100),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: SvgPicture.asset("assets/icons/pramod_comment_icon.svg"),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    // InkWell(
                                                                    //   onTap: (){
                                                                    //     showDialog(
                                                                    //         context: context,
                                                                    //         builder: (BuildContext
                                                                    //         context) =>
                                                                    //             AlertDialog(
                                                                    //               title: const Text(
                                                                    //                   "Are you sure you want to Re-Share this Post?"),
                                                                    //               actions: [
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     uploadFileToServerUHome("${posts[index].post}","${posts[index].miniblogs}","${posts[index].postType}");
                                                                    //                     Navigator.pop(context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "Yes",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //                 TextButton(
                                                                    //                   onPressed:
                                                                    //                       () {
                                                                    //                     Navigator.pop(
                                                                    //                         context);
                                                                    //                   },
                                                                    //                   child:
                                                                    //                   const Text(
                                                                    //                     "No",
                                                                    //                     style: TextStyle(
                                                                    //                         color:
                                                                    //                         Appcolor.Redpink,
                                                                    //                         fontSize: 16),
                                                                    //                   ),
                                                                    //                 ),
                                                                    //               ],
                                                                    //             ));
                                                                    //   },
                                                                    //   child: Container(
                                                                    //     width: 40,
                                                                    //     height: 40,
                                                                    //     decoration: ShapeDecoration(
                                                                    //       gradient: const LinearGradient(
                                                                    //         begin: Alignment(0.00, -1.00),
                                                                    //         end: Alignment(0, 1),
                                                                    //         colors: [
                                                                    //           Color(0xFFF65F51),
                                                                    //           Color(0xFFFB4967)
                                                                    //         ],
                                                                    //       ),
                                                                    //       shape: RoundedRectangleBorder(
                                                                    //         borderRadius:
                                                                    //         BorderRadius.circular(100),
                                                                    //       ),
                                                                    //     ),
                                                                    //     child: Padding(
                                                                    //       padding: const EdgeInsets.all(8.0),
                                                                    //       child: SvgPicture.asset(
                                                                    //           "assets/icons/pramod_share_icon.svg"),
                                                                    //     ),
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                                15.ah.heightBox,
                                                                Text(
                                                                  '  ${postsC.bHomePagetModel.posts[index].totalLikes} likes',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 12.adaptSize,
                                                                    fontFamily: 'Inter',
                                                                    fontWeight: FontWeight.w500,
                                                                    height: 0,
                                                                    letterSpacing: -0.30,
                                                                  ),
                                                                ),
                                                                8.ah.heightBox,
                                                                postsC.bHomePagetModel.posts[index].totalComments == 0
                                                                    ? const SizedBox.shrink()
                                                                    : Text(
                                                                        '  View all ${postsC.bHomePagetModel.posts[index].totalComments} comment',
                                                                        style: TextStyle(
                                                                          color: const Color(0xFFAAAAAA),
                                                                          fontSize: 12.adaptSize,
                                                                          fontFamily: 'Inter',
                                                                          fontWeight: FontWeight.w500,
                                                                          height: 0,
                                                                          letterSpacing: -0.30,
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                                if (postsC.isLoadMoreRunning == true)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10, bottom: 40),
                                    child: Center(
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                // When nothing else to load
                                if (postsC.hasNextPage == false)
                                  Container(
                                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                                    child: const Center(
                                      child: Text('No more post found...!'),
                                    ),
                                  ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => const BuisnessPost());
                  }),
            ));
      },
    );
  }

  topDealsList(MyDealController controller) {
    print(controller.myDealsModel?.myDeals.length);
    return (controller.myDealsModel?.myDeals??[]).isEmpty || controller.myDealsModel?.myDeals.length == null
        ? Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              /*  // color: Colors.amber,*/
              child: const Text("No Deals Found !!"),
            ),
          )
        : Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.95,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.myDealsModel?.myDeals.length,
                  itemBuilder: (context, index) {
                    String result = '';
                    int value1 = int.tryParse(controller.myDealsModel!.myDeals[index].price.toString()) ?? 0;
                    int value2 = int.tryParse(controller.myDealsModel!.myDeals[index].discount.toString()) ?? 0;

                    int subtractionResult = value1 - value2;

                    result = 'Result: $subtractionResult';

                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => const EDIT_deal(),
                          arguments: index, // Replace with your index value
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 2.0,
                          child: Container(
                              // height: 168,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 120,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: controller.myDealsModel?.myDeals[index].roomImage ?? "",
                                        placeholder: (context, url) => const Center(
                                            child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ))),
                                        errorWidget: (context, url, error) => Image.asset(
                                          'assets/images/business_image_icon.png',
                                          scale: 3,
                                        ),
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.fill,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                  controller.myDealsModel?.myDeals[index].title == ""
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 5),
                                          child: ReadMoreText(
                                            controller.myDealsModel?.myDeals[index].title ?? "",
                                            trimLines: 2,
                                            colorClickableText: Colors.pink,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                            moreStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                          ),
                                          // customTextCommon(
                                          //   text:
                                          //       "${controller.myDealsModel?.myDeals[index].title}",
                                          //   fSize: 16,
                                          //   fWeight: FontWeight.w500,
                                          //   lineHeight: 16,
                                          // ),
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      customTextCommon(
                                        text: "\$${subtractionResult.toString() ?? ""}",
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lineHeight: 0,
                                        color: const Color(0xffFB4967),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "\$${controller.myDealsModel?.myDeals[index].price}",
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.grey,
                                          decorationThickness: 2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffAAAAAA),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }

  Future<void> deletePost({required String postId, required BuildContext context}) async {
    final response = await BaseClient01().post(Appurls.postDelete, {
      'post_id': postId.toString(),
    });
    var msg = response["message"];
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
    postsC.page.value = 1;
    postsC.hasNextPage.value = true;
    postsC.firstLoad();
    Navigator.pop(context);
  }

  Future<void> likePost(String postId, String likeStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
    print("post_id==>$postId");
    var data = {'post_id': postId, 'like_status': likeStatus};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/Like_business_post',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode("likeunlikeapi ${response.data}"));
      if (likeStatus == "1") {
        // sendNotification(user_id, "like");
      }
    } else {
      print(response.statusMessage);
    }
  }
}
