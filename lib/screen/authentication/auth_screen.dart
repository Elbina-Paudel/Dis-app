import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'signin.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // check user is logged in or not
  Future<bool> _checkUserLoggedIn() async {
    final users = FirebaseAuth.instance.currentUser;

    if (users != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData && snapshot.data == true) {
            return const HomeScreen();
          }

          if (snapshot.hasData && snapshot.data == false) {
            return const LoginScreen();
          }
          return const SizedBox.shrink();
        });
  }
}
