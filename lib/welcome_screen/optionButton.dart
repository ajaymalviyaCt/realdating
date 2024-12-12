import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../buisness_screens/buisness_controller/buisness_login/buisness_login.dart';
import '../pages/a_frist_pages/login_page/login.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // zoomContainer();
    // TODO: implement initState
    super.initState();
    // Timer(const Duration(minutes: 10), () async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var user_id = prefs.getInt('user_id');
    //
    //   bool? isLoggedIn = prefs.getBool('isLoggedIn');
    //   bool? isLoggedInU = prefs.getBool('isLoggedInUser');
    //   var firstTimeOnApp;
    //   bool? isFirstTime = prefs.getBool("firstTimeOnApp");
    //
    //   if (firstTimeOnApp == null && isFirstTime == false) {
    //     firstTimeOnApp = prefs.setBool("firstTimeOnApp", true);
    //     Get.off(() => Onbording());
    //   } else if (isLoggedInU == true && isFirstTime == true) {
    //     Get.off(() => DashboardPage());
    //   } else {
    //     if (isLoggedIn == true && isFirstTime == true) {
    //       Get.off(() => BuisnessHomePage());
    //     } else {
    //       Get.off(() => BuisnessLogin());
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Image.asset(
          'assets/images/Background 1.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(height: 20 /**/),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: SvgPicture.asset(
                'assets/icons/face-smile-regular .svg',
                fit: BoxFit.none,
                color: Colors.white,
                height: 34,
                width: 34,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 55),
                    child: Center(child: Image(image: AssetImage('assets/images/Forrealdating.png'), fit: BoxFit.cover, height: 300, width: 300)),
                  ),
                  const Image(image: AssetImage('assets/images/Background Pattern.png'), fit: BoxFit.fill),
                  Positioned(
                    bottom: 0,
                    right: 22,
                    left: 22,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)],
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 56)),
                              backgroundColor: WidgetStateProperty.all(Colors.transparent),
                              shadowColor: WidgetStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              Get.to(() => const LoginScreenPage());
                            },
                            child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text(
                                      "Login as User",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 2.0)],
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 56)),
                              backgroundColor: WidgetStateProperty.all(Colors.transparent),
                              shadowColor: WidgetStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              Get.to(() => const BuisnessLogin());
                            },
                            child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text(
                                      "Login as Business",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
