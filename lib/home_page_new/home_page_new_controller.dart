import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/home_page_new/polls_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../buisness_screens/buisness_home/Bhome_page/homepage_bussiness_controller.dart';
import '../consts/app_urls.dart';
import '../pages/swipcard/swip_controller.dart';
import '../reel/common_import.dart';
import '../services/base_client01.dart';
import 'comments_model.dart';
import 'home_page_user_controller.dart';
import 'home_page_user_controller.dart';
import 'new_home_model.dart';

class HomePageNewController extends GetxController {
  TextEditingController commentsController = TextEditingController();
  HomePageUserController postsC = Get.put(HomePageUserController());
  HomepageBusinessController postsCB = Get.put(HomepageBusinessController());

  // RxList<Post> posts =<Post>[].obs;
  HomePagetModel? homePagetModel;

  List<Post> posts = <Post>[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getPostHomePage();
    getPoll();
    getUserID();
  }

  var userId;

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.get('user_id');
  }

  RxBool isLoadingGetPostHomePage = false.obs;

  Future<void> postComments(
      String post_id, String comment, String user_id, int indexxx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    print("tokentokentokentoken==>$token");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${token}'
    };
    var data = {'post_id': post_id, 'comment': comment};
    commentsController.clear();
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/comment_post',
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

  Future<void> likePost(
      String post_id, String like_status, String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    print("post_id==>$post_id");
    var data = {'post_id': post_id, 'like_status': "$like_status"};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/Like_post',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      if (like_status == "1") {
        sendNotification(user_id, "like");
      }
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> deletePostUser(postId) async {
    print("Events");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await BaseClient01().post(Appurls.postDeleteUser, {
      'post_id': postId.toString(),
    });

    bool status = response["success"];
    var msg = response["message"];
    print(response);
    if (status) {
      print("editDealsUp");
      postsC.firstLoad();
      // getAllUserPost();
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

  RxBool isLoadingGetPoll = false.obs;
  RxBool isVoted = false.obs;
  RxInt poll1 = 0.obs;
  RxInt poll_option_1_count = 0.obs;
  RxInt poll_option_2_count = 0.obs;
  RxInt poll_option_3_count = 0.obs;

  RxInt totalVotes = 0.obs;

  RxDouble poll1Persent = 0.0.obs;
  RxDouble poll2Persent = 0.0.obs;
  RxDouble poll3Persent = 0.0.obs;

  RxString poll_option_1 = "".obs;
  RxString poll_option_2 = "".obs;
  RxString poll_option_3 = "".obs;

  PollsModel? pollsModel;

  Future<void> getPoll() async {
    isLoadingGetPoll.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    // var userId = "${prefs.getString('user_id')}";
    var userId = "${prefs.getInt('user_id')}";

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var data = {
      'user_id': userId,
    };
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/allPolls',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      pollsModel = PollsModel.fromJson(response.data);
      poll_option_1.value =
          PollsModel.fromJson(response.data).polls!.pollOption1!;
      poll_option_2.value =
          PollsModel.fromJson(response.data).polls!.pollOption2!;
      poll_option_3.value =
          PollsModel.fromJson(response.data).polls!.pollOption3!;

      poll_option_1_count.value =
          PollsModel.fromJson(response.data).polls!.pollOption1Count!;
      poll_option_2_count.value =
          PollsModel.fromJson(response.data).polls!.pollOption2Count!;
      poll_option_3_count.value =
          PollsModel.fromJson(response.data).polls!.pollOption3Count!;

      print(
          "isVotedisVotedisVoted${PollsModel.fromJson(response.data).polls!.isVoted!}");
      if (PollsModel.fromJson(response.data).polls!.isVoted == 0) {
        isVoted.value = false;
      } else {
        isVoted.value = true;
      }

      totalVotes.value = poll_option_1_count.value +
          poll_option_2_count.value +
          poll_option_3_count.value;

      poll1Persent.value = poll_option_1_count.value / totalVotes.value;
      poll2Persent.value = poll_option_2_count.value / totalVotes.value;
      poll3Persent.value = poll_option_3_count.value / totalVotes.value;

      print(
          "poll1Persent ${poll1Persent.value} ${poll2Persent.value} ${poll3Persent.value}");
      print(
          "poll_option_1_count ${poll_option_1_count.value} ${poll_option_2_count.value} ${poll_option_3_count.value}");

      isLoadingGetPoll.value = false;
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> pollVote(
      {required int option1,
      required String owner_id,
      required String poll_id}) async {
    // isLoadingGetPoll.value=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var userId = "${prefs.getInt('user_id')}";

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var data = {
      'owner_id': '$owner_id',
      'user_id': userId,
      'poll_id': '$poll_id',
      'poll_option_$option1': '1',
    };
    print("pollVote${data.toString()}");
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/poll_response',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      Fluttertoast.showToast(
          msg: "${response.data["message"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0); // getPoll();
    } else {
      print(response.statusMessage);
    }
  }

  CommentsModel? commentsModel;
  RxList<CommentList> comments = <CommentList>[].obs;
  RxBool isLoadingCommentList = false.obs;

  Future<void> getAllCommentBYpostID(
      {required String postID,
      required bool alreadlyLoad,
      required int indexx}) async {
    isLoadingCommentList.value = alreadlyLoad;
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var data = {'post_id': postID};
    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/Get_all_post_comments',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {

      comments.value = CommentsModel.fromJson(response.data).comments!;

      // postsC.homePageModel.posts[1].totalComments=333;
      postsC.homePagetModelNOTUSE.value.posts[indexx].totalComments = comments.length;
      postsC.homePagetModelNOTUSE.refresh();
      //for bussiness
      try{

        postsCB.bHomePagetModelNOTUSE.value.posts[indexx].totalComments = comments.length;
        print("totalComments${postsCB.bHomePagetModelNOTUSE.value.posts[indexx].totalComments}");
        postsCB.bHomePagetModelNOTUSE.refresh();
      }catch(e){

      }
      //for bussiness


      EasyLoading.dismiss();
      isLoadingCommentList.value = false;

      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

//
// PollsModel? pollsModels;
// Map<String, int> usersWhoVoted = {};
// var pollOption1Count;
// getAllPolls() async {
//   // isLoadig(true);
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
//         pollsModels!.polls.response[i].pollOption1,
//     };
//
//     print(pollsModels);
//     update();
//
//   }
//
//   // isLoadig(false);
//
//   update();
//
//   // print("controller data ${controller}");
//   // cont(false);
// }
//
// var pollOption;
//
// String optionPoll(var pollOption) {
//   if (pollOption == 0) {
//     return "poll_option_1";
//   } else if (pollOption == 1) {
//     return "poll_option_2";
//   } else {
//     return "poll_option_3";
//   }
// }
//
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
//     await getAllPolls();
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
