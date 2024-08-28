import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../../services/getNearbyRestaurants.dart';
import 'favoriteFAB.dart';


final placesService = NearbyRestaurantData();

late Future<List<Map<String, dynamic>>> nearbyRestaurantsFuture = placesService.fetchData();


FortuneItem restaurantData(Map<String, dynamic> restaurant) {
  return FortuneItem(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
      Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  buildStars(restaurant['rating']?? 3.0),
                  Text(' (${restaurant['ratingCount'].toString()})')
                ],
              ),
              Text(restaurant['address']),
          
              Expanded(
                child: Image.network(
                  restaurant['photo'],),
              ),
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
      ),
      Positioned(
            top: 8.0,
            right: 8.0,
            child: FavoriteFAB(),),
      ]
    ),
  );
}
  

Row buildStars(double rating) {
  List<Widget> stars = [];
  for (int i = 0; i < 5; i++) {
    if (rating.floor() > i) {
      stars.add(Icon(Icons.star));
    } else if (rating.floor() - i >= 0.5) {
      stars.add(Icon(Icons.star_half));
    } else {
      stars.add(Icon(Icons.star_border));
    }
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: stars,
  );
}

