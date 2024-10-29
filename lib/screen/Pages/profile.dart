// profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // Variable to store the profile image
  final picker = ImagePicker(); // Image picker instance

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile != null ? File(pickedFile.path) : null; // Update profile image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage, // Trigger image selection on tap
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/default_profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileField("Name", "Elbina Paudel"),
            _buildProfileField("Address", "Kathmandu, Nepal"),
            _buildProfileField("Phone Number", "+977-1234567890"),
            _buildProfileField("Education", "Bachelor of Engineering"),
            _buildProfileField("Email", "elbinapaudel@gmail.com"),
          ],
        ),
      ),
    );
  }

  // Method to create profile fields
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
