import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';
import 'temp_fab.dart';

class RestaurantFortuneItemBuilder {
  static FortuneItem buildFortuneItem(
    Map<String, dynamic> restaurant,
    BuildContext context,
  ) {
    String restaurantID = restaurant['id'] ?? '';
    String restaurantName = restaurant['name'] ?? 'Unknown Restaurant';
    double restaurantRating = restaurant['rating'] ?? 0.0;
    int restaurantRatingCount = restaurant['ratingCount'] ?? 0;
    String restaurantAddress = restaurant['address'] ?? 'Unknown Address';
    String restaurantPriceLevel = buildPriceLevel(restaurant['priceLevel'] ?? 'Unknown Price Level');
    String photoUrl = restaurant['photo'] ?? '';

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
              if (photoUrl.isNotEmpty)
                Image.network(
                  photoUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    Container(color: Colors.grey),
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
                      Text(restaurantName, style: kSpinnerCardTextStyle),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          Text(restaurantRating.toString(), style: kSpinnerCardTextStyle),
                          SizedBox(width: width * 0.02),
                          buildStars(restaurantRating),
                          Text(' ($restaurantRatingCount)', style: kSpinnerCardTextStyle),
                          SizedBox(width: width * 0.02),
                          Text(restaurantPriceLevel, style: kSpinnerCardTextStyle),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Text(restaurantAddress, style: kSpinnerCardTextStyle),
                    ],
                  ),
                ),
              ),
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
                  photoUrl: photoUrl,

                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static List<FortuneItem> buildFortuneItems(
    List<Map<String, dynamic>> restaurants,
    BuildContext context,
  ) {
    return restaurants.map((restaurant) => buildFortuneItem(restaurant, context)).toList();
  }
}


