import 'package:flutter/material.dart';

import '../utils/home_screen_items.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black38,
      items: homeScreenItems
          .map((value) => BottomNavigationBarItem(
                icon: value['icon'] as Icon,
                label: value['title'] as String,
              ))
          .toList(),
    );
  }
}
