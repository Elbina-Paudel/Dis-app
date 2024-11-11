import 'package:disaster_app/screen/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screen/contacts/model/emergency_contact_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmergencyContactModelAdapter());
  await Hive.openBox('userProfile');
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
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(const MyApp());
}
