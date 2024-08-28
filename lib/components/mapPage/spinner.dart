import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// https://pub.dev/packages/flutter_fortune_wheel/example
import '/utils/responsiveSize.dart';
import 'spinnerCard.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  SpinnerState createState() => SpinnerState();
}

class SpinnerState extends State<Spinner> {
  StreamController<int> controller = StreamController<int>();

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void spinAgain() {
    final random = Random().nextInt(5);
    controller.add(random);
  }

  Future<List<FortuneItem>> FortuneItemList(
      Future<List<Map<String, dynamic>>> futureData) async {
    final List<Map<String, dynamic>> data = await futureData;
    return data.map((item) => restaurantData(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FortuneItem>>(
      future: FortuneItemList(nearbyRestaurantsFuture),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return FortuneBar(
            height: ResponsiveSize.spinDialogHeight(context),
            styleStrategy: const UniformStyleStrategy(
              borderColor: Colors.transparent,
            ),
            selected: controller.stream,
            visibleItemCount: 1,
            items: snapshot.data!,
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
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
