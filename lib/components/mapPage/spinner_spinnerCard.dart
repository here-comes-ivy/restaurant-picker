import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'spinner_favoriteFAB.dart';
import 'package:restaurant_picker/utils/restaurantSymbolsBuilder.dart';



FortuneItem buildRestaurantData(Map<String, dynamic> restaurant) {
  String restaurantID = restaurant['id'];
  String restaurantName = restaurant['name'] ?? 'Unknown Restaurant';
  String restaurantRating = restaurant['rating'].toString();
  String restaurantRatingCount = restaurant['ratingCount'].toString();
  String restaurantAddress = restaurant['address'] ?? 'Unknown Address';
  String restaurantPriceLevel = buildPriceLevel(restaurant['priceLevel'] ?? 'Unknown Price Level');
      

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
                  restaurantName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(restaurantRating),
                    SizedBox(width: 8),
                    buildStars(restaurant['rating'] ?? 0.0),
                    Text(' ($restaurantRatingCount)'),
                    SizedBox(width: 8),
                    Text(restaurantPriceLevel),
                  ],
                ),
                Text(restaurantAddress),

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
          child: FavoriteFAB(
            restaurantID: restaurantID,
            restaurantName: restaurantName,
            restaurantRating: restaurantRating,
            restaurantRatingCount: restaurantRatingCount,
            restaurantAddress: restaurantAddress,
            restaurantPriceLevel: restaurantPriceLevel,
          ),
        ),
      ],
    ),
  );
}
