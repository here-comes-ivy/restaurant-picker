import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/userDataProvider.dart';
import 'services/locationDataProvider.dart';
import 'services/mapFilterProvider.dart';
import 'wip/temp_favoriteStateProvider.dart';
import 'services/restaurantDataProvider.dart';

import 'pages/onboarding_page.dart';
import 'pages/landing_page.dart';
import 'pages/profile_page.dart';
import 'pages/chat_test_page.dart';
import 'pages/map_page.dart';
import 'wip/fav_personalList.dart';
import 'pages/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteStateProvider()),
        ChangeNotifierProvider(create: (context) => RestaurantProvider()),
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
        fontFamily: 'Poppins',
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
