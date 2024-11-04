import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import '../utils/quotes.dart';
import '../utils/slider.dart';
import 'Navigators/chat.dart';
import 'Navigators/contact.dart';
import 'Navigators/humidity.dart';
import 'Navigators/video.dart';
import 'Pages/emergency_button.dart';
import 'Pages/logout.dart';
import 'Pages/profile.dart';
import 'Pages/settings.dart';
import 'caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disaster_app/utils/viewmap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_screen.dart';
import 'package:disaster_app/screen/Pages/gamezone.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  File? _profileImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
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

  static const List<Widget> _pages = <Widget>[
    HomeContentPage(),
    ContactPage(),
    VideoPage(),
    WeatherPage(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intelliaid'),
        backgroundColor: const Color(0xFF673AB7),
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
                page: const ProfilePage(),
              ),
              _buildDrawerItem(
                icon: Icons.games,
                title: 'Game Zone', // New menu item for GameZone
                context: context,
                page: const QuizGame(), // Navigate to GameZone
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
                page: const LogoutPage(),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water),
            label: 'Humidity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat Bot',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF673AB7),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
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

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        QuotesWidget(),
        NewsSlider(),
        Expanded(
          child: Center(
            child: Text(
              'Welcome to Intelliaid',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF673AB7),
              ),
            ),
          ),
        ),
        EmergencyButtons(),
        SizedBox(height: 20),
        EmergencyRedButton(),
      ],
    );
  }
}

class EmergencyButtons extends StatelessWidget {
  const EmergencyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Emergency Contacts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF673AB7),
          ),
        ),
        Wrap(
          children: [
            _emergencyButton('🚑 Ambulance', '102'),
            _emergencyButton('👮 Police', '100'),
            _emergencyButton('🚒 Fire Brigade', '101'),
            _emergencyButton('📞 Close One', '+9779846091133'),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MapView(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF673AB7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('View Maps'),
        ),
      ],
    );
  }

  ElevatedButton _emergencyButton(String label, String number) {
    return ElevatedButton(
      onPressed: () => Caller.callNumber(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF673AB7),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }
}

class EmergencyRedButton extends StatelessWidget {
  const EmergencyRedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EmergencyButton(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shadowColor: Colors.redAccent,
            elevation: 5,
          ),
          child: const Text(
            'Emergency Alert',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
