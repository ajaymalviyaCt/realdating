import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realdating/home_page_new/home_page_user.dart';
import 'package:realdating/pages/profile/profile_controller.dart';
import 'package:realdating/pages/profile/profile_screen.dart';
import 'package:realdating/pages/swipcard/swip_card_page.dart';
import 'package:realdating/pages/swipcard/tinder_card_controller.dart';
import 'package:get/get.dart';
import '../buisness_screens/buisness_home/Bhome_page/homepage_bussiness_controller.dart';
import '../home_page_new/home_page_user_controller.dart';
import 'classified_request/get_classified_request_pages.dart';
import 'explore/explore.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  PageController controller = PageController();
  int _selectedIndex = 0;
  ProfileController profileController = Get.put(ProfileController());
  HomepageBusinessController postsddC = Get.put(HomepageBusinessController());
  TinderSwipController tinderSwipController = Get.put(TinderSwipController());
  HomePageUserController postsC = Get.put(HomePageUserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static final List<Widget> _widgetOptions = [
    const HomePageUser(),
    const ExplorePage(),
    const SwipCardPage(),
    const GetClassifiedRequestPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                  child: SvgPicture.asset('assets/icons/home-04.svg', color: _selectedIndex == 0 ? Colors.redAccent : Colors.black))),
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                child: SvgPicture.asset(
                  'assets/icons/compass.svg',
                  color: _selectedIndex == 1 ? Colors.redAccent : Colors.black,
                )),
          ),
          BottomNavigationBarItem(
            label: 'Match',
            icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                child: SvgPicture.asset('assets/icons/heart_new.svg', color: _selectedIndex == 2 ? Colors.redAccent : Colors.black)),
          ),
          BottomNavigationBarItem(
            label: 'Classified',
            icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                child: SvgPicture.asset('assets/icons/iconlock.svg', color: _selectedIndex == 3 ? Colors.redAccent : Colors.black)),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                child: SvgPicture.asset('assets/icons/Groupperson.svg', color: _selectedIndex == 4 ? Colors.redAccent : Colors.black)),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ),
      ),
    );
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        bodySmall: base.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  secondary: shrinePink50,
  surface: shrineSurfaceWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
