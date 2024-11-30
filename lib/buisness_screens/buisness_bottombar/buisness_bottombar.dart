import 'package:flutter/cupertino.dart';

import '../buisness_home/Bhome_page/buisness_home.dart';
import '../buisness_profile/buisness_profile.dart';

class BuisnessBottomBar extends StatefulWidget {
  @override
  State<BuisnessBottomBar> createState() => _BuisnessBottomBarState();
}

class _BuisnessBottomBarState extends State<BuisnessBottomBar> {
  PageController controller = PageController();
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    //BuisnessHomePage(),
    // ExplorePage(),
    // Matches(),
    // MatchesPage(),
    // EventsPage(),
    BusinessProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
