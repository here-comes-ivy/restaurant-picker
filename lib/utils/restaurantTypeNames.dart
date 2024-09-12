

List<Map<String, String>> restaurantTypeConversion = [
  {'displayName': 'American', 'apiName': 'american_restaurant'},
  {'displayName': 'Bakery', 'apiName': 'bakery'},
  {'displayName': 'Bar', 'apiName': 'bar'},
  {'displayName': 'Barbecue', 'apiName': 'barbecue_restaurant'},
  {'displayName': 'Breakfast', 'apiName': 'breakfast_restaurant'},
  {'displayName': 'Brunch', 'apiName': 'brunch_restaurant'},
  {'displayName': 'Cafe', 'apiName': 'cafe'},
  {'displayName': 'Chinese', 'apiName': 'chinese_restaurant'},
  {'displayName': 'Coffee Shop', 'apiName': 'coffee_shop'},
  {'displayName': 'Fast Food', 'apiName': 'fast_food_restaurant'},
  {'displayName': 'French', 'apiName': 'french_restaurant'},
  {'displayName': 'Hamburger', 'apiName': 'hamburger_restaurant'},
  {'displayName': 'Ice Cream', 'apiName': 'ice_cream_shop'},
  {'displayName': 'Indian', 'apiName': 'indian_restaurant'},
  {'displayName': 'Italian', 'apiName': 'italian_restaurant'},
  {'displayName': 'Japanese', 'apiName': 'japanese_restaurant'},
  {'displayName': 'Korean', 'apiName': 'korean_restaurant'},
  {'displayName': 'Mediterranean', 'apiName': 'mediterranean_restaurant'},
  {'displayName': 'Mexican', 'apiName': 'mexican_restaurant'},
  {'displayName': 'Middle Eastern', 'apiName': 'middle_eastern_restaurant'},
  {'displayName': 'Pizza', 'apiName': 'pizza_restaurant'},
  {'displayName': 'Ramen', 'apiName': 'ramen_restaurant'},
  {'displayName': 'Spanish', 'apiName': 'spanish_restaurant'},
  {'displayName': 'Sushi', 'apiName': 'sushi_restaurant'},
  {'displayName': 'Thai', 'apiName': 'thai_restaurant'},
  {'displayName': 'Vegan', 'apiName': 'vegan_restaurant'},
  {'displayName': 'Vegetarian', 'apiName': 'vegetarian_restaurant'},

];


String? convertToAPIName(String restaurant) {
    var match = restaurantTypeConversion.firstWhere(
      (element) => element['displayName'] == restaurant,
      orElse: () => <String, String>{}, 
    );
    return match != null ? match['apiName'] : 'restaurant';
  }
