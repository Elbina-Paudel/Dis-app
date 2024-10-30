import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required String title,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color(0xFF673AB7),
  );
}
