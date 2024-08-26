import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:restaurant_picker/utils/colorSetting.dart';
// https://pub.dev/packages/flutter_fortune_wheel/example
import '/utils/responsiveSize.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  SpinnerState createState() => SpinnerState();
}

class SpinnerState extends State<Spinner> {
  late StreamController<int> controller;

  FortuneItem foodItem(name) {
    return FortuneItem(
      child: Card(
        child: Column(
          children: [
            Image.asset(
              'assets/food/$name.jpg',
              width: 300,
              height: 150,
            ),
            Text(name),
            buildstars(5),
            Text('Restaurant Category'),
            SizedBox(height: 10),
            ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.open_in_full),
                    SizedBox(width: 8),
                    Text('Details'),
                  ],
                ),
                onPressed: () {}),
            ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.directions),
                    SizedBox(width: 8),
                    Text('Direction'),
                  ],
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Row buildstars(int starsnum) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < starsnum) {
        stars.add(Icon(Icons.star));
      } else {
        stars.add(Icon(Icons.star_border));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  void spinAgain() {
    final random = (List<int>.generate(5, (index) => index)..shuffle()).first;
    controller.add(random);
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
      height: ResponsiveSize.spinDialogHeight(context),
      styleStrategy: const UniformStyleStrategy(
        borderColor: Colors.transparent,
        //borderWidth: 10,
      ),
      selected: controller.stream,
      visibleItemCount: 1,
      items: [
        foodItem('dimsum'),
        foodItem('greekstyle'),
        foodItem('pasta'),
        foodItem('steak'),
        foodItem('sushi'),
      ],
      indicators: <FortuneIndicator>[
        FortuneIndicator(
          alignment: Alignment.topCenter,
          child: RectangleIndicator(
            color: Colors.transparent,
            borderColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
