import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/discovery/discovery_model.dart';
import 'package:realdating/pages/mape/NearBy_businesses.dart';
import 'package:realdating/services/apis_related/api_call_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import '../explore/matches/matches_controller.dart';
import '../profile/profile_model.dart';

class DiscoveryController extends GetxController {
  MatchessController matchessController = Get.put(MatchessController());
  RxBool isLoadingGetDiscoverUser = false.obs;
  RxBool isLoadingForYourModel = false.obs;
  RxBool isLoadig1 = false.obs;
  Discovery2Model? discoveryModel;
  Discovery2Model? forYourModel;

  List<MyFriend> myFriends = [];
  List<MyFriend> filteredItems = [];
  RxBool isLoadig = false.obs;
  ProfileModel? profileModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileDaitails();
    getDiscoveryUser();
    foryou();
  }

  Future<void> profileDaitails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt('user_id');
    print("call  profileDaitails");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.profile, {
      "id": "$user_id",
    });
    print(response.toString());

    bool status = response["success"];
    print("status ___$status");
    var msg = response["message"];
    print("msg ___$msg");
    profileModel = ProfileModel.fromJson(response);

    print("profile model data--------${profileModel}");

    isLoadig(false);
    // if (status) {
    //   Get.to(() => const UplodePhoto());
    // }
  }

  Future<void> getDiscoveryUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var token = prefs.get('token');

    isLoadingGetDiscoverUser.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };

    var data = {'user_id': '$userId'};
    print("user_idddddddddddd===${userId}");

    var dio = Dio();
    var response = await dio.request(
      'https://forreal.net:4000/users/discovery',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      isLoadingGetDiscoverUser.value = false;
      try {
        discoveryModel = Discovery2Model.fromJson(response.data);
        filteredItems.addAll(discoveryModel!.myFriends);
        myFriends.addAll(discoveryModel!.myFriends);

        print("Discovery model data -  =>$discoveryModel");
        print("Discovery filter data1  -  =>$filteredItems");
        print("Discovery filter data2 -  =>$myFriends");
      } catch (e) {
        print("responseee=>$e");
      }

      print("response");
      print(json.encode(response.data));
      print("response");
    } else {
      print(response.statusMessage);
    }
  }

  List<MyFriend> myFriendsForyou = [];
  List<MyFriend> filteredItemsYou = [];

  Future<void> foryou() async {
    Map<String, dynamic> apiData = await ApiCall.instance.callApi(
        url: 'https://forreal.net:4000/users/discovery_filter',
        method: HttpMethod.POST,
        body: {
          'user_id': await getUserId(),
          'Interest': profileModel?.userInfo.interest.split(",").take(1)
        },
        headers: await authHeader());

    isLoadingForYourModel.value = false;
    try {
      forYourModel = Discovery2Model.fromJson(apiData);
      filteredItemsYou.addAll(forYourModel!.myFriends);
      myFriendsForyou.addAll(forYourModel!.myFriends);

    } catch (e) {
      print("responseee=>$e");
    }
  }

  Future<bool> sendNotificationOnlyMatch(
      {required String reciverId, required int index}) async {
    print("_notification_response ==>$reciverId");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getInt('user_id');
      print("SwipModel");
      final response = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/send_notification"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
        'notification_type': 'matches'
      });
      print("notificationResponse ==> $response");
      isLoadig1.value = true;
      final response2 = await BaseClient01()
          .post(Uri.parse("https://forreal.net:4000/users/friend_request"), {
        "sender_id": "$user_id",
        "reciver_id": "$reciverId",
      });
      print("friend_request_Response ==> $response2");
      isLoadig1.value = false;
      matchessController.matches();

      print(response2.toString());
      Fluttertoast.showToast(msg: "${response2["message"]}");
      return true;

      print("friend_request==> friend_request==>" + response2.toString());
    } catch (e) {
      print(e);
      return false;
    }
  }
}
