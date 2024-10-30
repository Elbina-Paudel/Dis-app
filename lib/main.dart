import 'package:disaster_app/screen/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA7nEpZ5CAhQbEjye2NP1JgG9y30A-MSj0",
          authDomain: "disaster-app-514de.firebaseapp.com",
          projectId: "disaster-app-514de",
          storageBucket: "disaster-app-514de.appspot.com",
          messagingSenderId: "555748240899",
          appId: "1:555748240899:web:2f6f5353b50f8cd77f2836"),
    );
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}
