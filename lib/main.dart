import 'package:flutter/material.dart';
import 'pages/lunchDecider.dart';
import 'pages/onBoarding.dart';
import 'utils/colorSetting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant picker',
      home: OnBoarding(),
    );
  }
}

