import 'package:disaster_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../screen/Pages/auth_screen.dart';
import '../screen/authentication/signin.dart';
import '../screen/authentication/signup.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/auth': (context) => const AuthScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const SignUpScreen(),
  '/home': (context) => const HomePage(),
};
