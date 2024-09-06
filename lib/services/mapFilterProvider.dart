import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  int? userSelectedPriceLevel;
  String? apiPriceLevel;

  double? userSelectedRadius;
  double? apiRadius = 3000.0;

  List? userSelectedRestaurantType;
  List? apiRestaurantType = ['restaurant'];



  void updatePriceRange(int? newPriceRange) {
    Map<int, String> priceLevelMap = {
      0: 'PRICE_LEVEL_FREE',
      1: 'PRICE_LEVEL_INEXPENSIVE',
      2: 'PRICE_LEVEL_MODERATE',
      3: 'PRICE_LEVEL_EXPENSIVE',
      4: 'PRICE_LEVEL_VERY_EXPENSIVE',
    };
    userSelectedPriceLevel = newPriceRange;
    apiPriceLevel = priceLevelMap[userSelectedPriceLevel];
    notifyListeners();
  }

  void updateRadius(double newRadius) {
    userSelectedRadius = newRadius*1000; // km to meters
    apiRadius = userSelectedRadius?? 3000.0;
    notifyListeners();
  }

  void updateRestaurantType(List newList) {
    userSelectedRestaurantType = newList; 
    apiRestaurantType = userSelectedRestaurantType?? ['restaurant'];
    notifyListeners();
  }

  void resetFilters() {
    userSelectedRadius = 3.0;
    userSelectedPriceLevel = null;
    userSelectedPriceLevel = null;
    notifyListeners();
  }
}
