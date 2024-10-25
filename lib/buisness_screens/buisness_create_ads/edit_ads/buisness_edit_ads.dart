import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:realdating/custom_iteam/coustomtextcommon.dart';
import 'package:realdating/custom_iteam/customprofile_textfiiled.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/validation/validation.dart';
import 'package:get/get.dart';

import '../../../function/function_class.dart';
import '../all_ads/all_ads_controller.dart';
import '../all_ads/buisness_all_adss_models.dart';
import 'edit_ads_controller.dart';

class BuisnessEditAds extends StatefulWidget {
  final List<MyAdv> dataList; // Define a list of data to receive
  final int indexEdit;

  BuisnessEditAds({super.key, required this.dataList, required this.indexEdit});

  @override
  State<BuisnessEditAds> createState() => _BuisnessEditAdsState();
}

class _BuisnessEditAdsState extends State<BuisnessEditAds> {
  String? EditAds;

  AllAdssDealController allAdssDealController =
      Get.put(AllAdssDealController());
  EditAdsController editAdsController = Get.put(EditAdsController());
  MyAdv? listdata;

  @override
  Widget build(BuildContext context) {
    print("sjfdk");
    print(widget.dataList[widget.indexEdit].title);
    // print(widget.indexEdit);
    return Scaffold(
        appBar: customAppbar("Edit Ad", context),
        body: Obx(
          () => allAdssDealController.isLoadig.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    // key:_formmKey,
                    // autovalidateMode:  AutovalidateMode.always,
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const SizedBox(
                            height: 30,
                          ),
                          customTextC(
                              text: "Upload Image",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              widget.dataList[widget.indexEdit].adImage !=
                                          null &&
                                      editAdsController.addImage == null
                                  ? InkWell(
                                      onTap: () async {
                                        final XFile? pickImage =
                                            await ImagePicker().pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 10);
                                        final croppedFile = await ImageCropper().cropImage(
                                          sourcePath: pickImage!.path,

                                          // aspectRatioPresets: [
                                          //   CropAspectRatioPreset.square,
                                          //   CropAspectRatioPreset.ratio3x2,
                                          //   CropAspectRatioPreset.original,
                                          //   CropAspectRatioPreset.ratio4x3,
                                          //   CropAspectRatioPreset.ratio16x9,
                                          // ],
                                          maxWidth: 600,
                                          maxHeight: 600,
                                        );
                                        if (croppedFile != null) {
                                          setState(() {
                                            editAdsController.addImage =
                                                croppedFile.path;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 135,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(widget
                                                    .dataList[widget.indexEdit]
                                                    .adImage),
                                                fit: BoxFit.cover)),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        final XFile? pickImage =
                                            await ImagePicker().pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 10);
                                        final croppedFile = await ImageCropper().cropImage(
                                          sourcePath: pickImage!.path,

                                          // aspectRatioPresets: [
                                          //   CropAspectRatioPreset.square,
                                          //   CropAspectRatioPreset.ratio3x2,
                                          //   CropAspectRatioPreset.original,
                                          //   CropAspectRatioPreset.ratio4x3,
                                          //   CropAspectRatioPreset.ratio16x9,
                                          // ],
                                          maxWidth: 600,
                                          maxHeight: 600,
                                        );
                                        if (croppedFile != null) {
                                          editAdsController.addImage =
                                              croppedFile.path;
                                          // const Image();
                                        }
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Center(
                                            child: editAdsController.addImage ==
                                                    null
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 135,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            HexColor('#D9D9D9'),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ))
                                                : Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 135,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: HexColor(
                                                              '#D9D9D9'),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            image: FileImage(File(
                                                                editAdsController
                                                                    .addImage!)),
                                                            fit: BoxFit.fill)),
                                                  ),
                                          ),

                                          Container(
                                            height: 141,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                //  SvgPicture.asset('assets/icons/file-plus.svg'),
                                                InkWell(
                                                  onTap: () async {
                                                    final XFile? pickImage =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery,
                                                                imageQuality:
                                                                    10);
                                                    if (pickImage != null) {
                                                      setState(() {
                                                        editAdsController
                                                                .addImage =
                                                            pickImage.path;
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
                                                        color: Colors.grey))
                                              ],
                                            ),
                                          ),
                                          // Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(dataList[indexEdit].roomImage))),)
                                        ],
                                      ),
                                    ),
                            ],
                          ),

                          customTextC(
                              text: "Title",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                              height: 50,
                              child: CustumProfileTextField1(
                                controller: editAdsController.Title,
                                validator: validateName,
                                hintText:
                                    widget.dataList[widget.indexEdit].title ??
                                        "",
                              )),

                          //  SizedBox(height: 10,),
                          customTextC(
                              text: "Age",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.Age,
                              validator: validateName,
                              hintText: widget.dataList[widget.indexEdit].age
                                      .toString() ??
                                  "",
                              // hintText: "22"
                            ),
                          ),

                          customTextC(
                              text: "Intrest",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.Intrest,
                              validator: validateName,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].interest}",
                              //hintText: "Music,Sports"
                            ),
                          ),

                          customTextC(
                              text: "budget",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.budget,
                              validator: validateName,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].budget}",
                              // hintText: "10,000"
                            ),
                          ),

                          customTextC(
                              text: "CampaignDuration",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.CampaignDuration,
                              validator: validateName,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].campaignDuration}",
                              //hintText: "3 Months"
                            ),
                          ),

                          customTextC(
                              text: "Location",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.Location,
                              validator: validateName,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].address}",
                              //hintText: "3 Months"
                            ),
                          ),

                          customTextC(
                              text: "Range (Miles)",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.Range,
                              validator: validateRange,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].rangeKm}" ??
                                      "",
                              //hintText: "10 Km"
                            ),
                          ),

                          customTextC(
                              text: "Link",
                              fSize: 16,
                              fWeight: FontWeight.w500,
                              lineHeight: 36),

                          SizedBox(
                            height: 50,
                            child: CustumProfileTextField1(
                              controller: editAdsController.Link,
                              validator: validateName,
                              hintText:
                                  "${widget.dataList[widget.indexEdit].link}",
                            ),
                          ),

                          SizedBox(height: 30),
                          Obx(
                            () => customPrimaryBtn(
                              btnText: "save",
                              btnFun: () {
                                setState(() {
                                  editAdsController.EditAdsUpdate(
                                      widget.dataList[widget.indexEdit].id
                                          .toString(),
                                      widget.indexEdit,
                                      allAdssDealController.getAllAdsMdoels
                                          ?.myAdvs[widget.indexEdit]);
                                  allAdssDealController.All_AdsD();
                                });
                              },
                              loading: editAdsController.isLoadig.value,
                            ),
                          ),

                          Obx(
                            () => customPrimaryBtnBlk(
                              btnText: 'delete',
                              btnFun: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              "Are you sure you want to delete this Ad?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                editAdsController.EditAdsDelete(
                                                    widget
                                                        .dataList[
                                                            widget.indexEdit]
                                                        .id);
                                                setState(() {
                                                  allAdssDealController
                                                      .All_AdsD();
                                                  // controller.myDealsModel;
                                                });
                                                allAdssDealController.refresh();
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Appcolor.Redpink,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Appcolor.Redpink,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ));

                                /* editAdsController.EditAdsDelete(
                                    widget.dataList[widget.indexEdit].id);

                                setState(() {
                                  allAdssDealController.All_AdsD();
                                });*/
                              },
                              loading: editAdsController.isLoadig.value,
                            ),
                          )
                        ])),
                  )),
        ));
  }
}
