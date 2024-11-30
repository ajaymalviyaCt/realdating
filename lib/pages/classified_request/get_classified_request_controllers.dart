import 'package:realdating/pages/classified_request/get_classified_request_models.dart';
import 'package:get/get.dart';
import 'package:realdating/pages/swipcard/swip_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/base_client01.dart';

class GetClassifiedRequestController extends GetxController {
  // RxBool isLoadingAcepted = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    GetClassifiedRequestMethod(true);
  }

  RxList<ClassifiedRequest> classifiedRequests = <ClassifiedRequest>[].obs;
  var searchQuery = ''.obs;

  List<ClassifiedRequest> get filteredClassifiedRequests {
    if (searchQuery.isEmpty) {
      return classifiedRequests;
    } else {
      return classifiedRequests.where((item) => item.activity.contains(searchQuery.value)).toList();
    }
  }

  //for filter check box
  RxBool value1 = false.obs;
  RxBool value2 = false.obs;
  RxBool value3 = false.obs;
  RxBool value4 = false.obs;

  //for filter check box end

  GetClassifiedRequestModel? getClassifiedRequestModel;
  RxBool isLoading = false.obs;

  GetClassifiedRequestMethod(bool loading) async {
    isLoading.value = loading;
    print("GetClassifiedRequestMethod");
    final response = await BaseClient01().post(Uri.parse("https://forreal.net:4000/users/my_classified_request"), {});
    var satus = "${response["status"]}";
    if (satus == "200") {
      isLoading.value = false;
      getClassifiedRequestModel = GetClassifiedRequestModel.fromJson(response);
      classifiedRequests.value = GetClassifiedRequestModel.fromJson(response).classifiedRequest!;
      print("12345678909876543=======>${classifiedRequests.length}");
      print("GetClassifiedRequestMethod$response");
    } else {
      print("GetClassifiedRequestMethod1234$response");

      print(response.toString());
      // AppDialog.taostMessage("${response["message"]}");
    }
  }

  RxBool isLoadingApceted = false.obs;
  RxInt indexselect = 999999.obs;

  void aceptedRejectMethod(
    String senderId,
    String inviteId,
  ) async {
    isLoadingApceted.value = true;
    print("GetClassifiedRequestMethod");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    final response = await BaseClient01()
        .post(Uri.parse("https://forreal.net:4000/users/new_friend"), {"reciver_id": "$userId", "sender_id": senderId, "invite_id": "$inviteId"});

    isLoadingApceted.value = false;
    GetClassifiedRequestMethod(false);
    sendNotification(senderId, "invite_accept");
    print("asdfhgffsdghgnfdsfghgfd${response.toString()}");
    var satus = "${response["status"]}";
    if (satus == "200") {
      isLoadingApceted.value = false;
      print("GetClassifiedRequestMethod");
    } else {
      isLoadingApceted.value = false;
      print(response.toString());
      // AppDialog.taostMessage("${response["message"]}");
    }
  }

// var filteredList = myList.where((element) => element.contains(query)).toList().obs;
// print(filteredList); // Output: [apple, date, elderberry]
}
