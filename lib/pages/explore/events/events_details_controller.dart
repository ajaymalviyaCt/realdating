import 'package:get/get.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import 'events_details_model.dart';

class EventsDetailsController extends GetxController {
  RxBool isLoadig = false.obs;
  EventsDetailsModel? eventsDetailsModel;

  @override
  void onReady() {
    super.onReady();
    Events(id);
  }

  var id;

  Events(id) async {
    print("Events");
    isLoadig(true);
    final response = await BaseClient01().post(Appurls.eventDetails, {
      "Event_id": id ?? "2",
    });
    print(response);
    print("TreadingModel");
    bool success = response["success"];
    var msg = response["message"];
    print("msg ___$msg");
    if (success) {
      eventsDetailsModel = EventsDetailsModel.fromJson(response);
    }
    isLoadig(false);
  }
}
