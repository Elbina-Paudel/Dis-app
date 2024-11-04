import 'package:disaster_app/screen/Navigators/chat.dart';
import 'package:disaster_app/screen/Navigators/humidity.dart';
import 'package:flutter/material.dart';

import '../../Navigators/video.dart';
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
    "screen": const VideoPage(),
    "icon": const Icon(Icons.video_library),
  },
  {
    "title": "Humidity",
    "screen": const WeatherPage(),
    "icon": const Icon(Icons.water),
  },
  {
    "title": "Chat Bot",
    "screen": const ChatPage(),
    "icon": const Icon(Icons.message),
  },
];
