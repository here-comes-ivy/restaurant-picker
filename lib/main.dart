import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'pages/onboarding_page.dart';
import 'pages/registration_page.dart';
import 'pages/landing_page.dart';
import 'pages/profile_page.dart';
import 'pages/filter_page.dart';
import 'pages/chat_page.dart';
import 'pages/map_page.dart';
import 'pages/favorite_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark, 
        ),
      ),
      home: OnBoarding(),
    ); 
  }
}

