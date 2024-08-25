import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// https://pub.dev/packages/flutter_fortune_wheel/example
import '/utils/responsiveSize.dart';
import '../components/map_spinnerCard.dart';


class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  SpinnerState createState() => SpinnerState();
}

class SpinnerState extends State<Spinner> {
  late StreamController<int> controller;


  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();

  }

  void spinAgain() {
    final random = (List<int>.generate(5, (index) => index)..shuffle()).first;
    controller.add(random);
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FortuneItem>>(
      future: convertToFortuneItems(nearbyRestaurantsFuture),
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