
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import '../pages/notification_page/notification_controller.dart';

class NotificationPageBusiness extends StatefulWidget {
  const NotificationPageBusiness({super.key});

  @override
  State<NotificationPageBusiness> createState() => _NotificationPageBusinessState();
}

class _NotificationPageBusinessState extends State<NotificationPageBusiness> {
  NotificationController notificationController =
  Get.put(NotificationController());
  @override
  void initState() {
    notificationController.getNotificationBusiness();
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
                :  notificationController.noficactionModel?.notification ==null ? Center(child: Text("No Notification Found"),) : ListView.builder(
              itemCount: notificationController
                  .noficactionModel?.notification?.length,

              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print('senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                    print('reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');

                    if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                        "business_like") {
                      Get.to(() => const BuisnessHomePage());
                      print(
                          'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                      print(
                          'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                    }
                    if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                        "business_comment") {
                      Get.to(() =>  BuisnessHomePage());
                      print(
                          'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                      print(
                          'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                    }
                   /* if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                        "chat") {
                      Get.to(() =>  MHomePage());
                      print(
                          'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                      print(
                          'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                    }*/
                   /* if ("${notificationController.noficactionModel?.notification?[index].body}" ==
                        "like") {
                      Get.to(() =>  MHomePage());
                      print(
                          'senderIdsenderIdsenderIdsenderId${notificationController.noficactionModel?.notification?[index].reciverId}');
                      print(
                          'reciverIdreciverIdreciverIdreciverIdreciverId${notificationController.noficactionModel?.notification?[index].reciverId}');
                    }*/
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
