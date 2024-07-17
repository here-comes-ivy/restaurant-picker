import 'package:flutter/material.dart';
import 'pages/onBoarding.dart';
import 'utils/colorSetting.dart';

import 'pages/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Picker',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark, 
        ),
      ),
      home: resultPage(),
    );
  }
}

