import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, '/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 248, 248),  // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add the logo
            Image.asset(
              'assets/logo.gif',
              height: 150.0,  // Adjust height as needed
              width: 150.0,   // Adjust width as needed
            ),
            const SizedBox(height: 20.0),  // Add space between logo and text
            // Add the app title text
            const Text(
              'Intelliaid!',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xffbf592b), // Set text color to white
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
