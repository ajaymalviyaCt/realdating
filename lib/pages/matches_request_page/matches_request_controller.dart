import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/base_client01.dart';
import 'matches_request_model.dart';

class MatchesRequestController extends GetxController{

  // GetClassifiedRequestModel? getClassifiedRequestModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCancelReq = false.obs;
  RxBool isLoadingAceptedReq = false.obs;
  RxInt indexValue= 99999999.obs;
  RxInt indexValueapcepted= 99999999.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyFriendRequestModelMethod(true);
  }


  GetMyFriendRequestModel ? getMyFriendRequestModel;
  RxList<MyFriendsRequest>  myFriendsRequest =<MyFriendsRequest>[].obs;


  getMyFriendRequestModelMethod(bool  update ) async {
    isLoading.value = update;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    print("GetClassifiedRequestMethod");
    final response = await BaseClient01().post(
        Uri.parse("https://forreal.net:4000/users/get_my_friend_request"), {
      'user_id': '$userId'
    });
    print(response.toString());
    var satus = "${response["status"]}";
    if (satus == "200") {
      isLoading.value = false;
      getMyFriendRequestModel = GetMyFriendRequestModel.fromJson(response);
      myFriendsRequest.value = GetMyFriendRequestModel.fromJson(response).myFriendsRequest!;
      print("myFriendsRequest lenth ===>${myFriendsRequest.length} ");

    } else {
      print("GetClassifiedRequestMethod1234$response");
      print(response.toString());

    }
  }



}