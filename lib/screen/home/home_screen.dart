import 'dart:io';

import 'package:disaster_app/screen/Pages/gamezone.dart';
import 'package:disaster_app/screen/Pages/logout.dart';
import 'package:disaster_app/screen/Pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/home_app_bar.dart';
import '../Pages/profile.dart';
import 'utils/home_screen_items.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  File? _profileImage;
  void bottomNavIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: homeScreenItems[_currentIndex]['title'],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF673AB7), Color(0xFFD1C4E9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Elbina Paudel"),
                accountEmail: const Text("elbinapaudel@gmail.com"),
                currentAccountPicture: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/default_profile.png')
                            as ImageProvider<Object>,
                  ),
                ),
                decoration: const BoxDecoration(color: Color(0xFF673AB7)),
              ),
              _buildDrawerItem(
                icon: Icons.person,
                title: 'Profile',
                context: context,
                page: ProfilePage(),
              ),
              _buildDrawerItem(
                icon: Icons.games,
                title: 'Game Zone', // New menu item for GameZone
                context: context,
                page: QuizGame(), // Navigate to GameZone
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                context: context,
                page: const SettingsPage(),
              ),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                context: context,
                page: LogoutPage(),
              ),
            ],
          ),
        ),
      ),
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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
    );
  }
}
