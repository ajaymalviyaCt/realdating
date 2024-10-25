import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../function/function_class.dart';
import '../pages/a_frist_pages/login_page/login.dart';
import 'optionButton.dart';

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _Onbordingtate();
}

class _Onbordingtate extends State<Onbording> {
  final int _numPages = 3;
  final pageController = PageController(
    initialPage: 0,
  );
  double currentPage = 0;
  double _value = 0;

  List<Color> _pageColors = [
    Colors.red,
    Colors.red,
    Colors.red,
  ];

  List<Widget> _buildPageIndicator() {

    List<Widget> list = [];
    for (int i = 0; i < _pageColors.length; i++) {
      list.add(
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == i ? _pageColors[i] : Colors.grey,
          ),
        ),
      );
    }
    return list;
  }


  //indicator handler
  @override
  void initState() {
    //page controller is always listening
    //every pageview is scrolled sideways it will take the index page
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toDouble();
        print(currentPage);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (int page) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            bool? isFirstTime = prefs.getBool("firstTimeOnApp");
            print("dekkkkk");
            print(isFirstTime);
          prefs.setBool("firstTimeOnApp", true);
            setState(() {
              currentPage = page.toDouble();
            });
          },
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/girl2.png'),
                const SizedBox(height: 25),
                const Text(
                  'Find your best friend '
                  '\n            with us',
                  style: CustomTextStyle.TextPink,
                ),
                const SizedBox(height: 5),
                const Text(
                    'We match you with people that have a'
                    '\nlarge array of similar interests.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Appcolor.daek,
                    )),
                const SizedBox(height: 30),



                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
               const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        // _increment();
                        pageController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 120,
                              width: 120,
                              // alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/icons/skip.png',
                                fit: BoxFit.fill,
                              )),
                          const Positioned(
                              right: 38,
                              bottom: 40,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 40,
                              ))
                        ],
                      )),
                ),
              ],
            ),

            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15, top: 55),
                  width: 235,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/girl2 (1).png'),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                const Text(
                  'Find your best matches',
                  style: CustomTextStyle.TextPink,
                ),
               const SizedBox(height: 10),
                const  Text(
                    'We match you with people that have a'
                    '\n       large array of similar interests.',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Appcolor.daek)),
                const SizedBox(height: 30),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        pageController.nextPage(
                            duration:const Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 120,
                              width: 120,
                              // alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/icons/skip.png',
                                fit: BoxFit.fill,
                              )),
                          const Positioned(
                              right: 38,
                              bottom: 40,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 40,
                              ))
                        ],
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 15, top: 55),
                  width: 235,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image:const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/girl2 (2).png'),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                const Text(
                  'Find your partner',
                  style: CustomTextStyle.TextPink,
                ),
                SizedBox(height: 10),
                const Text(
                    'Sign up today and enjoy the first month'
                    '\n          of premium benefits on us.',
                    style:  TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Appcolor.daek)),
                SizedBox(height: 30),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () async {
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         await prefs.setBool("isShowOnboarding",false);
                          Get.to(() => const OptionScreen());
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 120,
                              width: 120,
                              // alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/icons/skip.png',
                                fit: BoxFit.fill,
                              )),
                          const Positioned(
                              right: 38,
                              bottom: 40,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 40,
                              ))
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
