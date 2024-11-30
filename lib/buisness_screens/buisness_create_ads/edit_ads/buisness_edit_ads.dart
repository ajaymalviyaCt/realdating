import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realdating/buisness_screens/buisness_create_ads/create_ads.dart';
import 'package:realdating/custom_iteam/coustomtextcommon.dart';
import 'package:realdating/custom_iteam/customprofile_textfiiled.dart';
import 'package:realdating/validation/validation.dart';
import 'package:realdating/widgets/custom_appbar.dart';
import 'package:realdating/widgets/custom_buttons.dart';

import '../../../function/function_class.dart';
import '../all_ads/all_ads_controller.dart';
import '../all_ads/buisness_all_adss_models.dart';
import 'edit_ads_controller.dart';

class BuisnessEditAds extends StatefulWidget {
  final List<MyAdv> dataList; // Define a list of data to receive
  final int indexEdit;

  const BuisnessEditAds({super.key, required this.dataList, required this.indexEdit});

  @override
  State<BuisnessEditAds> createState() => _BuisnessEditAdsState();
}

class _BuisnessEditAdsState extends State<BuisnessEditAds> {
  String? EditAds;
  final RxList<String> selectedInterest = <String>[].obs;
  AllAdssDealController allAdssDealController = Get.put(AllAdssDealController());
  EditAdsController editAdsController = Get.put(EditAdsController());
  MyAdv? listdata;
  bool showDropdown = false;

  @override
  Widget build(BuildContext context) {
    print("sjfdk");
    print(widget.dataList[widget.indexEdit].title);
    // print(widget.indexEdit);
    return Scaffold(
        appBar: customAppbar("Edit Ad", context),
        body: Obx(
          () => allAdssDealController.isLoadig.value
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
                      customTextC(text: "Upload Image", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          widget.dataList[widget.indexEdit].adImage.trim().isNotEmpty && editAdsController.addImage == null
                              ? InkWell(
                                  onTap: () async {
                                    final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
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
                                        editAdsController.addImage = croppedFile.path;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    height: 135,
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.dataList[widget.indexEdit].adImage,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) {
                                        return upLoadImageWidget(context);
                                      },
                                    ),
                                  ),
                                )
                              : upLoadImageWidget(context),
                        ],
                      ),

                      customTextC(text: "Title", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                          height: 50,
                          child: CustumProfileTextField1(
                            controller: editAdsController.Title,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateName,
                            hintText: widget.dataList[widget.indexEdit].title ?? "",
                          )),

                      //  SizedBox(height: 10,),
                      // customTextC(
                      //     text: "Age(in years)",
                      //     fSize: 16,
                      //     fWeight: FontWeight.w500,
                      //     lineHeight: 36),

                      // SizedBox(
                      //   height: 50,
                      //   child: CustumProfileTextField1(
                      //     controller: editAdsController.Age,
                      //     validator: validateName,
                      //     hintText: widget.dataList[widget.indexEdit].age
                      //             .toString() ??
                      //         "",
                      //     // hintText: "22"
                      //   ),
                      // ),

