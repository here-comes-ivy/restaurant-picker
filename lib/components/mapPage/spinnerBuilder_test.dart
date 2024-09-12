import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'spinner_spinnerCard.dart';
import '../../services/getRestaurantData_test.dart';
import 'package:provider/provider.dart';
import '../../services/locationDataProvider.dart';
import '../../services/mapFilterProvider.dart';


class SpinnerBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteRestaurants;

  SpinnerBuilder({required this.favoriteRestaurants});

  @override
  SpinnerBuilderState createState() => SpinnerBuilderState();
}

class SpinnerBuilderState extends State<SpinnerBuilder> {
  late StreamController<int> controller;
  List<Map<String, dynamic>> displayedRestaurants = [];
  int? lastSelectedIndex;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();
    _selectRandomRestaurants();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void _selectRandomRestaurants() {
    displayedRestaurants = List.from(widget.favoriteRestaurants)..shuffle();
    lastSelectedIndex = null;
  }

  void spinAgain() {
    displayedRestaurants.shuffle();

    int newIndex;
    do {
      newIndex = Random().nextInt(displayedRestaurants.length);
    } while (newIndex == lastSelectedIndex && displayedRestaurants.length > 1);

    lastSelectedIndex = newIndex;
    controller.add(newIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteRestaurants.isEmpty) {
      return Text('No favorite restaurants available for spinning.');
    }

    List<FortuneItem> fortuneItems = displayedRestaurants
        .map((restaurant) => buildRestaurantData(restaurant))
        .toList();

    return Column(
      children: [
        FortuneBar(
          height: MediaQuery.of(context).size.height * 0.3,
          styleStrategy: UniformStyleStrategy(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.8),
          ),
          selected: controller.stream,
          visibleItemCount: 1,
          items: fortuneItems,
          indicators: <FortuneIndicator>[
            FortuneIndicator(
              alignment: Alignment.topCenter,
              child: RectangleIndicator(
                color: Colors.transparent,
                borderColor: Colors.transparent,
              ),
            ),
          ],
        ),
        FilledButton(
          child: Text(
            'Try Again',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          onPressed: spinAgain,
        ),
      ],
    );
  }
}
