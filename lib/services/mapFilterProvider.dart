import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  String? apiPriceLevel;
  double apiRadius = 3000; // in meters
  double? apiRating;
  List<String> apiRestaurantType = ['restaurant'];


  void updateRating(double newRating) {
    apiRating = newRating; // km to meters
    notifyListeners();
  }

  void updateRadius(double newRadius) {
    apiRadius = newRadius*1000; // km to meters
    notifyListeners();
  }

  void updateRestaurantType(List<String>? newList) {
    apiRestaurantType = newList?? ['restaurant'];
    notifyListeners();
  }


  void updatePriceRange(int? newPriceRange) {
    Map<int, String> priceLevelMap = {
      0: 'PRICE_LEVEL_FREE',
      1: 'PRICE_LEVEL_INEXPENSIVE',
      2: 'PRICE_LEVEL_MODERATE',
      3: 'PRICE_LEVEL_EXPENSIVE',
      4: 'PRICE_LEVEL_VERY_EXPENSIVE',
    };
    apiPriceLevel = priceLevelMap[newPriceRange];
    notifyListeners();
  }


  void resetFilters() {
    apiRadius = 3000;
    apiPriceLevel = null;
    apiRestaurantType = ['restaurant'];
    notifyListeners();
  }
}