                      customTextC(text: "Interest", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      /*      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.Intrest,
                          validator: validateName,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "${widget.dataList[widget.indexEdit].interest}",
                          //hintText: "Music,Sports"
                        ),
                      ),
*/
                      TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: editAdsController.Intrest,
                        readOnly: true,
                        // Prevent manual typing
                        onTap: () {
                          setState(() {
                            showDropdown = !showDropdown; // Toggle dropdown
                          });
                        },
                        decoration: InputDecoration(
                          hintText: widget.dataList[widget.indexEdit].interest ?? "Select Interest",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(.15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black.withOpacity(.15),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black.withOpacity(.15),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black.withOpacity(.15)),
                            onPressed: () {
                              setState(() {
                                if (interestList.isEmpty) {
                                  print('Category Index-----$interestList');
                                  Fluttertoast.showToast(msg: 'Interest Not found');
                                } else {
                                  showDropdown = !showDropdown;
                                }
                              });
                            },
                          ),
                        ),
                        cursorColor: Colors.white,
                      ),
                      if (showDropdown) interestDropdownUi(),
                      customTextC(text: "Budget(\$)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.budget,
                          validator: validateName,
                          hintText: "${widget.dataList[widget.indexEdit].budget}",
                          // hintText: "10,000"
                        ),
                      ),

                      customTextC(text: "Campaign Duration(in days)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.CampaignDuration,
                          validator: validateName,
                          hintText: widget.dataList[widget.indexEdit].campaignDuration,
                          //hintText: "3 Months"
                        ),
                      ),

                      customTextC(text: "Location", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.Location,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateName,
                          hintText: widget.dataList[widget.indexEdit].address,
                          //hintText: "3 Months"
                        ),
                      ),

                      customTextC(text: "Range (Miles)", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.Range,
                          validator: validateRange,
                          hintText: "${widget.dataList[widget.indexEdit].rangeKm}" ?? "",
                          //hintText: "10 Km"
                        ),
                      ),

                      customTextC(text: "Link", fSize: 16, fWeight: FontWeight.w500, lineHeight: 36),

                      SizedBox(
                        height: 50,
                        child: CustumProfileTextField1(
                          controller: editAdsController.Link,
                          validator: validateName,
                          keyboardType: TextInputType.emailAddress,
                          hintText: widget.dataList[widget.indexEdit].link,
                        ),
                      ),

                      const SizedBox(height: 30),
                      Obx(
                        () => customPrimaryBtn(
                          btnText: "Save",
                          btnFun: () {
                            setState(() {
                              editAdsController.EditAdsUpdate(widget.dataList[widget.indexEdit].id.toString(), widget.indexEdit,
                                  allAdssDealController.getAllAdsMdoels?.myAdvs[widget.indexEdit]);
                              allAdssDealController.getAllAds();
                            });
                          },
                          loading: editAdsController.isLoadig.value,
                        ),
                      ),

                      Obx(
                        () => customPrimaryBtnBlk(
                          btnText: 'Delete',
                          btnFun: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Are you sure you want to delete this Ad?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            editAdsController.EditAdsDelete(widget.dataList[widget.indexEdit].id);
                                            setState(() {
                                              allAdssDealController.getAllAds();
                                              // controller.myDealsModel;
                                            });
                                            allAdssDealController.refresh();
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

  Container interestDropdownUi() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.15),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          // Main Dropdown Container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4), // Shadow position for soft floating effect
                ),
              ],
            ),
            child: Column(
              children: [
                // Close Button at the top-right with a subtle elegant design
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showDropdown = false; // Close dropdown on tap
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent, // Transparent to make it less intrusive
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.close,
                          color: Colors.redAccent, // Use accent color for contrast
                          size: 24, // Adjust size for a more prominent close button
                        ),
                      ),
                    ),
                  ),
                ),
                // Dropdown List View
                SizedBox(
                  height: 300, // Set height for scrollable list
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: interestList.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedInterest.contains(interestList[index]);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!isSelected) {
                              selectedInterest.add(interestList[index]);
                            } else {
                              selectedInterest.remove(interestList[index]);
                            }
                            editAdsController.Intrest.text = selectedInterest.join(", ");
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.red.withOpacity(0.2) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.redAccent : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                interestList[index],
                                style: TextStyle(
                                  color: isSelected ? Colors.redAccent.shade700 : Colors.black,
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.redAccent,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell upLoadImageWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
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
          editAdsController.addImage = croppedFile.path;
          // const Image();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: editAdsController.addImage == null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 135,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor('#D9D9D9'),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ))
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 135,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('#D9D9D9'),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: FileImage(File(editAdsController.addImage!)), fit: BoxFit.fill)),
                  ),
          ),

          Container(
            height: 141,
            width: MediaQuery.of(context).size.width,
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
                    final XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
                    if (pickImage != null) {
                      setState(() {
                        editAdsController.addImage = pickImage.path;
                      });
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/galleryicon.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Upload Image', style: TextStyle(fontSize: 16, color: Colors.grey))
              ],
            ),
          ),
          // Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(dataList[indexEdit].roomImage))),)
        ],
      ),
    );
  }
}
