import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/myDealModel.dart';
import 'business_home_controller.dart';

class EditUpdateController extends GetxController {
  MyDealController myDealController = Get.put(MyDealController());

  RxBool isLoadig = false.obs;
  EditUpdateModel? editUpdateModel;

  // TextEditingController file = TextEditingController();
  String? fileEdit;

  bool loading = false;
  var isLoading = false;

  @override
  void onReady() {
    super.onReady();
  }

  var editId;
  var index;

  // var myDeal;
  TextEditingController Title = TextEditingController();
  TextEditingController Price = TextEditingController();
  TextEditingController Discount = TextEditingController();
}
