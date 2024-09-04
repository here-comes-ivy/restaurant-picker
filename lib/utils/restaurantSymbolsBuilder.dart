import 'package:flutter/material.dart';


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


String buildPriceLevel(String priceLevel) {
  String dollarSigns = '';

  Map<int, String> priceLevelMap = {
    0: 'PRICE_LEVEL_FREE',
    1: 'PRICE_LEVEL_INEXPENSIVE',
    2: 'PRICE_LEVEL_MODERATE',
    3: 'PRICE_LEVEL_EXPENSIVE',
    4: 'PRICE_LEVEL_VERY_EXPENSIVE',
  };

  var reversed = priceLevelMap.map((k, v) => MapEntry(v, k));

  int? priceLevelInNum = reversed[priceLevel];

  if (priceLevelInNum != null) {
    for (int i = 0; i < priceLevelInNum; i++) {
      dollarSigns += ('\$');
    }
  } else {
    dollarSigns = ('N/A');
  }

  return dollarSigns.toString();
}
