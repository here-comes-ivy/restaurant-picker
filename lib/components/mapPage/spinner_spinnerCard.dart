import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'spinner_favoriteFAB.dart';

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

FortuneItem buildRestaurantData(Map<String, dynamic> restaurant) {
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
                  restaurant['name'] ?? 'Unknown Restaurant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(restaurant['rating'].toString()),
                    SizedBox(width: 8),
                    buildStars(restaurant['rating'] ?? 3.0),
                    Text(' (${restaurant['ratingCount'].toString()})'),
                  ],
                ),
                Text(restaurant['address']),
                Text(restaurant['priceLevel']),
                Expanded(
                  child: Image.network(
                      'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=至ㄚ&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                      //restaurant['photo'],
                      ),
                ),
                ActionChip(
                  avatar: Icon(Icons.open_in_full),
                  label: Text('Details'),
                  onPressed: () {},
                ),
                ActionChip(
                  avatar: Icon(Icons.directions),
                  label: Text('Direction'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: FavoriteFAB(),
        ),
      ],
    ),
  );
}
