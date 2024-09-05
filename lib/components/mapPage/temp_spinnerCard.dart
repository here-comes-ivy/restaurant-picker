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
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.network(
              'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              //restaurant['photo'],
              fit: BoxFit.cover,
            ),
            // Semi-transparent white container with restaurant info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white.withOpacity(0.7),
                padding: EdgeInsets.all(width * 0.04), // Responsive padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.045, // Responsive font size
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Text(restaurantRating),
                        SizedBox(width: width * 0.02),
                        buildStars(restaurant['rating'] ?? 0.0),
                        Text(' ($restaurantRatingCount)'),
                        SizedBox(width: width * 0.02),
                        Text(restaurantPriceLevel),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text(restaurantAddress),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                  ],
                ),
              ),
            ),
            // Favorite FAB
            Positioned(
              top: height * 0.02,
              right: width * 0.02,
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
        );
      },
    ),
  );
}
