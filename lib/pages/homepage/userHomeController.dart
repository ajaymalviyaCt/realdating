import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:realdating/pages/homepage/polls/pollsModel.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/app_urls.dart';
import '../../model/userModel.dart';
import '../../services/base_client01.dart';
import '../createPostUser/mention/getFriendModel.dart';
import '../discovery/discoveryModel.dart';
import '../profile/profile_controller.dart';

class UserHomeController extends GetxController implements GetxService {
  RxBool isLoadig = false.obs;
  List<UserPosts> userPostModel = [];
  List<Comments> userPostModelComment = [];
  RxList tapItemIndex = [].obs;

  TextEditingController commentText = TextEditingController();
  // ProfileController profileController = Get.put(ProfileController());

  @override
  void onReady() {
    super.onReady();
    // getAllUserPost();
    getMyFriendsPost();
    // profileController.profileDaitails();
  }

  var userProfileImage;

  // getAllUserPost() async {
  //   // isLoadig(true);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userid = prefs.get("user_id");
  //   var token = prefs.get('token');
  //   isLoadig(true);
  //   print("ultramodern");
  //   final response = await BaseClient01().post(Appurls.allPostHome, {
  //     "curr_user_id": userid.toString(),
  //   });
  //   print(response);
  //   print("ultramodern1");
  //
  //   bool success = response["success"];
  //
  //   if (success) {
  //     final data = PostUserModel.fromJson(response);
  //     userPostModel = data.posts!;
  //     update();
  //
  //   }
  //   update();
  //   // print("controller data ${controller}");
  //   // cont(false);
  // }

  // userCommentPost(postId) async {
  //   // pint("Events");
  //   print(commentText.value.text);
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.get('user_id');
  //   try {
  //     final response = await BaseClient01().post(Appurls.userPostComment, {
  //       // "business_id": userId.toString(),
  //       'post_id': postId.toString(),
  //       "comment": commentText.value.text ?? "shfid",
  //
  //       //'file': "${file.value.toString()}",
  //     });
  //     bool status = response["success"];
  //     var msg = response["message"];
  //     print(response);
  //     if (status) {
  //       print("editDealsUp");
  //       commentText.clear();
  //       // getCommentPost(postIdComment);
  //       await getAllUserPost();
  //       print(msg);
  //     } else {
  //       print(msg);
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 16.0,
  //     );
  //   }
  //   update();
  // }

/*
  likePostUser(postId, contains) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("nfhjdfhiu$contains");
    final response = await BaseClient01().post(Appurls.postLikeUser, {
      'post_id': postId.toString(),
      "like_status": contains == false ? 0.toString() : 1.toString(),
    });
    bool status = response["success"];
    var msg = response["message"];
    print(response);
    if (status) {
      // await MYDeal();
      await getAllUserPost();
    } else {
      print(msg);
      Fluttertoast.showToast(
        msg: msg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }
*/



  DiscoveryModel? discoveryData;

  getDiscovery() async {
    // isLoadig(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.get('user_id');

    isLoadig(true);

    final response = await BaseClient01().post(Appurls.userGetDiscover, {
      'user_id': userId.toString(),
    });

    print(response);

    bool success = response["success"];

    if (success) {
      discoveryData = DiscoveryModel.fromJson(response);

      // final videoBytes = response.bodyBytes;
      // controller = VideoPlayerController.network(videoBytes);
      // await controller?.initialize();
      // await controller?.play();
    }
    update();
    // print("controller data ${controller}");
    // cont(false);
    isLoadig(false);
  }

  getDiscoverySearch(String value) async {
    // isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.userGetDiscover, {
      'user_id': userId.toString(),
      'Interest': value.toString(),
    });
    print(response);

    bool success = response["success"];

    if (success) {
      discoveryData = DiscoveryModel.fromJson(response);

      // final videoBytes = response.bodyBytes;
      // controller = VideoPlayerController.network(videoBytes);
      // await controller?.initialize();
      // await controller?.play();
    }
    update();
    // print("controller data ${controller}");
    // cont(false);
    isLoadig(false);
  }

  List<MyFriends> users = <MyFriends>[].obs;

  var searchQuery = ''.obs;

  List<MyFriends> get filteredusers {
    if (searchQuery.isEmpty) {
      return users;
    } else {
      return filteredusers
          .where((item) => item.friendFirstName!.contains(searchQuery.value))
          .toList();
    }
  }

  // GetAllFriendModel? getAllFriendModel;
  List<MyFriends> userFriend = [];

  getMyFriendsPost() async {
    // isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.get("user_id");
    var token = prefs.get('token');
    isLoadig(true);
    print("ultramodern");
    final response = await BaseClient01().post(Appurls.getMyFriendUrl, {
      "user_id": userid.toString(),
    });
    print(response);
    print("ultramodern1");

    bool success = response["success"];
    String msg = response["message"];

    if (success) {
      final data = GetAllFriendModel.fromJson(response);
      userFriend = data.myFriends!;
      users = data.myFriends!;
      print('my friends list is here------${response}');
    } else {
      Fluttertoast.showToast(
        msg: msg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
    update();
    // print("controller data ${controller}");
    // cont(false);
  }

  // PollsModel? pollsModels;
  Map<String, int> usersWhoVoted = {};
  // getAllPolls() async {
  //   isLoadig(true);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userid = prefs.get("user_id");
  //   var token = prefs.get('token');
  //
  //   print("ultramodern");
  //   final response = await BaseClient01().post(Appurls.allPolls, {
  //     "user_id": userid.toString(),
  //   });
  //   print(response);
  //   print("poll all");
  //
  //   bool success = response["success"];
  //
  //   if (success) {
  //
  //     pollsModels = PollsModel.fromJson(response);
  //     pollOption1Count!=null?     prefs.setInt('poll_option_1_count', pollOption1Count):1;
  //     // userPoll = data.polls.response;
  //
  //     usersWhoVoted = {
  //       for (int i = 0; i != pollsModels?.polls.response.length; i++)
  //         pollsModels!.polls.response[i].firstName:
  //             pollsModels!.polls.response[i].pollOption1,
  //     };
  //
  //     print(pollsModels);
  //     update();
  //
  //   }
  //
  //   isLoadig(false);
  //
  //   update();
  //
  //   // print("controller data ${controller}");
  //   // cont(false);
  // }



  // pollResponse(ownerId, pollId, pollOption) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userid = prefs.get("user_id");
  //   print("nfhjdfhiu$pollOption");
  //   print("nfhjdfhiusss${optionPoll(pollOption.toString())}");
  //   final response = await BaseClient01().post(Appurls.pollResponseUrl, {
  //     'owner_id': ownerId.toString(),
  //     'user_id': userid.toString(),
  //     'poll_id': pollId.toString(),
  //     optionPoll(pollOption): "1",
  //   });
  //   bool status = response["success"];
  //   var msg = response["message"];
  //   print(response);
  //   if (status) {
  //     // await MYDeal();
  //     // await getAllPolls();
  //     update();
  //   } else {
  //     print(msg);
  //     Fluttertoast.showToast(
  //       msg: msg.toString(),
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 16.0,
  //     );
  //   }
  // }
}
