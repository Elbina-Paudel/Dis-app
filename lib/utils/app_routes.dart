import 'package:flutter/material.dart';

import '../screen/authentication/auth_screen.dart';
import '../screen/authentication/signin.dart';
import '../screen/authentication/signup.dart';
import '../screen/home/home_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/auth': (context) => const AuthScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const SignUpScreen(),
  '/home': (context) => const HomeScreen(),
};
