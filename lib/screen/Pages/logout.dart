import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  _signOutUser() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure to logout?"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/auth');
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _signOutUser();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('Confirm Logout',
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
