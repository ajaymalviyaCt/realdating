import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:realdating/Choose_subscription_plan/monthly.dart';
import 'package:realdating/home_page_new/home_page_user_controller.dart';
import 'package:realdating/widgets/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import '../function/function_class.dart';
import '../pages/createPostUser/createUserPost.dart';
import '../pages/explore/matches/matchDetsils.dart';
import '../pages/live/live/HomePage/homepage.dart';
import '../pages/mape/NearBy_businesses.dart';
import '../pages/notification_page/notification_page.dart';
import '../pages/profile/profile_controller.dart';
import '../pages/video_screen/video_player_iten.dart';
import '../pages/video_screen/video_screen.dart';
import '../reel/create_reel_video.dart';
import '../widgets/custom_text_styles.dart';
import 'comment_screen.dart';
import 'home_page_new_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key? key}) : super(key: key);

  @override
  State<HomePageUser> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageUser> {
  final HomePageNewController homePageNewController =
      Get.put(HomePageNewController());
  HomePageUserController postsC = Get.find<HomePageUserController>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageNewController.getPoll();
  }

  @override
  Widget build(BuildContext context) {
    print("posts.length${postsC.homePageModel.posts.length}");
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          postsC.page.value = 1;
          postsC.hasNextPage.value = true;
          postsC.firstLoad();
        },
        child: ListView(
          controller: postsC.controller,
          children: [
            20.heightBox,
            appbar(),
            20.heightBox,
            polls(),
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
                          () => postsC.homePageModel.posts.isEmpty
                              ? SizedBox(
                                  height: 300.ah,
                                  child: const Center(
                                    child: Text("No Post Found"),
                                  ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: postsC.homePageModel.posts.length,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          if (postsC.homePageModel.posts[index]
                                                  .postType ==
                                              "Image")
                                            Container(
                                              width: 350.aw,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                padding: EdgeInsets.all(
                                                    20.0.adaptSize),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    10.ah.heightBox,
                                                    postsC.homePageModel.posts[index].postOwnerInfo![0].proplan.toString() == "1" ?
                                                    Row(
                                                      children: [
                                                        Stack(
                                                            children:[

                                                              Padding(
                                                                padding:  EdgeInsets.only(top: 4),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        width: 2,
                                                                        color: Colors.yellow,),
                                                                      borderRadius: BorderRadius.circular(35)),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        35),
                                                                    child: SizedBox(
                                                                      height: 35,
                                                                      width: 35,
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        imageUrl: postsC
                                                                            .homePageModel
                                                                            .posts[
                                                                        index]
                                                                            .postOwnerInfo![
                                                                        0]
                                                                            .profileImage
                                                                            .toString(),
                                                                        placeholder: (context,
                                                                            url) =>
                                                                        const Center(
                                                                            child: SizedBox(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: CircularProgressIndicator(
                                                                                  strokeWidth: 1,
                                                                                ))),
                                                                        errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(Icons
                                                                            .person_2_outlined),
                                                                        filterQuality:
                                                                        FilterQuality
                                                                            .low,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 25),
                                                                child: Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: SvgPicture.asset("assets/icons/aa.svg"),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ) :
                                                    Row(
                                                      children: [
                                                        Stack(
                                                          children:[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    width: 2,
                                                                    color: Colors.red.shade300,),
                                                                  borderRadius: BorderRadius.circular(35)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    35),
                                                                child: SizedBox(
                                                                  height: 35,
                                                                  width: 35,
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    imageUrl: postsC.homePageModel.posts[index].postOwnerInfo![0].profileImage.toString(),
                                                                    placeholder: (context,
                                                                        url) =>
                                                                    const Center(
                                                                        child: SizedBox(
                                                                            height: 20,
                                                                            width: 20,
                                                                            child: CircularProgressIndicator(
                                                                              strokeWidth: 1,
                                                                            ))),
                                                                    errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .person_2_outlined),
                                                                    filterQuality:
                                                                    FilterQuality
                                                                        .low,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ),

                                                    15.ah.heightBox,
                                                    postsC.homePageModel.posts[index].miniblogs !=
                                                            "default_miniblogs"
                                                        ? Text(
                                                            '${postsC.homePageModel.posts[index].miniblogs}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  12.adaptSize,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                              letterSpacing:
                                                                  -0.30,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    15.ah.heightBox,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Vx.red100),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: postsC
                                                                .homePageModel
                                                                .posts[index]
                                                                .post
                                                                .toString(),
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child: SizedBox(
                                                                        height: 20,
                                                                        width: 20,
                                                                        child: CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              1,
                                                                        ))),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .person_2_outlined),
                                                            filterQuality:
                                                                FilterQuality
                                                                    .low,
                                                            fit: BoxFit.fill,
                                                            height: 300,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    20.ah.heightBox,
                                                    SizedBox(
                                                      height: double.parse(
                                                              "${8 * postsC.homePageModel.posts[index].mentionsData!.length}") +
                                                          20,
                                                      child: GridView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(
                                                                parent:
                                                                    NeverScrollableScrollPhysics()),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                mainAxisExtent:
                                                                    30),
                                                        children: [
                                                          for (int i = 0;
                                                              postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .mentionsData!
                                                                      .length >
                                                                  i;
                                                              i++)
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  () =>
                                                                      MatchDetails(
                                                                    id: postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .mentionsData![
                                                                            i]
                                                                        .id
                                                                        .toString(),
                                                                    isfriend:
                                                                        true,
                                                                  ),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            4.0),
                                                                child: Text(
                                                                  "@${postsC.homePageModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    15.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        postsC
                                                                    .homePageModel
                                                                    .posts[
                                                                        index]
                                                                    .likedByUser ==
                                                                "Y"
                                                            ? InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "N";
                                                                  setState(() {
                                                                    postsC.homePageModel.posts[index].totalLikes = (postsC.homePageModel.posts[index].totalLikes - 1);
                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        " ",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/heartwhite.svg"),
                                                                  ),
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "Y";
                                                                  setState(() {
                                                                    postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .totalLikes = (postsC
                                                                            .homePageModel
                                                                            .posts[index]
                                                                            .totalLikes +
                                                                        1);

                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        "1",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/pramod_unlike_icon.svg"),
                                                                  ),
                                                                ),
                                                              ),

                                                        20.widthBox,
                                                        InkWell(
                                                          onTap: () {
                                                            homePageNewController
                                                                .getAllCommentBYpostID(
                                                                    postID:
                                                                        '${postsC.homePageModel.posts[index].id}',
                                                                    alreadlyLoad:
                                                                        true,
                                                                    indexx:
                                                                        index);
                                                            Get.to(
                                                              () => CommentPage(
                                                                indexxx: index,
                                                                postId:
                                                                    '${postsC.homePageModel.posts[index].id}',
                                                                userId:
                                                                    '${postsC.homePageModel.posts[index].userId}',
                                                              ),
                                                            )?.then((value) {});
                                                          },
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin:
                                                                    Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end: Alignment(
                                                                    0, 1),
                                                                colors: [
                                                                  Color(
                                                                      0xFFF65F51),
                                                                  Color(
                                                                      0xFFFB4967)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/icons/pramod_comment_icon.svg"),
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        if ("${homePageNewController.userId}" !=
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          InkWell(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  const Monthly());
                                                            },
                                                            child: Container(
                                                              height: 70,
                                                              child: SvgPicture
                                                                  .asset("assets/images/pro_icon.svg"),
                                                            ),
                                                          )

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
                                                      '  ${postsC.homePageModel.posts[index].totalLikes} likes',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                    8.ah.heightBox,
                                                    Obx(
                                                      () => postsC.homePageModel.posts[index].totalComments==0?Text('comment', style: TextStyle(
                                                        color: const Color(
                                                            0xFFAAAAAA),
                                                        fontSize:
                                                        12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),):Text(
                                                        'View all ${postsC.homePageModel.posts[index].totalComments} comment',
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFFAAAAAA),
                                                          fontSize:
                                                              12.adaptSize,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                          letterSpacing: -0.30,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (postsC.homePageModel.posts[index]
                                                  .postType ==
                                              "miniBlog")
                                            Container(
                                              width: 350.aw,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                padding: EdgeInsets.all(
                                                    20.0.adaptSize),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    10.ah.heightBox,
                                                    // Row(
                                                    //   children: [
                                                    //     Container(
                                                    //       decoration: BoxDecoration(
                                                    //           border: Border.all(
                                                    //               color: Colors
                                                    //                   .red),
                                                    //           borderRadius:
                                                    //               BorderRadius
                                                    //                   .circular(
                                                    //                       35)),
                                                    //       child: ClipRRect(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(
                                                    //                     35),
                                                    //         child: SizedBox(
                                                    //           height: 35,
                                                    //           width: 35,
                                                    //           child:
                                                    //               CachedNetworkImage(
                                                    //             imageUrl: postsC
                                                    //                 .homePageModel
                                                    //                 .posts[
                                                    //                     index]
                                                    //                 .postOwnerInfo![
                                                    //                     0]
                                                    //                 .profileImage
                                                    //                 .toString(),
                                                    //             placeholder: (context,
                                                    //                     url) =>
                                                    //                 const Center(
                                                    //                     child: SizedBox(
                                                    //                         height: 20,
                                                    //                         width: 20,
                                                    //                         child: CircularProgressIndicator(
                                                    //                           strokeWidth: 1,
                                                    //                         ))),
                                                    //             errorWidget: (context,
                                                    //                     url,
                                                    //                     error) =>
                                                    //                 const Icon(Icons
                                                    //                     .person_2_outlined),
                                                    //             filterQuality:
                                                    //                 FilterQuality
                                                    //                     .low,
                                                    //             fit:
                                                    //                 BoxFit.fill,
                                                    //             height: 300,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //     10.aw.widthBox,
                                                    //     Column(
                                                    //       crossAxisAlignment:
                                                    //           CrossAxisAlignment
                                                    //               .start,
                                                    //       children: [
                                                    //         Text(
                                                    //           '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                    //           style: TextStyle(
                                                    //             color: const Color(
                                                    //                 0xFF111111),
                                                    //             fontSize: 14
                                                    //                 .adaptSize,
                                                    //             fontFamily:
                                                    //                 'Inter',
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w600,
                                                    //             letterSpacing:
                                                    //                 -0.30,
                                                    //           ),
                                                    //         ),
                                                    //         Text(
                                                    //           '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                    //           style: TextStyle(
                                                    //             color: const Color(
                                                    //                 0xFFAAAAAA),
                                                    //             fontSize: 10
                                                    //                 .adaptSize,
                                                    //             fontFamily:
                                                    //                 'Inter',
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w500,
                                                    //             letterSpacing:
                                                    //                 -0.30,
                                                    //           ),
                                                    //         )
                                                    //       ],
                                                    //     ),
                                                    //     Spacer(),
                                                    //     if ("${homePageNewController.userId}" ==
                                                    //         "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                    //       deletePost(index)
                                                    //   ],
                                                    // ),

                                                    postsC.homePageModel.posts[index].postOwnerInfo![0].proplan.toString() == "1" ?
                                                    Row(
                                                      children: [
                                                        Stack(
                                                            children:[

                                                              Padding(
                                                                padding:  EdgeInsets.only(top: 4),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        width: 2,
                                                                        color: Colors.yellow,),
                                                                      borderRadius: BorderRadius.circular(35)),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        35),
                                                                    child: SizedBox(
                                                                      height: 35,
                                                                      width: 35,
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        imageUrl: postsC
                                                                            .homePageModel
                                                                            .posts[
                                                                        index]
                                                                            .postOwnerInfo![
                                                                        0]
                                                                            .profileImage
                                                                            .toString(),
                                                                        placeholder: (context,
                                                                            url) =>
                                                                        const Center(
                                                                            child: SizedBox(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: CircularProgressIndicator(
                                                                                  strokeWidth: 1,
                                                                                ))),
                                                                        errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(Icons
                                                                            .person_2_outlined),
                                                                        filterQuality:
                                                                        FilterQuality
                                                                            .low,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 25),
                                                                child: Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: SvgPicture.asset("assets/icons/aa.svg"),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ) :
                                                    Row(
                                                      children: [
                                                        Stack(
                                                            children:[
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                      width: 2,
                                                                      color: Colors.red.shade300,),
                                                                    borderRadius: BorderRadius.circular(35)),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      35),
                                                                  child: SizedBox(
                                                                    height: 35,
                                                                    width: 35,
                                                                    child:
                                                                    CachedNetworkImage(
                                                                      imageUrl: postsC.homePageModel.posts[index].postOwnerInfo![0].profileImage.toString(),
                                                                      placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child: SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 1,
                                                                              ))),
                                                                      errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(Icons
                                                                          .person_2_outlined),
                                                                      filterQuality:
                                                                      FilterQuality
                                                                          .low,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ),
                                                    15.ah.heightBox,
                                                    postsC
                                                                .homePageModel
                                                                .posts[index]
                                                                .miniblogs !=
                                                            "default_miniblogs"
                                                        ? Text(
                                                            '${postsC.homePageModel.posts[index].miniblogs}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  16.adaptSize,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                              letterSpacing:
                                                                  -0.30,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    15.ah.heightBox,
                                                    SizedBox(
                                                      height: double.parse(
                                                              "${10 * postsC.homePageModel.posts[index].mentionsData!.length}") +
                                                          20,
                                                      child: GridView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(
                                                                parent:
                                                                    NeverScrollableScrollPhysics()),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                mainAxisExtent:
                                                                    30),
                                                        children: [
                                                          for (int i = 0;
                                                              postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .mentionsData!
                                                                      .length >
                                                                  i;
                                                              i++)
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  () => MatchDetails(
                                                                      isfriend:
                                                                          true,
                                                                      id: postsC
                                                                          .homePageModel
                                                                          .posts[
                                                                              index]
                                                                          .mentionsData![
                                                                              i]
                                                                          .id
                                                                          .toString()),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            4.0),
                                                                child: Text(
                                                                  "@${postsC.homePageModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    15.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        postsC
                                                                    .homePageModel
                                                                    .posts[
                                                                        index]
                                                                    .likedByUser ==
                                                                "Y"
                                                            ? InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "N";
                                                                  setState(() {
                                                                    postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .totalLikes = (postsC
                                                                            .homePageModel
                                                                            .posts[index]
                                                                            .totalLikes -
                                                                        1);

                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        "0",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/heartwhite.svg"),
                                                                  ),
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "Y";
                                                                  setState(() {
                                                                    postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .totalLikes = (postsC
                                                                            .homePageModel
                                                                            .posts[index]
                                                                            .totalLikes +
                                                                        1);

                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        "1",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/pramod_unlike_icon.svg"),
                                                                  ),
                                                                ),
                                                              ),

                                                        20.widthBox,
                                                        InkWell(
                                                          onTap: () {
                                                            homePageNewController
                                                                .getAllCommentBYpostID(
                                                              postID:
                                                                  '${postsC.homePageModel.posts[index].id}',
                                                              alreadlyLoad:
                                                                  true,
                                                              indexx: index,
                                                            );
                                                            Get.to(
                                                              () => CommentPage(
                                                                postId:
                                                                    '${postsC.homePageModel.posts[index].id}',
                                                                userId:
                                                                    '${postsC.homePageModel.posts[index].userId}',
                                                                indexxx: index,
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin:
                                                                    Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end: Alignment(
                                                                    0, 1),
                                                                colors: [
                                                                  Color(
                                                                      0xFFF65F51),
                                                                  Color(
                                                                      0xFFFB4967)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/icons/pramod_comment_icon.svg"),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        if ("${homePageNewController.userId}" !=
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          InkWell(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  const Monthly());
                                                            },
                                                            child: Container(
                                                              height: 70,
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/images/pro_icon.svg"),
                                                            ),
                                                          )

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
                                                      '  ${postsC.homePageModel.posts[index].totalLikes} likes',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                    8.ah.heightBox,
                                                    Text(
                                                      '  View all ${postsC.homePageModel.posts[index].totalComments} comment',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFFAAAAAA),
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (postsC.homePageModel.posts[index]
                                                  .postType ==
                                              "AD")
                                            Container(
                                              width: 350.aw,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                padding: EdgeInsets.all(
                                                    20.0.adaptSize),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          35)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        35),
                                                            child: SizedBox(
                                                              height: 35,
                                                              width: 35,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: postsC
                                                                    .homePageModel
                                                                    .posts[
                                                                        index]
                                                                    .adImage
                                                                    .toString(),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Center(
                                                                        child: SizedBox(
                                                                            height: 20,
                                                                            width: 20,
                                                                            child: CircularProgressIndicator(
                                                                              strokeWidth: 1,
                                                                            ))),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .person_2_outlined),
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .low,
                                                                fit:
                                                                    BoxFit.fill,
                                                                height: 300,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].title}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 0,
                                                                letterSpacing:
                                                                    -0.30,
                                                              ),
                                                            ),
                                                            6.heightBox,
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].createdAt}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height: 0,
                                                                letterSpacing:
                                                                    -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    10.heightBox,
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: postsC
                                                              .homePageModel
                                                              .posts[index]
                                                              .adImage
                                                              .toString(),
                                                          placeholder: (context,
                                                                  url) =>
                                                              const Center(
                                                                  child: SizedBox(
                                                                      height: 20,
                                                                      width: 20,
                                                                      child: CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            1,
                                                                      ))),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(Icons
                                                                  .person_2_outlined),
                                                          filterQuality:
                                                              FilterQuality.low,
                                                          fit: BoxFit.fill,
                                                          height: 300,
                                                        ),
                                                      ),
                                                    ),
                                                    5.heightBox,
                                                    InkWell(
                                                        onTap: () {
                                                          try {
                                                            _launchURL(
                                                                '${postsC.homePageModel.posts[index].link}');
                                                          } catch (e) {
                                                            print(
                                                                "${e.toString()}");
                                                          }
                                                        },
                                                        child: Text(
                                                          "${postsC.homePageModel.posts[index].link}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (postsC.homePageModel.posts[index]
                                                  .postType ==
                                              "video")
                                            Container(
                                              width: 350.aw,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                padding: EdgeInsets.all(
                                                    20.0.adaptSize),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    10.ah.heightBox,
                                                    postsC.homePageModel.posts[index].postOwnerInfo![0].proplan.toString() == "1" ?
                                                    Row(
                                                      children: [
                                                        Stack(
                                                            children:[

                                                              Padding(
                                                                padding:  EdgeInsets.only(top: 4),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        width: 2,
                                                                        color: Colors.yellow,),
                                                                      borderRadius: BorderRadius.circular(35)),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        35),
                                                                    child: SizedBox(
                                                                      height: 35,
                                                                      width: 35,
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        imageUrl: postsC
                                                                            .homePageModel
                                                                            .posts[
                                                                        index]
                                                                            .postOwnerInfo![
                                                                        0]
                                                                            .profileImage
                                                                            .toString(),
                                                                        placeholder: (context,
                                                                            url) =>
                                                                        const Center(
                                                                            child: SizedBox(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: CircularProgressIndicator(
                                                                                  strokeWidth: 1,
                                                                                ))),
                                                                        errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(Icons
                                                                            .person_2_outlined),
                                                                        filterQuality:
                                                                        FilterQuality
                                                                            .low,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 25),
                                                                child: Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: SvgPicture.asset("assets/icons/aa.svg"),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ) :
                                                    Row(
                                                      children: [
                                                        Stack(
                                                            children:[
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                      width: 2,
                                                                      color: Colors.red.shade300,),
                                                                    borderRadius: BorderRadius.circular(35)),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      35),
                                                                  child: SizedBox(
                                                                    height: 35,
                                                                    width: 35,
                                                                    child:
                                                                    CachedNetworkImage(
                                                                      imageUrl: postsC.homePageModel.posts[index].postOwnerInfo![0].profileImage.toString(),
                                                                      placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child: SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 1,
                                                                              ))),
                                                                      errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(Icons
                                                                          .person_2_outlined),
                                                                      filterQuality:
                                                                      FilterQuality
                                                                          .low,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                        10.aw.widthBox,
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF111111),
                                                                fontSize: 14
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFAAAAAA),
                                                                fontSize: 10
                                                                    .adaptSize,
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                letterSpacing:
                                                                -0.30,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),

                                                        if ("${homePageNewController.userId}" ==
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          deletePost(index),

                                                        //   InkWell(
                                                        //       onTap: () {
                                                        //         print("sdfsdf");
                                                        //         deletePost(index);
                                                        //         // homePageNewController.deletePostUser("${posts[index].id}");
                                                        //         // homePageNewController.getPostHomePage();
                                                        //       },
                                                        //       child: Icon(Icons.delete,))
                                                      ],
                                                    ),

                                                    // Row(
                                                    //   children: [
                                                    //     Container(
                                                    //       decoration:
                                                    //           BoxDecoration(
                                                    //               border: Border
                                                    //                   .all(
                                                    //                 color: Colors
                                                    //                     .red
                                                    //                     .shade200,
                                                    //               ),
                                                    //               borderRadius:
                                                    //                   BorderRadius
                                                    //                       .circular(
                                                    //                           35)),
                                                    //       child: ClipRRect(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(
                                                    //                     35),
                                                    //         child: SizedBox(
                                                    //           height: 35,
                                                    //           width: 35,
                                                    //           child:
                                                    //               CachedNetworkImage(
                                                    //             imageUrl: postsC
                                                    //                 .homePageModel
                                                    //                 .posts[
                                                    //                     index]
                                                    //                 .postOwnerInfo![
                                                    //                     0]
                                                    //                 .profileImage
                                                    //                 .toString(),
                                                    //             placeholder: (context,
                                                    //                     url) =>
                                                    //                 const Center(
                                                    //                     child: SizedBox(
                                                    //                         height: 20,
                                                    //                         width: 20,
                                                    //                         child: CircularProgressIndicator(
                                                    //                           strokeWidth: 1,
                                                    //                         ))),
                                                    //             errorWidget: (context,
                                                    //                     url,
                                                    //                     error) =>
                                                    //                 const Icon(Icons
                                                    //                     .person_2_outlined),
                                                    //             filterQuality:
                                                    //                 FilterQuality
                                                    //                     .low,
                                                    //             fit: BoxFit
                                                    //                 .cover,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //     10.aw.widthBox,
                                                    //     Column(
                                                    //       crossAxisAlignment:
                                                    //           CrossAxisAlignment
                                                    //               .start,
                                                    //       children: [
                                                    //         Text(
                                                    //           '${postsC.homePageModel.posts[index].postOwnerInfo![0].firstName} ${postsC.homePageModel.posts[index].postOwnerInfo![0].lastName}',
                                                    //           style: TextStyle(
                                                    //             color: const Color(
                                                    //                 0xFF111111),
                                                    //             fontSize: 14
                                                    //                 .adaptSize,
                                                    //             fontFamily:
                                                    //                 'Inter',
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w600,
                                                    //             letterSpacing:
                                                    //                 -0.30,
                                                    //           ),
                                                    //         ),
                                                    //         Text(
                                                    //           '${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.day}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.month}-${postsC.homePageModel.posts[index].postOwnerInfo?[0].createdAt!.year}',
                                                    //           style: TextStyle(
                                                    //             color: const Color(
                                                    //                 0xFFAAAAAA),
                                                    //             fontSize: 10
                                                    //                 .adaptSize,
                                                    //             fontFamily:
                                                    //                 'Inter',
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w500,
                                                    //             letterSpacing:
                                                    //                 -0.30,
                                                    //           ),
                                                    //         )
                                                    //       ],
                                                    //     ),
                                                    //     Spacer(),
                                                    //     if ("${homePageNewController.userId}" ==
                                                    //         "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                    //       deletePost(index)
                                                    //     // InkWell(
                                                    //     //     onTap: () {
                                                    //     //       homePageNewController.deletePostUser(
                                                    //     //           "${homePageNewController.posts[index].id}");
                                                    //     //       homePageNewController
                                                    //     //           .getPostHomePage();
                                                    //     //     },
                                                    //     //     child: Icon(Icons.delete))
                                                    //   ],
                                                    // ),
                                                    15.ah.heightBox,
                                                    Text(
                                                      postsC
                                                                  .homePageModel
                                                                  .posts[index]
                                                                  .miniblogs !=
                                                              "default_miniblogs"
                                                          ? '${postsC.homePageModel.posts[index].miniblogs}'
                                                          : "",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                    15.ah.heightBox,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Vx.red100),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: SizedBox(
                                                          height: 200,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: VideoPlayerItem(
                                                              videoUrl: postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .post ??
                                                                  ""),
                                                        ),
                                                      ),
                                                    ),
                                                    15.ah.heightBox,
                                                    // Text("${homePageNewController.posts[index].mentionsData!.length}"),
                                                    SizedBox(
                                                      height: double.parse(
                                                              "${8 * postsC.homePageModel.posts[index].mentionsData!.length}") +
                                                          20,
                                                      child: GridView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(
                                                                parent:
                                                                    NeverScrollableScrollPhysics()),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                mainAxisExtent:
                                                                    30),
                                                        children: [
                                                          for (int i = 0;
                                                              postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .mentionsData!
                                                                      .length >
                                                                  i;
                                                              i++)
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  () => MatchDetails(
                                                                      isfriend:
                                                                          true,
                                                                      id: postsC
                                                                          .homePageModel
                                                                          .posts[
                                                                              index]
                                                                          .mentionsData![
                                                                              i]
                                                                          .id
                                                                          .toString()),
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            4.0),
                                                                child: Text(
                                                                  "@${postsC.homePageModel.posts[index].mentionsData?[i].firstName ?? "asdcfv"}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),

                                                    // like comment share row
                                                    15.ah.heightBox,
                                                    Row(
                                                      children: [
                                                        postsC
                                                                    .homePageModel
                                                                    .posts[
                                                                        index]
                                                                    .likedByUser ==
                                                                "Y"
                                                            ? InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "N";
                                                                  setState(() {
                                                                    postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .totalLikes = (postsC
                                                                            .homePageModel
                                                                            .posts[index]
                                                                            .totalLikes -
                                                                        1);
                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        "0",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/heartwhite.svg"),
                                                                  ),
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  postsC
                                                                      .homePageModel
                                                                      .posts[
                                                                          index]
                                                                      .likedByUser = "Y";
                                                                  setState(() {
                                                                    postsC
                                                                        .homePageModel
                                                                        .posts[
                                                                            index]
                                                                        .totalLikes = (postsC
                                                                            .homePageModel
                                                                            .posts[index]
                                                                            .totalLikes +
                                                                        1);

                                                                    homePageNewController.likePost(
                                                                        "${postsC.homePageModel.posts[index].id}",
                                                                        "1",
                                                                        "${postsC.homePageModel.posts[index].userId}");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment(
                                                                          0.00,
                                                                          -1.00),
                                                                      end: Alignment(
                                                                          0, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFF65F51),
                                                                        Color(
                                                                            0xFFFB4967)
                                                                      ],
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/icons/pramod_unlike_icon.svg"),
                                                                  ),
                                                                ),
                                                              ),

                                                        20.widthBox,
                                                        InkWell(
                                                          onTap: () {
                                                            homePageNewController
                                                                .getAllCommentBYpostID(
                                                                    postID:
                                                                        '${postsC.homePageModel.posts[index].id}',
                                                                    alreadlyLoad:
                                                                        true,
                                                                    indexx:
                                                                        index);
                                                            Get.to(
                                                              () => CommentPage(
                                                                postId:
                                                                    '${postsC.homePageModel.posts[index].id}',
                                                                userId:
                                                                    '${postsC.homePageModel.posts[index].userId}',
                                                                indexxx: index,
                                                              ),
                                                            )?.then((value) {});
                                                          },
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin:
                                                                    Alignment(
                                                                        0.00,
                                                                        -1.00),
                                                                end: Alignment(
                                                                    0, 1),
                                                                colors: [
                                                                  Color(
                                                                      0xFFF65F51),
                                                                  Color(
                                                                      0xFFFB4967)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/icons/pramod_comment_icon.svg"),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        if ("${homePageNewController.userId}" !=
                                                            "${postsC.homePageModel.posts[index].postOwnerInfo![0].id}")
                                                          InkWell(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  const Monthly());
                                                            },
                                                            child: Container(
                                                              height: 70,
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/images/pro_icon.svg"),
                                                            ),
                                                          )
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
                                                      '  ${postsC.homePageModel.posts[index].totalLikes} likes',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                    8.ah.heightBox,
                                                    Text(
                                                      '  View all ${postsC.homePageModel.posts[index].totalComments} comment',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFFAAAAAA),
                                                        fontSize: 12.adaptSize,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
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
    ));
  }


  Widget polls() {
    return Obx(() => homePageNewController.isLoadingGetPoll.value
        ? const SizedBox(
            height: 200,
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )))
        : isVoted());
  }

  Widget isVoted() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 360,
          width: 320.aw,
        ),
        Positioned(
          top: 20,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: SizedBox(
              height: 320,
              width: 340.aw,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          '${homePageNewController.pollsModel!.polls?.ownerFirstName} ${homePageNewController.pollsModel!.polls?.ownerLastName}',
                          style: const TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      20.heightBox,
                      Center(
                        child: Text(
                          'What do you like on date?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.adaptSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      20.heightBox,
                      Obx(
                        () => Text(
                          "${homePageNewController.poll_option_1.value}  (${homePageNewController.isVoted.value ? ((homePageNewController.poll1Persent.value) * 100).toStringAsFixed(2) : 0} %)",
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 14.adaptSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      10.heightBox,
                      InkWell(
                        onTap: () {
                          print(
                              "isVoted${homePageNewController.isVoted.value}");

                          if (homePageNewController.isVoted.value == false) {
                            homePageNewController.isVoted.value = true;
                            homePageNewController.poll_option_1_count.value =
                                homePageNewController
                                        .poll_option_1_count.value +
                                    1;

                            homePageNewController.pollVote(
                                option1: 1,
                                owner_id:
                                    '${homePageNewController.pollsModel!.polls!.userId}',
                                poll_id:
                                    '${homePageNewController.pollsModel!.polls!.id}');
                          }

                          homePageNewController
                              .totalVotes.value = homePageNewController
                                  .poll_option_1_count.value +
                              homePageNewController.poll_option_2_count.value +
                              homePageNewController.poll_option_3_count.value;

                          homePageNewController.poll1Persent.value =
                              homePageNewController.poll_option_1_count.value /
                                  homePageNewController.totalVotes.value;
                          homePageNewController.poll2Persent.value =
                              homePageNewController.poll_option_2_count.value /
                                  homePageNewController.totalVotes.value;
                          homePageNewController.poll3Persent.value =
                              homePageNewController.poll_option_3_count.value /
                                  homePageNewController.totalVotes.value;
                        },
                        //1st
                        child: Obx(
                          () => LinearProgressIndicator(
                            color: const Color(0xFFF65F51),
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(100),
                            value: homePageNewController.isVoted.value
                                ? homePageNewController.poll1Persent.value
                                : 0,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Obx(
                        () => Text(
                          "${homePageNewController.poll_option_2.value} (${homePageNewController.isVoted.value ? ((homePageNewController.poll2Persent.value) * 100).toStringAsFixed(2) : 0} %)",
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 14.adaptSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Obx(
                        () => InkWell(
                          onTap: () {
                            //2nd

                            if (homePageNewController.isVoted.value == false) {
                              homePageNewController.isVoted.value = true;

                              homePageNewController.poll_option_2_count.value =
                                  homePageNewController
                                          .poll_option_2_count.value +
                                      1;
                              homePageNewController.pollVote(
                                  option1: 2,
                                  owner_id:
                                      '${homePageNewController.pollsModel!.polls!.userId}',
                                  poll_id:
                                      '${homePageNewController.pollsModel!.polls!.id}');
                            }

                            homePageNewController
                                .totalVotes.value = homePageNewController
                                    .poll_option_1_count.value +
                                homePageNewController
                                    .poll_option_2_count.value +
                                homePageNewController.poll_option_3_count.value;

                            homePageNewController.poll1Persent.value =
                                homePageNewController
                                        .poll_option_1_count.value /
                                    homePageNewController.totalVotes.value;
                            homePageNewController.poll2Persent.value =
                                homePageNewController
                                        .poll_option_2_count.value /
                                    homePageNewController.totalVotes.value;
                            homePageNewController.poll3Persent.value =
                                homePageNewController
                                        .poll_option_3_count.value /
                                    homePageNewController.totalVotes.value;
                          },
                          child: LinearProgressIndicator(
                              color: const Color(0xFFF65F51),
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(100),
                              value: homePageNewController.isVoted.value
                                  ? homePageNewController.poll2Persent.value
                                  : 0),
                        ),
                      ),
                      10.heightBox,
                      Obx(
                        () => Text(
                          "${homePageNewController.poll_option_3.value}(${homePageNewController.isVoted.value ? ((homePageNewController.poll3Persent.value * 100)).toStringAsFixed(2) : 0} %)",
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 14.adaptSize,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      10.heightBox,
                      Obx(
                        () => InkWell(
                          onTap: () {
                            //3nd

                            if (homePageNewController.isVoted.value == false) {
                              homePageNewController.isVoted.value = true;
                              homePageNewController.poll_option_3_count.value =
                                  homePageNewController
                                          .poll_option_3_count.value +
                                      1;
                              homePageNewController.pollVote(
                                  option1: 3,
                                  owner_id:
                                      '${homePageNewController.pollsModel!.polls!.userId}',
                                  poll_id:
                                      '${homePageNewController.pollsModel!.polls!.id}');
                            }

                            homePageNewController
                                .totalVotes.value = homePageNewController
                                    .poll_option_1_count.value +
                                homePageNewController
                                    .poll_option_2_count.value +
                                homePageNewController.poll_option_3_count.value;
                            homePageNewController.poll1Persent.value =
                                homePageNewController
                                        .poll_option_1_count.value /
                                    homePageNewController.totalVotes.value;
                            homePageNewController.poll2Persent.value =
                                homePageNewController
                                        .poll_option_2_count.value /
                                    homePageNewController.totalVotes.value;
                            homePageNewController.poll3Persent.value =
                                homePageNewController
                                        .poll_option_3_count.value /
                                    homePageNewController.totalVotes.value;
                          },
                          child: LinearProgressIndicator(
                              color: const Color(0xFFF65F51),
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(100),
                              value: homePageNewController.isVoted.value
                                  ? homePageNewController.poll3Persent.value
                                  : 0),
                        ),
                      ),
                      10.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Vx.red100),
              image: DecorationImage(
                  image: NetworkImage(
                      "${homePageNewController.pollsModel!.polls!.profileImage}"),
                  fit: BoxFit.cover)),
          height: 50,
          width: 50,
        )
      ],
    );
  }

  // Widget isNotVoted() {
  //   return Stack(
  //     alignment: Alignment.topCenter,
  //     children: [
  //       const SizedBox(
  //         height: 360,
  //         width: 320,
  //       ),
  //       Positioned(
  //         top: 20,
  //         child: Card(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           elevation: 4,
  //           surfaceTintColor: Colors.white,
  //           color: Colors.white,
  //           child: SizedBox(
  //             height: 320,
  //             width: 320,
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 10, right: 10),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(15.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                     Center(
  //                       child: Text(
  //                         '${homePageNewController.pollsModel!.polls?.ownerFirstName} ${homePageNewController.pollsModel!.polls?.ownerLastName}',
  //                         style: const TextStyle(
  //                           color: Color(0xFF111111),
  //                           fontSize: 14,
  //                           fontFamily: 'Inter',
  //                           fontWeight: FontWeight.w600,
  //                           height: 0,
  //                           letterSpacing: -0.30,
  //                         ),
  //                       ),
  //                     ),
  //                     20.heightBox,
  //                     Center(
  //                       child: Text(
  //                         'What do you like on date?',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 22.adaptSize,
  //                           fontFamily: 'Inter',
  //                           fontWeight: FontWeight.w600,
  //                           letterSpacing: -0.30,
  //                         ),
  //                       ),
  //                     ),
  //                     20.heightBox,
  //                     Text(
  //                       '${homePageNewController.pollsModel!.polls?.pollOption1}',
  //                       style: TextStyle(
  //                         color: const Color(0xFF111111),
  //                         fontSize: 14.adaptSize,
  //                         fontFamily: 'Inter',
  //                         fontWeight: FontWeight.w600,
  //                         height: 0,
  //                         letterSpacing: -0.30,
  //                       ),
  //                     ),
  //                     10.heightBox,
  //                     InkWell(
  //                       onTap: () {
  //                         homePageNewController.pollVote(
  //                             option1: 1,
  //                             owner_id:
  //                                 '${homePageNewController.pollsModel!.polls!.userId}',
  //                             poll_id:
  //                                 '${homePageNewController.pollsModel!.polls!.id}');
  //                       },
  //                       child: LinearProgressIndicator(
  //                           color: const Color(0xFFF65F51),
  //                           minHeight: 15.ah,
  //                           borderRadius: BorderRadius.circular(100),
  //                           value: 0),
  //                     ),
  //                     10.heightBox,
  //                     Text(
  //                       "${homePageNewController.pollsModel!.polls!.pollOption2}",
  //                       style: TextStyle(
  //                         color: const Color(0xFF111111),
  //                         fontSize: 14.adaptSize,
  //                         fontFamily: 'Inter',
  //                         fontWeight: FontWeight.w600,
  //                         height: 0,
  //                         letterSpacing: -0.30,
  //                       ),
  //                     ),
  //                     10.heightBox,
  //                     InkWell(
  //                       onTap: () {
  //                         homePageNewController.pollVote(
  //                             option1: 2,
  //                             owner_id:
  //                                 '${homePageNewController.pollsModel!.polls!.userId}',
  //                             poll_id:
  //                                 '${homePageNewController.pollsModel!.polls!.id}');
  //                       },
  //                       child: LinearProgressIndicator(
  //                         color: const Color(0xFFF65F51),
  //                         minHeight: 15.ah,
  //                         borderRadius: BorderRadius.circular(100),
  //                         value: 0,
  //                       ),
  //                     ),
  //                     10.heightBox,
  //                     Text(
  //                       "${homePageNewController.pollsModel!.polls!.pollOption3!}",
  //                       style: TextStyle(
  //                         color: const Color(0xFF111111),
  //                         fontSize: 14.adaptSize,
  //                         fontFamily: 'Inter',
  //                         fontWeight: FontWeight.w600,
  //                         height: 0,
  //                         letterSpacing: -0.30,
  //                       ),
  //                     ),
  //                     10.heightBox,
  //                     InkWell(
  //                       onTap: () {
  //                         homePageNewController.pollVote(
  //                             option1: 1,
  //                             owner_id:
  //                                 '${homePageNewController.pollsModel!.polls!.userId}',
  //                             poll_id:
  //                                 '${homePageNewController.pollsModel!.polls!.id}');
  //                       },
  //                       child: LinearProgressIndicator(
  //                           color: const Color(0xFFF65F51),
  //                           minHeight: 15.ah,
  //                           borderRadius: BorderRadius.circular(100),
  //                           value: 0),
  //                     ),
  //                     10.heightBox,
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(40),
  //             border: Border.all(color: Vx.red100),
  //             image: DecorationImage(
  //                 image: NetworkImage(
  //                     "${homePageNewController.pollsModel!.polls!.profileImage}"),
  //                 fit: BoxFit.cover)),
  //         height: 50,
  //         width: 50,
  //       )
  //     ],
  //   );
  // }

  Widget appbar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent.shade200),
                  borderRadius: BorderRadius.circular(35)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: profileController.profileImage.value,
                    placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person_2_outlined),
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextCommon(
                  text: "Hello,",
                  fSize: 22.adaptSize,
                  fWeight: FontWeight.w500,
                  lineHeight: 21,
                  color: const Color(0xffAAAAAA),
                ),
                customTextCommon(
                  text: profileController.firstName.value,
                  fSize: 24.adaptSize,
                  fWeight: FontWeight.w600,
                  lineHeight: 29,
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoScreen(),
                  ));
                  // Get.off(() => VideoScreen());
                },
                icon: SvgPicture.asset(
                  'assets/icons/Iconvideo.svg',
                ),
              ),
              PopupMenuButton(
                surfaceTintColor: Colors.white,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 1,
                    // row with 2 children
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(
                          context,
                        );
                        Get.to(() => UserCreatePost());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Icon(Icons.post_add), Text('    Post')],
                      ),
                      //Text("Block")
                    ),
                  ),
                  // PopupMenuItem 2
                  PopupMenuItem(
                    value: 2,
                    // row with two children
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => const CreateReelScreen(),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.play_circle_fill_outlined),
                          Text('   Create Reel')
                        ],
                      ),
                    ),
                  ),

                  PopupMenuItem(
                    value: 2,
                    // row with two children
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => const HomePage(),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.video_camera_back_rounded),
                          Text('    Live Stream'),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    // row with two children
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => NearByBusiness(),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_history),
                          Text('    Explore restaurant'),
                        ],
                      ),
                    ),
                  ),
                ],
                child: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const NotificationPage());
                },
                icon: SvgPicture.asset('assets/icons/notification.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  deletePost(index) {
    return InkWell(
      onTap: () {
        print("deleteeee");
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title:
                      const Text("Are you sure you want to Delete this Post?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        homePageNewController.deletePostUser(
                            "${postsC.homePageModel.posts[index].id}");

                        // homePageNewController.getPostHomePage();
                        Navigator.pop(context);
                        setState(() {
                          postsC.firstLoad();
                        });
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                      ),
                    ),
                  ],
                ));
      },
      child: Container(
        width: 40,
        height: 40,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.delete),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
