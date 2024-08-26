import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../services/getNearbyRestaurants.dart';

final placesService = PlaceService();

late Future<List<Map<String, dynamic>>> nearbyRestaurantsFuture = placesService.fetchData();


FortuneItem restaurantData(Map<String, dynamic> restaurant) {
  return FortuneItem(
    child: Card(
      child: Column( 
        children: [

          Text(
            restaurant['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
          Row(
            children: [
              Text(restaurant['rating'].toString()),
              SizedBox(width: 8),
              buildstars(restaurant['rating']?.round() ?? 3),
            ],
          ),
          Text(restaurant['address']),

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

Future<List<FortuneItem>> convertToFortuneItems(Future<List<Map<String, dynamic>>> futureData) async {
  final List<Map<String, dynamic>> data = await futureData;
  return data.map((item) => restaurantData(item)).toList();
}