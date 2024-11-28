import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realdating/buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import 'package:realdating/function/function_class.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../const.dart';
import '../../../reel/common_import.dart';
import '../../buisness_home/ProfileData_modal.dart';
import '../edit_ads/buisness_edit_ads.dart';
import 'all_ads_controller.dart';

class All_Ads extends StatefulWidget {
  const All_Ads({super.key});

  @override
  State<All_Ads> createState() => _All_AdsState();
}

class _All_AdsState extends State<All_Ads> {
  AllAdssDealController allAdssDealController = Get.put(AllAdssDealController());
  var success, message, id, email;
  var profile_image, business_name;
  BusinessInfo? profile_data;

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile_image = prefs.get('profile_image');
    business_name = prefs.getString('business_name');
  }

  Future<ProfileDataModal> getprofile() async {
    print('::::::::::::::1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('user_id');
    var token = prefs.get('token');
    print('::::::::::::::2');
    // check().then((intenet) {
    //   if (intenet) {
    //     // Internet Present Case
    //     //   showLoaderDialog(context);
    //   } else {
    //     Fluttertoast.showToast(
    //         msg: "Please check your Internet connection!!!!",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.BOTTOM,
    //         backgroundColor: colorgrey,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    // });
    //`showLoaderDialog(context);
    Map toMap() {
      var map = new Map<String, dynamic>();
      map["id"] = userId.toString();
      return map;
    }

    print(toMap());
    print('::::::::::::::3');
    var response = await http.post(Uri.parse('https://forreal.net:4000/myprofile'), body: toMap(), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    });
    print(':::::::::::::::::4');
    print("success 123 ==${response.body}");
    success = ProfileDataModal.fromJson(json.decode(response.body)).success;
    message = ProfileDataModal.fromJson(json.decode(response.body)).message;
    print("success 123 ==${response.body}");
    if (success == true) {
      setState(() {
        profile_data = ProfileDataModal.fromJson(json.decode(response.body)).businessInfo;
      });

      // Fluttertoast.showToast(
      //     msg: message,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: colorgrey,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    } else {
      Navigator.pop(context);
      print('else==============');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: colorgrey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return ProfileDataModal.fromJson(json.decode(response.body));
  }

  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  void initState() {
    getprofile();
    _loadCounter();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
              onTap: () {
                Get.off(() => const BuisnessHomePage());
              },
              child: SvgPicture.asset('assets/icons/btn.svg')),
        ),
        title: const Text(
          'All Ads',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await allAdssDealController.All_AdsD();
        },
        child: SafeArea(
          child: Obx(
            () => allAdssDealController.isLoadig.value
                ? const Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ))
                : allAdssDealController.getAllAdsMdoels?.myAdvs.length != null &&
                        allAdssDealController.getAllAdsMdoels?.myAdvs.length != 0
                    ? ListView.builder(
                        itemCount: allAdssDealController.getAllAdsMdoels?.myAdvs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.10),
                                      offset: const Offset(0, 10),
                                      blurRadius: 15,
                                      // spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Vx.red100),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: CachedNetworkImage(
                                                  imageUrl: profile_data?.profileImage ?? "",
                                                  placeholder: (context, url) => const Center(
                                                      child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 1,
                                                          ))),
                                                  errorWidget: (context, url, error) => const Icon(Icons.person_2_outlined),
                                                  filterQuality: FilterQuality.low,
                                                  fit: BoxFit.fill,
                                                  height: 300,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              customTextCommon(
                                                text: profile_data?.businessName ?? "Fauget",
                                                fSize: 14,
                                                fWeight: FontWeight.w600,
                                                lineHeight: 21,
                                                letterSpacing: -0.3,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              customTextCommon(
                                                text: "Sponsored",
                                                fSize: 10,
                                                fWeight: FontWeight.w500,
                                                lineHeight: 10,
                                                color: const Color(0xffAAAAAA),
                                                letterSpacing: -0.3,
                                              )
                                            ],
                                          ),

                                          const Spacer(),

                                          InkWell(
                                              onTap: () {
                                                Get.to(() => BuisnessEditAds(
                                                      dataList: allAdssDealController.getAllAdsMdoels!.myAdvs.toList(),
                                                      indexEdit: index,
                                                    ));
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              )),
                                          //SvgPicture.asset("assets/icons/cornermenu.svg",height: 24,)
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          height: 296,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                          child: Container(
                                            constraints: const BoxConstraints.expand(height: 110.0),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: "${allAdssDealController.getAllAdsMdoels?.myAdvs[index].adImage}",
                                              placeholder: (context, url) {
                                                return const Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              },errorWidget: (context, url, error) {
                                                return Image.asset('assets/icons/business_ads.png',scale:3,);
                                              },
                                            ),
                                            // child: Stack(
                                            //   children: [
                                            //     Center(
                                            //         child: SvgPicture.asset(
                                            //             'assets/icons/Video_icon.svg')),
                                            //
                                            //     // SvgPicture.asset('assets/icons/Video_icon.svg',color: Colors.red,height: 35,width: 35),
                                            //     //Image.asset("assets/images/homepagesc.png")
                                            //   ],
                                            // ),
                                          )),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //customTextCommon(text: "TTT",  fSize: 14, fWeight: FontWeight.w600, lineHeight: 21, letterSpacing: -0.3,),
                                      customTextCommon(
                                        text: "${allAdssDealController.getAllAdsMdoels?.myAdvs[index].title}",
                                        fSize: 14,
                                        fWeight: FontWeight.w600,
                                        lineHeight: 21,
                                        letterSpacing: -0.3,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      customTextCommon(
                                        text: "${allAdssDealController.getAllAdsMdoels?.myAdvs[index].campaignDuration}",
                                        fSize: 12,
                                        fWeight: FontWeight.w400,
                                        lineHeight: 14.52,
                                        color: const Color(0xffAAAAAA),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("No Data Found !!")),
          ),
        ),
      ),
    );
  }
}
