import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realdating/home_page_new/new_home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../chat/api/apis.dart';

class HomePageUserController extends GetxController {
  var homePagetModelNOTUSE = HomePagetModel(posts: []).obs;

  HomePagetModel get homePageModel => homePagetModelNOTUSE.value;

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
  List<Post> posts = <Post>[];

  Future<void> firstLoad() async {
    print("firstLoad0");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    isFirstLoadRunning.value = true;
    try {
      var data = {'curr_user_id': '$userId', 'page': page.value, 'pageSize': limit};
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/Get_all_post',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("one1111${json.encode(response.data)}");
        posts = HomePagetModel.fromJson(response.data).posts;
        var firstLoad = HomePagetModel(posts: posts);
        homePagetModelNOTUSE(firstLoad);
        print("firstLoad${homePagetModelNOTUSE.value.posts?.length}");
        homePagetModelNOTUSE.refresh();
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

    isFirstLoadRunning.value = false;
  }

  void loadMore() async {
    if (hasNextPage.value == true && isFirstLoadRunning.value == false && isLoadMoreRunning.value == false && controller.position.extentAfter < 300) {
      isLoadMoreRunning.value = true; // Display a progress indicator at the bottom
      page += 1; // Increase _page by 1
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.get('user_id');
        var data = {'curr_user_id': '${userId}', 'page': page.value, 'pageSize': limit};
        var dio = Dio();
        var response = await dio.request(
          'https://forreal.net:4000/Get_all_post',
          options: Options(
            method: 'POST',
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          print("asdfgh${json.encode(response.data)}");
        } else {
          print(response.statusMessage);
        }

        final List<Post> fetchedPosts = HomePagetModel.fromJson(response.data).posts!;

        if (fetchedPosts.isNotEmpty) {
          //setState

          posts.addAll(fetchedPosts);
          var loadMore = HomePagetModel(posts: posts);
          homePagetModelNOTUSE(loadMore);
          print("loadMore${homePagetModelNOTUSE.value.posts?.length}");

          homePagetModelNOTUSE.refresh();

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

//
// @override
// void onInit() {
//   // TODO: implement onInit
//   super.onInit();
//
//   homePagetModel0(homePAGE);
//   Future.delayed(
//     const Duration(seconds: 5), () {
//       homePagetModel0.value.posts![0].totalComments = 50;
//       // posts.add(_post.value.totalComments);
//       print(homePagetModel0.value.posts![0].totalComments);
//       homePagetModel0.refresh();
//     },
//   );
// }
}
