import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:realdating/custom_iteam/coustomtextcommon.dart';
import 'package:realdating/custom_iteam/customprofile_textfiiled.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/validation/validation.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_urls.dart';
import '../../../services/base_client01.dart';
import '../Bhome_page/buisness_home.dart';
import '../controller/business_home_controller.dart';
import '../controller/editDeal_controller.dart';
import '../model/myDealModel.dart';

class EDIT_deal extends StatefulWidget {
  const EDIT_deal({super.key});

  @override
  State<EDIT_deal> createState() => _EDIT_dealState();
}

class _EDIT_dealState extends State<EDIT_deal> {
  final RxBool editDealApiLoading = false.obs;
  MyDealController myDealController = Get.put(MyDealController());
  RxBool isLoadig = false.obs;
  EditUpdateController editUpdateController = Get.put(EditUpdateController());


  // final indexs = ModalRoute.of(context)!.settings.arguments as int;

  final index = Get.arguments as int;

  void uploadFileToServerInfluencer(editId, index, MyDeal myDeal) async {
    editDealApiLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get("user_id");
    print('user_id==============${myDeal.title}');
    // setState(() {
    //
    // });
    print("CLICKED 123 ==");

    var request = http.MultipartRequest("POST", Uri.parse("https://forreal.net:4000/update_deals"));

    request.fields['Title'] = editUpdateController.Title.text.isEmpty ? myDeal.title : editUpdateController.Title.text;
    request.fields['Price'] = editUpdateController.Price.text.isEmpty ? myDeal.price.toString() : editUpdateController.Price.text;
    request.fields['Discount'] = editUpdateController.Discount.text.isEmpty ? myDeal.discount : editUpdateController.Discount.text;
    request.fields['id'] = editId.toString();
    // request.fields['business_id'] = '1';

    if (editUpdateController.fileEdit == null) {
      var fileName = myDealController.myDealsModel?.myDeals[index].roomImage;
      request.fields['file'] = fileName.toString();
      print("File======>");
      print(
        request.fields['file'],
      );
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('file', editUpdateController.fileEdit.toString()),
      );
      print("file data");
      print(request.fields['file']);
      // https://forreal.net:4000/deals/
    }
    print("??????????????${request.fields.toString()}");
    request.send().then((response) {
      http.Response.fromStream(response).then((onValue) async {
        try {
          // Navigator.pop(context);

          print("response.statusCod");

          print(onValue.body);
          // _future = myprofile();
          //Rahul
          //  _willPopCallback();
          Fluttertoast.showToast(
              msg: "Deal updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          editDealApiLoading.value = false;
          Get.off(() => const BuisnessHomePage());
        } catch (e) {
          Fluttertoast.showToast(
            msg: "Something went wrong....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xffC83760),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // handle exeption
        }
      });
    });
  }

  EditDealsDelete(editId) async {
    print("Events");
    isLoadig(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');

    final response = await BaseClient01().post(Appurls.editdealdelete, {
      "business_id": userId.toString(),
      'deal_id': editId,
      //'file': "${file.value.toString()}",
    });

    isLoadig(false);
    bool status = response["success"];

    var msg = response["message"];

    if (status) {
      print("editDealsUp");
      myDealController.MYDeal();
      myDealController.myDealsModel?.myDeals.clear();
      setState(() {
        myDealController.MYDeal();
      });
      Get.to(() => const BuisnessHomePage());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Edit Deals", context),
      body: Obx(
            () =>
        myDealController.isLoadig.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            // key:_formmKey,
            // autovalidateMode:  AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                    height: 30,
                  ),
                  customTextC(
                    text: "Upload Image",
                    fSize: 16,
                    fWeight: FontWeight.w500,
                    lineHeight: 36,
                  ),

                  myDealController.myDealsModel?.myDeals[index].roomImage != null && editUpdateController.fileEdit == null
                      ? InkWell(
                    onTap: () async {
                      final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                      if (pickImage != null) {
                        setState(() {
                          editUpdateController.fileEdit = pickImage.path;
                        });
                      }
                    },
                    child: Container(
                      height: 135,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(myDealController.myDealsModel?.myDeals[index].roomImage ?? ""),
                            fit: BoxFit.cover,
                          )),
                      child: const Center(
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.black,
                            size: 40,
                          )),
                    ),
                  )
                      : InkWell(
                    onTap: () async {
                      final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                      if (pickImage != null) {
                        editUpdateController.fileEdit = pickImage.path;
                        // const Image();
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: editUpdateController.fileEdit == null
                              ? Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 135,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: HexColor('#D9D9D9'),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                )),
                          )
                              : Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 135,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor('#D9D9D9'),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(image: FileImage(File(editUpdateController.fileEdit!)), fit: BoxFit.fill)),
                          ),
                        ),

                        Container(
                          height: 141,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //  SvgPicture.asset('assets/icons/file-plus.svg'),
                              InkWell(
                                onTap: () async {
                                  final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                                  if (pickImage != null) {
                                    setState(() {
                                      editUpdateController.fileEdit = pickImage.path;
                                    });
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/galleryicon.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text('Upload Image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        ),
                        // Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(dataList[indexEdit].roomImage))),)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextC(
                    text: "Title",
                    fSize: 16,
                    fWeight: FontWeight.w500,
                    lineHeight: 36,
                  ),
                  SizedBox(
                    // height: 50,
                    child: CustumProfileTextField1(
                        controller: editUpdateController.Title,
                        validator: validateName,
                        maxlenght: 30,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "${myDealController.myDealsModel?.myDeals[index].title}"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextC(text: "Price(\$)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                  SizedBox(
                    height: 50,
                    child: CustumProfileTextField1(
                      controller: editUpdateController.Price,
                      validator: validateName,
                      hintText: "${myDealController.myDealsModel?.myDeals[index].price}",
                    ),
                  ),
                  const SizedBox(height: 10),
                  customTextC(
                    text: "Discount(\$)",
                    fSize: 16,
                    fWeight: FontWeight.w500,
                    lineHeight: 36,
                  ),
                  SizedBox(
                    height: 50,
                    child: CustumProfileTextField1(
                        controller: editUpdateController.Discount,
                        validator: validateName,
                        hintText: myDealController.myDealsModel?.myDeals[index].discount ?? editUpdateController.Discount.text),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                        () =>
                        customPrimaryBtn(
                          btnText: "Save",
                          btnFun: () async {
                            print("objectssss");
                            print(myDealController.myDealsModel?.myDeals[index].roomImage);
                            print("data");
                            print(myDealController.myDealsModel?.myDeals[index].roomImage
                                .split("/")
                                .last);
                            if (editUpdateController.fileEdit == null) {
                              myDealController.myDealsModel?.myDeals[index].roomImage;
                            }
                            editUpdateController.Title.text ??= myDealController.myDealsModel!.myDeals[index].title;
                            editUpdateController.Price.text ??= myDealController.myDealsModel!.myDeals[index].price.toString();
                            editUpdateController.Discount.text ??= myDealController.myDealsModel!.myDeals[index].discount;
                            if (!(num.parse(editUpdateController.Price.text.isEmpty
                                ? myDealController.myDealsModel!.myDeals[index].price.toString()
                                : editUpdateController.Price.text) >
                                num.parse(editUpdateController.Discount.text.isEmpty
                                    ? myDealController.myDealsModel!.myDeals[index].discount
                                    : editUpdateController.Discount.text))) {
                              Fluttertoast.showToast(msg: "Discount cannot be greater than or equal to the price.");
                              return;
                            }
                            setState(() {
                              uploadFileToServerInfluencer(
                                  myDealController.myDealsModel?.myDeals[index].id.toString(), index, myDealController.myDealsModel!.myDeals[index]);
                              //editUpdateController.demmooup();
                            });
                            await myDealController.MYDeal();
                          },
                          loading: editDealApiLoading.value,
                        ),
                  ),

                  customPrimaryBtnBlk(
                    btnText: 'Delete',
                    btnFun: () async {
                      var myData;

                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: const Text("Are you sure you want to delete this Deal?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      EditDealsDelete(myDealController.myDealsModel?.myDeals[index].id.toString());
                                      setState(() {
                                        myDealController.MYDeal();
                                        // controller.myDealsModel;
                                      });
                                      myDealController.refresh();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(color: Appcolor.Redpink, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ));

                      /*   EditDealsDelete(myDealController
                                .myDealsModel?.myDeals[index].id
                                .toString());
                            await myDealController.MYDeal();
                            myDealController.MYDeal();*/
                    },
                    loading: editUpdateController.isLoadig.value,
                  ),
                  //)
                ]),
              )),
        ),
      ),
    );
  }
}
