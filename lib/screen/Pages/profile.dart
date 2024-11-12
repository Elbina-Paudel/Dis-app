import 'dart:io';

import 'package:disaster_app/screen/Pages/close_one_widget.dart';
import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../contacts/service/close_contact_service.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const NetworkImage('https://placehold.co/600x400')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileField("Full Name", _userData!['fullname']),
                  _buildProfileField("Email", _userData!['email']),
                  _buildProfileField("Address", _userData!['address']),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Close One",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const CloseOneWidget(),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: CloseContactService().getAllContact(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error");
                      }
                      if (snapshot.hasData) {
                        return snapshot.data!.isEmpty
                            ? const Center(
                                child: Text("Nothing to Display"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        snapshot.data![index].username
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              );
                      }
                      return const Center(
                        child: Text("Loading..."),
                      );
                    },
                  ),
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
