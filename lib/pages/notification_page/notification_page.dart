import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realdating/home_page_new/home_page_user.dart';
import 'package:realdating/pages/matches_request_page/matches_request_pages.dart';
import '../explore/matches/allDateInvites/my_all_dates_pages.dart';
import 'notification_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController notificationController =
      Get.put(NotificationController());
@override
  void initState() {
  notificationController.getNotification();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => notificationController.isLoading.value
                ? const Center(child: CircularProgressIndicator(),)
                :  notificationController.noficactionModel?.notification?.length == 0 ? Center(child: Text("No Notification Found"),) : ListView.builder(
                    itemCount: notificationController
                        .noficactionModel?.notification?.length,

                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                          print('reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');

                          if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                              "matches request") {
                            Get.to(() => const MatchesRequestPages());
                            print(
                                'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                            print(
                                'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                          }
                          if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                              "invite_date") {
                            Get.to(() =>  MyAllDatesPage());
                            print(
                                'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                            print(
                                'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                          }
                          if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                              "chat") {
                            Get.to(() =>  HomePageUser());
                            print(
                                'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                            print(
                                'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                          }
                          if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                              "like") {
                            Get.to(() =>  HomePageUser());
                            print(
                                'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                            print(
                                'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                          }
                        },
                        child: ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: notificationController.noficactionModel?.notification?[index].profileImage ==
                                      "https://forreal.net:4000/profile/0"
                                  ? Image.asset("assets/images/noImage.png")
                                  : Image.network(
                                      "${notificationController.noficactionModel?.notification?[index].profileImage}",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fill,
                                    )),
                          title: Text(
                              "${notificationController.noficactionModel?.notification?[index].senderFirstName}"),
                          subtitle: Text(
                              "${notificationController.noficactionModel?.notification?[index].body}"),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
