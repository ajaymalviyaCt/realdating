import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/app_colors.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  static void noInternetDialog({String title = 'Error', String? description = 'No Internet Connection available'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //show toast


  //show snack bar
  //show loading
  // static void showLoading([String? message]) {
  //   Get.dialog(
  //     Dialog(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(height: 8),
  //             Text(message ?? 'Loading...'),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
  static void snackbar([String? message]) {
    Get.snackbar(
      "Satus",
      "$message",
      icon: Icon(Icons.person, color: Colors.redAccent),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent

    );

  }
  static void snackbarwhite([String? message]) {
    Get.snackbar(
        "Satus",
        "$message",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        borderColor: Colors.redAccent

    );

  }


}