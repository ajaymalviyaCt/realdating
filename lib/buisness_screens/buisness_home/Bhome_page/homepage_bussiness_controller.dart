import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../chat/api/apis.dart';
import '../../../pages/swipcard/swip_controller.dart';
import '../../../reel/common_import.dart';
import 'b_home_page_model.dart';
import 'bussines_comments_model.dart';

class HomepageBusinessController extends GetxController {
  TextEditingController commentsController = TextEditingController();
  var bHomePagetModelNOTUSE = BHomePagetModel(posts: []).obs;

  BHomePagetModel get bHomePagetModel => bHomePagetModelNOTUSE.value;

  @override
  void onInit() {
    super.onInit();
    APIs.getuser();
    firstLoad();
    // getPoll();
    controller = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    controller.removeListener(loadMore);
    super.dispose();
  }

  RxBool like = false.obs;
  RxInt page = 1.obs;
  final int limit = 3;
  RxBool hasNextPage = true.obs;
  RxBool isFirstLoadRunning = false.obs;
  RxBool isLoadMoreRunning = false.obs;
  List<BPost> posts = <BPost>[];

  Future<void> firstLoad() async {
    print("firstLoad0");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');
    print("bussinessuserId==>$userId");

    isFirstLoadRunning.value = true;
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
      var data = {'business_id': '$userId', 'page': page.value, 'pageSize': limit};
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/Get_all_business_post',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        print("one1111${json.encode(response.data)}");
        try {
          posts = BHomePagetModel.fromJson(response.data).posts;
          var firstLoad = BHomePagetModel(posts: posts);
          bHomePagetModelNOTUSE(firstLoad);
          print("firstLoad${bHomePagetModelNOTUSE.value.posts.length}");
          bHomePagetModelNOTUSE.refresh();
        } catch (e) {
          print("object${e}");
        }
      } else {
        print(response.statusMessage);
        print("two${json.encode(response.data)}");
      }

      /////////setState
    } catch (err) {
      if (kDebugMode) {
        print('${err.toString()}Something went wrong');
      }
    }
    //setsate
    isFirstLoadRunning.value = false;
  }

  void loadMore() async {
    if (hasNextPage.value == true && isFirstLoadRunning.value == false && isLoadMoreRunning.value == false && controller.position.extentAfter < 300) {
      isLoadMoreRunning.value = true; // Display a progress indicator at the bottom
      page += 1; // Increase _page by 1
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.get('user_id');
        var data = {'business_id': '${userId}', 'page': page.value, 'pageSize': limit};
        var dio = Dio();
        var headers = {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoxN30sImlhdCI6MTcwNjc3MjQ5N30.CG2TxFYexg9FjNhQyWUBiKFJhspSXp4zh20uDmIstWE'
        };
        var response = await dio.request(
          'https://forreal.net:4000/Get_all_business_post',
          options: Options(method: 'POST', headers: headers),
          data: data,
        );

        if (response.statusCode == 200) {
          print("response${json.encode(response.data)}");
        } else {
          print(response.statusMessage);
        }

        final List<BPost> fetchedPosts = BHomePagetModel.fromJson(response.data).posts;

        if (fetchedPosts.isNotEmpty) {
          //setState

          posts.addAll(fetchedPosts);
          var loadMore = BHomePagetModel(posts: posts);
          bHomePagetModelNOTUSE(loadMore);
          print("loadMore${bHomePagetModelNOTUSE.value.posts.length}");

          bHomePagetModelNOTUSE.refresh();

          // homePagetModel0.p
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          hasNextPage.value = false;
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      isLoadMoreRunning.value = false;
    }
  }

  late ScrollController controller;

  BcommentsModel? bcommentsModel;
  RxList<BComments> comments = <BComments>[].obs;
  RxBool isLoadingCommentList = false.obs;

  Future<void> getAllCommentBYpostID({required String postID, required bool alreadlyLoad, required int indexx}) async {
    print("getAllCommentBPostID${postID}");
    isLoadingCommentList.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');
    print("post_idddd===> $postID");
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer $token'};
    var data = {'post_id': postID};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/business_post_comments',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      try {
        comments.value = BcommentsModel.fromJson(response.data).comments;
        bHomePagetModelNOTUSE.value.posts[indexx].totalComments = comments.length;
        bHomePagetModelNOTUSE.refresh();
      } catch (e) {
        print("objectasfsf${e.toString()}");
      }

      EasyLoading.dismiss();
      isLoadingCommentList.value = false;

      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> postComments(String post_id, String comment, String user_id, int indexxx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (comment.trim().isEmpty) {
      print("Error: Comment is empty or spaces only.");
      return; // Abort if the comment is invalid
    }

    var token = prefs.get('token');
    print("tokentokentokentoken==>$token");
    var headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'Bearer ${token}'};
    var data = {'post_id': post_id, 'comment': comment};
    commentsController.clear();
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/comment_business_post',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      sendNotification(user_id, "comment");
      print("${token}");
      print("dsdsffsfs");
      print(json.encode(response.data));
      getAllCommentBYpostID(postID: post_id, alreadlyLoad: false, indexx: indexxx);
      //   getPostHomePage();
    } else {
      print(response.statusMessage);
    }
  }
}
