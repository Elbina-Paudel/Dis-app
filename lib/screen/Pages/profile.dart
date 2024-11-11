import 'dart:io';

import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentSnapshot? _userData;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        // Save to Hive or local storage if needed
      });
    }
  }

  // Fetch the user's data from Firestore
  Future<void> _fetchUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      setState(() {
        _userData = snapshot;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _userData != null
            ? Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/default_profile.png')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileField("Full Name", _userData!['fullname']),
                  _buildProfileField("Email", _userData!['email']),
                  _buildProfileField("Address", _userData!['address']),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  // Widget to build each profile field
  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
