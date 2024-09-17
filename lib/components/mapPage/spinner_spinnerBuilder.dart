import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'dart:math';
import 'spinner_spinnerCard.dart';
import 'package:flutter/foundation.dart';

class SpinnerBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String emptyMessage;

  const SpinnerBuilder({
    super.key,
    required this.data,
    this.emptyMessage = 'No restaurants found.',
  });

  @override
  SpinnerBuilderState createState() => SpinnerBuilderState();
}

class SpinnerBuilderState extends State<SpinnerBuilder> {
  late StreamController<int> controller;
  List<Map<String, dynamic>> allRestaurants = [];
  List<Map<String, dynamic>> displayedRestaurants = [];
  int spinCount = 0;
  final int maxSpinBeforeRefresh = 15;
  int? lastSelectedIndex;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();
    allRestaurants = widget.data;
    _selectRandomRestaurants();
  }

  @override
  void dispose() {
     _disposed = true;
    controller.close();
    super.dispose();
    
  }

static List<Map<String, dynamic>> _getRandomRestaurants(List<Map<String, dynamic>> allRestaurants) {
  final shuffled = List<Map<String, dynamic>>.from(allRestaurants)..shuffle();
  return shuffled.take(5).toList();
}

Future<void> _selectRandomRestaurants() async {
  if (allRestaurants.length <= 5) {
    displayedRestaurants = List.from(allRestaurants);
  } else {
    displayedRestaurants = await compute(_getRandomRestaurants, allRestaurants);
  }
  if (!_disposed) { 
      setState(() {});
    }
}


  void spinAgain() {
    spinCount++;
    if (spinCount >= maxSpinBeforeRefresh) {
      spinCount = 0;
      _selectRandomRestaurants();
    } else {
      displayedRestaurants.shuffle();
    }

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
    if (allRestaurants.isEmpty) {
      return Text(widget.emptyMessage);
    }

    List<FortuneItem> fortuneItems = displayedRestaurants
        .map((restaurant) =>
            RestaurantFortuneItemBuilder.buildFortuneItem(restaurant, context))
        .toList();

    return Column(
      children: [
        FortuneBar(
          height: MediaQuery.of(context).size.height * 0.3,
          styleStrategy: UniformStyleStrategy(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          ),
          selected: controller.stream,
          visibleItemCount: 1,
          items: fortuneItems,
          indicators: const <FortuneIndicator>[
            FortuneIndicator(
              alignment: Alignment.topCenter,
              child: RectangleIndicator(
                color: Colors.transparent,
                borderColor: Colors.transparent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: spinAgain,
          child: const Text(
            'Spin Again',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
