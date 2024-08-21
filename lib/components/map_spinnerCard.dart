import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../services/getNearbyRestaurants.dart';



final placesService = PlaceService();
late Future<List<Map<String, dynamic>>> nearbyRestaurantsFuture = placesService.getNearbyRestaurants();

FortuneItem restaurantData() {
    return FortuneItem(
      child: Card(
        child: Column(
          children: [
            Text('name'),
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
              onPressed: () {}
            ),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.directions),
                  SizedBox(width: 8),
                  Text('Direction'),
                ],
              ),
              onPressed: () {}
            ),
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

