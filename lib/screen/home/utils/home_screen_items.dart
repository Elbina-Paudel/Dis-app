import 'package:flutter/material.dart';

import '../../contacts/contact_screen.dart';
import '../../home_main/home_main_screen.dart';

List<Map<String, dynamic>> homeScreenItems = [
  {
    "title": "Intelliaid",
    "screen": const HomeMainScreen(),
    "icon": const Icon(Icons.home),
  },
  {
    "title": "Contact",
    "screen": const ContactScreen(),
    "icon": const Icon(Icons.contacts),
  },
  {
    "title": "Video",
    "screen": const HomeMainScreen(),
    "icon": const Icon(Icons.video_library),
  },
  {
    "title": "Humidity",
    "screen": const HomeMainScreen(),
    "icon": const Icon(Icons.water),
  },
  {
    "title": "Chat Bot",
    "screen": const HomeMainScreen(),
    "icon": const Icon(Icons.message),
  },
];
