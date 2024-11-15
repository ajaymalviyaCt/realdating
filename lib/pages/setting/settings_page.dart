import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realdating/welcome_screen/optionButton.dart';
import 'package:realdating/widgets/custom_text_styles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_colors.dart';
import '../a_frist_pages/changepassword/change_password.dart';
import '../a_frist_pages/login_page/login_controller.dart';
import '../edit_profle/edit_profile.dart';
import '../invite_friends/invite_friend_page.dart';
import '../profile/profile_controller.dart';
import '../support.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LoginController loginController = Get.put(LoginController());



  Future<void> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    try {
      // Display loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Define headers and API endpoint
      var headers = {
        'Authorization':
        'Bearer $token'
      };
      var dio = Dio();
      var response = await dio.request(
        'https://forreal.net:4000/users/delete_User',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      Get.back(); // Remove loading dialog

      if (response.statusCode == 200) {
        // Handle successful deletion
        // await logoutUser();
        Get.offAll(() => const OptionScreen()); // Redirect to login screen
        Get.snackbar("Account Deleted", "Your account has been successfully deleted.",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        // Handle API error
      //  showErrorDialog("Failed to delete account: ${response.statusMessage}");
      }
    } catch (e) {
      Get.back(); // Remove loading dialog in case of error
    //  showErrorDialog("An error occurred: ${e.toString()}");
    }
  }






  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Logout"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLogin", false);
        loginController.passwordController.clear();
        loginController.emailController.clear();
        Get.offAll(()=>const OptionScreen());
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



  deleteAccountAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Delete"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLogin", false);
        loginController.passwordController.clear();
        loginController.emailController.clear();
        Get.offAll(()=>const OptionScreen());
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure, do you want to Delete Account?"),
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


  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.profileDaitails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: customTextCommon(
          text: 'Setting',
          fSize: 24,
          fWeight: FontWeight.w600,
          lineHeight: 24,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                print("Go back");
                Get.back();
                //Get.back();
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: const Color(
                        0xFFE8E6EA), // Border color, equivalent to var(--border-e-8-e-6-ea, #E8E6EA) in CSS
                    width: 1.0, // Border width
                  ),
                  color: const Color(
                      0xFFFFFFFF), // Background color, equivalent to var(--white-ffffff, #FFF) in CSS
                ),
                child: const Icon(Icons.arrow_back_ios_outlined,
                    color: colors.primary, size: 18),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => const EditProfilePage());
              },
              child: iconwithTextContainer(
                  context, "Edit Profile", "assets/icons/user.svg"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ChangePasswordPagePage());
              },
              child: iconwithTextContainer(
                  context, "Change Password", "assets/icons/lock-01.svg"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const InviteFriendPage());
              },
              child: iconwithTextContainer(context, "Invite Friends",
                  "assets/icons/users-profiles-02.svg"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const SupportScreen());
              },
              child: iconwithTextContainer(
                  context, "Support", "assets/icons/Icon.svg"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Container(
                height: 54,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset('assets/icons/logout.svg'),
                    const SizedBox(
                      width: 15,
                    ),
                    customTextCommon(
                      text: "Log Out",
                      fSize: 16,
                      fWeight: FontWeight.w500,
                      lineHeight: 16,
                      color: const Color(0xffFB4967),
                    )
                  ],
                ),
              ),
            ),


            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => deleteAccountAlertDialog(context),
              child: Container(
                height: 54,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 15),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  iconwithTextContainer(context, title, imageName) {
    return Column(
      children: [
        Container(
          height: 54,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0xffEDEDED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset('$imageName'),
              const SizedBox(
                width: 15,
              ),
              customTextCommon(
                  text: "$title",
                  fSize: 16,
                  fWeight: FontWeight.w500,
                  lineHeight: 16)
            ],
          ),
        ),
      ],
    );
  }
}
