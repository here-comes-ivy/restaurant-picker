import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'spinner_spinnerCard.dart';

import '../../services/googAPI_getNearbyRestaurants.dart';

class SpinnerBuilder extends StatefulWidget {
  @override
  SpinnerBuilderState createState() => SpinnerBuilderState();
}

class SpinnerBuilderState extends State<SpinnerBuilder> {
  late StreamController<int> controller;
  late Future<List<Map<String, dynamic>>> nearbyRestaurantsFuture;
  NearbyRestaurantData placesService = NearbyRestaurantData();
  List<Map<String, dynamic>> allRestaurants = [];
  List<Map<String, dynamic>> displayedRestaurants = [];
  int spinCount = 0;
  final int maxSpinBeforeRefresh = 15;
  int? lastSelectedIndex;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();
    _refreshData();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {
      nearbyRestaurantsFuture = placesService.fetchData();
    });
    allRestaurants = await nearbyRestaurantsFuture;
    _selectRandomRestaurants();
    spinCount = 0;
  }

  void _selectRandomRestaurants() {
    if (allRestaurants.length <= 5) {
      displayedRestaurants = List.from(allRestaurants);
    } else {
      displayedRestaurants = List.from(allRestaurants)..shuffle();
      displayedRestaurants = displayedRestaurants.take(5).toList();
    }
    lastSelectedIndex = null;
  }

  void spinAgain() {
    spinCount++;
    if (spinCount >= maxSpinBeforeRefresh) {
      _refreshData();
    } else {
      _selectRandomRestaurants();
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
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: nearbyRestaurantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && displayedRestaurants.isNotEmpty) {
          List<FortuneItem> fortuneItems = displayedRestaurants
              .map((restaurant) => buildRestaurantData(restaurant))
              .toList();

          return Column(
            children: [
              FortuneBar(
                height: MediaQuery.of(context).size.height * 0.3,
                styleStrategy: UniformStyleStrategy(                 
                  color:
                      Theme.of(context).colorScheme.surface.withOpacity(0.8),
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
                  ),
                ),
                onPressed: spinAgain,
              ),
            ],
          );
        } else {
          return Text('No data found');
        }
      },
    );
  }
}
