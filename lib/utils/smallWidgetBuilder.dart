import 'package:flutter/material.dart';

Row buildStars(double rating) {
  List<Widget> stars = [];
  Color? starColor = Colors.amber[600];
  for (int i = 0; i < 5; i++) {
    if (rating.floor() > i) {
      stars.add(Icon(Icons.star, color: starColor));
    } else if (rating.floor() - i >= 0.5) {
      stars.add(Icon(Icons.star_half, color: starColor));
    } else {
      stars.add(Icon(Icons.star_border, color: starColor));
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
    dollarSigns = ('');
  }

  return dollarSigns.toString();
}



class BottomSheetHandler extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
  height: 4,
  width: 40,
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(2),
  ),
);
  }
}
