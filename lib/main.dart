import 'package:flutter/material.dart';
import 'pages/landingpage.dart';


void main() => runApp(myApp());

class myApp extends StatelessWidget {
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

