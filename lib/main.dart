import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'services/userDataProvider.dart';
import 'services/locationDataProvider.dart';

import 'pages/onboarding_page.dart';
import 'temp/registration_page.dart';
import 'pages/landing_page.dart';
import 'pages/profile_page.dart';
import 'pages/chat_test_page.dart';
import 'pages/map_page.dart';
import 'pages/favorite_page.dart';
import 'pages/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
          create: (context) => LocationDataProvider(),
        ) // 提供 UserProvider
      ],
      child: MyApp(),
    ),
  );
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
      home: LandingPage(),
    );
  }
}
