import 'package:flutter/material.dart';

import '../../widgets/home_app_bar.dart';
import 'utils/home_screen_items.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  void bottomNavIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: homeScreenItems[_currentIndex]['title']),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 2),
        child: homeScreenItems[_currentIndex]['screen'],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: bottomNavIndex,
      ),
    );
  }
}
