import 'dart:io';
import 'package:disaster_app/screen/Pages/logout.dart';
import 'package:disaster_app/screen/Pages/profile.dart';
import 'package:disaster_app/screen/Pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:disaster_app/utils/emergencybutton.dart';
import 'package:disaster_app/screen/Navigators/chat.dart';
import 'package:disaster_app/screen/Navigators/contact.dart';
import 'package:disaster_app/screen/Navigators/humidity.dart';
import 'package:disaster_app/screen/Navigators/video.dart';
import 'package:disaster_app/utils/quotes.dart';
import 'package:disaster_app/utils/slider.dart';
import 'caller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disaster_app/utils/viewmap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:disaster_app/screen/signin.dart';
//import 'package:disaster_app/screen/signup.dart'; // Import your login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        // Add other routes as needed
      },
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
      if (user == null && mounted) { // Check if the widget is mounted before navigation
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) { // Check if the widget is mounted before updating state
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
    return Column(
      children: [
        const QuotesWidget(),
        NewsSlider(),
        const Expanded(
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
        const EmergencyButtons(),
        const SizedBox(height: 20),
        const EmergencyRedButton(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _emergencyButton('🚑 Ambulance', '102'),
            _emergencyButton('👮 Police', '100'),
            _emergencyButton('🚒 Fire Brigade', '101'),
            _emergencyButton('📞 Close One', '+9779846091133'),
          ],
        ),
        const SizedBox(height: 20), // Add space before the button
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MapView(), // Navigate to MapPage
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
