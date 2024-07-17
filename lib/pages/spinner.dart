import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:restaurant_picker/utils/colorSetting.dart';
// https://pub.dev/packages/flutter_fortune_wheel/example
import '/utils/responsiveSize.dart';



class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  late StreamController<int> controller;

  FortuneItem foodItem(name){
    return FortuneItem(
      child: Container(
        child: Column(
          children: [
            Image.asset('assets/food/$name.png'),
            Text(name),
          ],
        ),
      ),
    );
  }
  

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FortuneBar(
      height: ResponsiveSize.dialogHeight(context),
      fullWidth: true,
      styleStrategy: UniformStyleStrategy(
        color: appColors.onFourth, 
        borderColor: appColors.onFifth,   
        borderWidth: 10,
      ),
      selected: controller.stream,
      items: [
        foodItem('Ramen'),
        foodItem('Sushi'),
        foodItem('Pizza'),
        foodItem('Hamburger'),
        foodItem('Fried Chicken'),
      ],
    );
  }
}