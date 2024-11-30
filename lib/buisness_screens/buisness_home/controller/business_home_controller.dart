import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:realdating/buisness_screens/buisness_home/model/allBusinessPost_model.dart';
import 'package:realdating/buisness_screens/buisness_home/model/myDealModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../consts/app_urls.dart';
import '../../../pages/swipcard/swip_controller.dart';
import '../../../services/base_client01.dart';
import '../../buisness_dashboard/widget/dashbord_model.dart';
import '../Bhome_page/buisness_home.dart';
import '../model/getCommentModel.dart';
import '../model/videoModel.dart';

class MyDealController extends GetxController implements GetxService {
  RxBool isLoadig = false.obs;
  RxBool isLoadigPostComment = false.obs;
  RxBool isLoadigDeal = false.obs;
  RxBool isLoadigHome = false.obs;
  RxBool isLoadigComment = false.obs;
  MyDealsModel? myDealsModel;
  TextEditingController dealText = TextEditingController();
  RxBool cont = false.obs;
  var data = <String>[].obs;

  @override
  void onReady() {
    super.onReady();
    // MYDeal();
    // getAllBusinessPost();
    // getDashBoard();
    // getCommentPost(postIdComment);
  }

  MYDeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");

    try {
      isLoadigDeal(true);
      final response = await BaseClient01().post(Appurls.mydeal, {
        "business_id": user_id.toString(),
      });
      print(response);
      print("TreadingModel");
      bool success = response["success"];
      var msg = response["message"];
      print("msg ___$msg");
      if (success == true) {
        myDealsModel = MyDealsModel.fromJson(response);
        Get.off(() => BuisnessHomePage());
      }
      isLoadigDeal(false);
    } catch (e, s) {
      print(e.runtimeType);
      print(s);
    }
    // isLoadig(false);
  }

  MYDealUserMap(int id) async {
    // myDealsModel?.myDeals.clear();
    // isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");
    // isLoadig(true);

    try {
      final response = await BaseClient01().post(Appurls.mydeal, {
        "business_id": id.toString(),
      });
      update();
      print(response);
      print("TreadingModel");
      bool success = response["success"];
      var msg = response["message"];
      print("msg ___$msg");
      if (success == true) {
        myDealsModel = MyDealsModel.fromJson(response);
        // myDealsModel?.myDeals.clear();
        // Get.off(() => BuisnessHomePage());
        // myDealsModel?.myDeals.clear();
      }
    } catch (e, s) {
      print(e.runtimeType);
      print(s);
    }
    update();
    // isLoadig(false);
  }

  RxList tapItemIndex = [].obs;

  // RxList<dynamic> tapItemIndex = [].obs;

  AllBusinessPostModel? allDataBusiness;

  Future<void>? video;
  VideoPlayerController? controller;
  File? videoFile;

  getV(index) async {
    controller = VideoPlayerController.network(allDataBusiness?.posts?[index].post ?? "https://forreal.net:4000/business_post/1698312729544.mp4");
/*    final appDir = await getApplicationDocumentsDirectory();
    final filename =  allDataBusiness?.posts?[index].post;
    videoFile=  File('${appDir.path}/$filename');
    controller?.initialize();
    await controller?.play();*/
    print('Video saved to: ${videoFile?.path}');
    print("hdfkj${allDataBusiness?.posts?[index].post}");
  }

  final PagingController<int, Post> pagingController = PagingController(firstPageKey: 1);

  int currentPage = 1;
  int pageSize = 10;
  static const _pageSize = 5;

  fetchPages(int pageKey) async {
    try {
      // Fetch data based on pageKey
      List<Post> newData = await fetchPage(pageKey);

      final isLastPage = newData.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newData);
      } else {
        // pagingController.appendPage(newData, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  fetchPage(int pageKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.get("user_id");

    try {
      final response = await BaseClient01().post(Appurls.buisnessAllPostHome, {
        "business_id": user_id.toString(),
        "page": pageKey.toString(),
        "pageSize": _pageSize.toString(),
      });

      bool success = response["success"];

      if (success) {
        AllBusinessPostModel newData = AllBusinessPostModel.fromJson(response);

        if (newData.posts != null && newData.posts.isNotEmpty) {
          List<Post> posts = newData.posts;

          // Assuming _pageSize is the desired number of posts per page
          if (posts.length > _pageSize) {
            // Trim the list to the desired number of posts
            posts = posts.sublist(0, _pageSize);
          }

          final isLastPage = posts.length < _pageSize;

          if (isLastPage) {
            pagingController.appendLastPage(posts);
          } else {
            pagingController.appendPage(posts, pageKey + 1);
          }
        } else {
          // No more data to load, set nextPageKey to null
          pagingController.appendLastPage([]);
        }
      }
    } catch (error, stackTrace) {
      print('Error: $error');
      print('Stack Trace: $stackTrace');
      pagingController.error = error;
    }
  }

  List<String> videoUrls = [];

  Future<List<AllVideoLink>> fetchVideos() async {
    final response = await http.get(Uri.parse('https://forreal.net:4000/all_video_list'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<AllVideoLink> videos = body.map((dynamic item) => AllVideoLink.fromJson(item)).toList();
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }

  // Future<List<String>> fetchDataFromApi() async {
  //   // Simulating API call delay
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   // Replace this with your actual API call to fetch data
  //   return fetchPage(pagingController.nextPageKey!);
  // }

  deletePost(postId) async {
    print("Events");
    isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await BaseClient01().post(Appurls.postDelete, {
      // "business_id": userId.toString(),
      'post_id': postId.toString(),
      //'file': "${file.value.toString()}",
    });

    isLoadig(false);
    bool status = response["success"];

    var msg = response["message"];
    print(response);
    if (status) {
      print("editDealsUp");

      pagingController.refresh();
      update();
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> likePost(String post_id, String like_status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
    print("post_id==>$post_id");
    var data = {'post_id': post_id, 'like_status': "$like_status"};
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
      print(json.encode(response.data));
      if (like_status == "1") {
        // sendNotification(user_id, "like");
      }
    } else {
      print(response.statusMessage);
    }
  }

  TextEditingController commentText = TextEditingController();

  commentPost(postId, int? businessId) async {
    isLoadigPostComment(true);
    print("Events");
    print(commentText.value.text);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    try {
      final response = await BaseClient01().post(Appurls.postComment, {
        // "business_id": userId.toString(),
        'post_id': postId.toString(),
        "comment": commentText.value.text ?? "shfid",
        //'file': "${file.value.toString()}",
      });
      bool status = response["success"];
      var msg = response["message"];
      print(response);
      if (status) {
        print("editDealsUp");
        commentText.clear();
        sendNotification("${businessId}", "business_comment");
        // getCommentPost(postIdComment);
        // await fetchPage(pagingController.nextPageKey!);
        print(msg);
        update();
      } else {
        print(msg);
      }
      isLoadigPostComment(false);
      update();
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: e.toString(),
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      //   fontSize: 16.0,
      // );
    }
    update();
  }

  GetCommentModel? getcommentList;

  var postIdComment;

  getCommentPost(int? postIdComment) async {
    isLoadigComment(true);
    print("Events");
    print(postIdComment);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    try {
      final response = await BaseClient01().post(Appurls.postGetComment, {
        'post_id': postIdComment.toString(),
      });
      bool status = response["success"];
      var msg = response["message"];
      print(response);
      if (status) {
        getcommentList = GetCommentModel.fromJson(response);
        // fetchPage(pagingController.nextPageKey!);
        pagingController.refresh();
        print(msg);
      } else {
        print(msg);
      }
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: e.toString(),
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      //   fontSize: 16.0,
      // );
    }
    isLoadigComment(false);
  }

  DashboardModel? dashboardModelData;

  // List daqsData=[];
  // List<Dashboad> dashboad=[];
  getDashBoard() async {
    print("dashboard");
    print(postIdComment);
    isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    try {
      final response = await BaseClient01().post(Appurls.dashBoadrdUri, {});
      bool status = response["success"];
      var msg = response["message"];
      print("dashBoadrd response$response");
      if (status) {
        dashboardModelData = DashboardModel.fromJson(response);
        print("ddnfkjdhfdkgj");
        print(dashboardModelData?.dashboad[0].totalLike);
        // dashboad=dashboardModelData!.dashboad.toList();
        print(msg);
      }
      isLoadig(false);
    } catch (e) {
      // Fluttertoast.showToast(
      //   msg: e.toString(),
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.white,
      //   textColor: Colors.black,
      //   fontSize: 16.0,
      // );
    }
    isLoadig(false);
  }
}
