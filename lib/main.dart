import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'pages/landing_page.dart';
import 'pages/onboarding_page.dart';
import 'services/firebase_options.dart';



void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );


 runApp(const MyApp());
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

