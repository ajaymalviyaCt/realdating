import 'package:flutter/cupertino.dart';

import '../buisness_profile/buisness_profile.dart';

class BuisnessBottomBar extends StatefulWidget {
  const BuisnessBottomBar({super.key});

  @override
  State<BuisnessBottomBar> createState() => _BuisnessBottomBarState();
}

class _BuisnessBottomBarState extends State<BuisnessBottomBar> {
  PageController controller = PageController();
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    //BuisnessHomePage(),
    // ExplorePage(),
    // Matches(),
    // MatchesPage(),
    // EventsPage(),
    const BusinessProfile(),
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
