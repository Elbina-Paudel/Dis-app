import 'package:disaster_app/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
  BuildContext context, {
  required String title,
}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, "/auth");
        },
        icon: Icon(
          Icons.logout,
          color: AppColors.instance.whiteColor,
        ),
      ),
    ],
    backgroundColor: AppColors.instance.darkBrown,
  );
}
