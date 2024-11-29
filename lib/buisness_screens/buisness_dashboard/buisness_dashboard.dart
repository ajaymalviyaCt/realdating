import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realdating/buisness_screens/buisness_home/Bhome_page/buisness_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../function/function_class.dart';
import '../../reel/common_import.dart';
import '../../welcome_screen/optionButton.dart';
import '../buisness_controller/buisness_login/buisness_login.dart';
import '../buisness_controller/buisness_login/buisness_logincontroller.dart';
import '../buisness_create_ads/all_ads/all_ads.dart';
import '../buisness_home/ProfileData_modal.dart';
import '../buisness_home/controller/business_home_controller.dart';
import '../buisness_profile/buisness_profile.dart';
import '../buisness_profile/business_profile_controller.dart';

class DashBaordScreen extends StatefulWidget {
  const DashBaordScreen({Key? key}) : super(key: key);

  @override
  State<DashBaordScreen> createState() => _DashBaordScreenState();
}

class _DashBaordScreenState extends State<DashBaordScreen> {
  var profile_image, business_name;
  MyDealController myDealController = Get.put(MyDealController());
  final BusinessProfileController profileController = Get.put(BusinessProfileController());

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile_image = prefs.get('profile_image');
    business_name = prefs.getString('business_name');
  }

  var success, message, id, email;

  ProfileDataModal ? profile_data;

  //
  // Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  BuisnessLoginController buissnesloginController =
      Get.put(BuisnessLoginController());

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Logout"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", false);
        buissnesloginController.buisnessemailController.clear();
        buissnesloginController.buisnesspasswordController.clear();
        buissnesloginController.isLoadigLogin.value = false;
        Get.offAll(()=>const OptionScreen());
        print(prefs.get("isLoggedIn"));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BuisnessLogin()),
        );
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure, do you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getDasboardData() async {
    await myDealController.getDashBoard();
    await myDealController.getDashBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: CustomTextStyle.black,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: HexColor('#EDEDED'),
                child: Obx(
                      ()=> CachedNetworkImage(
                    imageUrl: profileController.bussinessCoverprofilepic.toString(),
                    placeholder: (context, url) => const Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ))),
                    errorWidget: (context, url, error) =>
                     Image.asset('assets/images/placeholder_image_business.jpg'),
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  left: 20,
                  top: 90,
                  child: Obx(
                        ()=> Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(profileController.bussinessProfilepic.toString())),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: Vx.red200),
                        color: Colors.transparent,
                      ),
                    ),
                  )),
              Positioned(
                left: 20,
                top: 160,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(8)

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Obx(
                            ()=> Text(
                          profileController.bussinessName.value.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Aboshi",
                            color: Appcolor.black,
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/home-04.svg'),
                const Text('       Home')
              ],
            ),
            onTap: () {
              Get.offAll(()=>BuisnessHomePage());
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/dashb.svg'),
                const Text('       Dashboard')
              ],
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/profile.svg'),
                const Text('       My Profile')
              ],
            ),
            onTap: () {
              Get.to(() => const BusinessProfile());
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/allAds.svg'),
                const Text('       All Ads')
              ],
            ),
            onTap: () {
              Get.to(() => const All_Ads());
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/logout.svg'),
                const Text('       Logout')
              ],
            ),
            onTap: () async {
              showAlertDialog(context);
            },
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getDasboardData(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Obx(() => myDealController.isLoadig.value
                    ? Container(
                        margin: const EdgeInsets.only(top: 150),
                        child: const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )))
                    : Container(
                      height: 400,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
                        children: [
                          Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    15.widthBox,
                                    SvgPicture.asset(
                                        'assets/icons/heart_red.svg'),
                                    Spacer(),
                                    const Text(
                                      'Likes           ',
                                      style: CustomTextStyle.blackLocF,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  myDealController.dashboardModelData
                                          ?.dashboad[0].totalLike
                                          .toString() ??
                                      "0",
                                  style: CustomTextStyle.black,
                                ),

                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    10.widthBox,
                                    SvgPicture.asset('assets/icons/comment.svg'),
                                    Spacer(),
                                    const Text(
                                      'Comments     ',
                                      style: CustomTextStyle.blackLocF,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  myDealController.dashboardModelData
                                          ?.dashboad[0].totalComment
                                          .toString() ??
                                      "0",
                                  style: CustomTextStyle.black,
                                ),

                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    10.widthBox,
                                    SvgPicture.asset(
                                        'assets/icons/percentage.svg'),
                                    Spacer(),
                                    const Text(
                                      'Saved Deal     ',
                                      style: CustomTextStyle.blackLocF,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  myDealController.dashboardModelData
                                          ?.dashboad[0].totalDeal
                                          .toString() ??
                                      "0",
                                  style: CustomTextStyle.black,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
