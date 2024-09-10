import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';
//import 'spinner_FavoriteButton.dart';
import 'temp_fab.dart';


FortuneItem buildRestaurantData(Map<String, dynamic> restaurant) {
  String restaurantID = restaurant['id'];
  String restaurantName = restaurant['name'] ?? 'Unknown Restaurant';
  double restaurantRating = restaurant['rating'];
  int restaurantRatingCount = restaurant['ratingCount'];

  String restaurantAddress = restaurant['address'] ?? 'Unknown Address';
  String restaurantPriceLevel = buildPriceLevel(restaurant['priceLevel'] ?? 'Unknown Price Level');

  String displayRating = restaurant['rating'].toString();
  String displayRatingCount = restaurant['ratingCount'].toString();

  return FortuneItem(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        TextStyle kSpinnerCardTextStyle = TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.045,
                        color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                      );

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              //restaurant['photo'],
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white.withOpacity(0.8),
                padding: EdgeInsets.all(width * 0.04), 
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: kSpinnerCardTextStyle,
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Text(displayRating, style: kSpinnerCardTextStyle,),
                        SizedBox(width: width * 0.02),
                        buildStars(restaurant['rating'] ?? 0.0),
                        Text(' ($displayRatingCount)', style: kSpinnerCardTextStyle,),
                        SizedBox(width: width * 0.02),
                        Text(restaurantPriceLevel, style: kSpinnerCardTextStyle,),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text(restaurantAddress, style: kSpinnerCardTextStyle,),
                    SizedBox(height: height * 0.01),
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


