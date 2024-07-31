import 'package:flutter/material.dart';
import 'pages/landing_page.dart';


void main() => runApp(const myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

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
      home: const LandingPage(),
    ); 
  }
}

