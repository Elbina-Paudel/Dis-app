import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._();

  AppColors._();

  static AppColors get instance => _instance;

  final Color darkBrown = const Color(0xffbf592b);
  final Color lightBrown = const Color(0xffedbea4);
  final Color whiteColor = const Color(0xffffffff);
}
