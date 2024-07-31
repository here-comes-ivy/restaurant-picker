import 'networking.dart';
import 'location.dart';

const apiKey = "bdd09d8df00923f5d51b0e0d5e7af3d7"; 
const googlePlaceUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";


class WeatherModel {
  Future<dynamic> getNearbyRestaurantData(String cityName) async{

    var location = LocationData().getLocation();

    var url = Uri.parse("$googlePlaceUrl?location=$location&radius=1000&type=restaurant&language=zh-TW&key=123456");
    NetworkHelper networkHelper = NetworkHelper(url);
    var restaurantData = await networkHelper.getRestaurantData();
    return restaurantData;
  }

// WIP
  Future<dynamic> getFilteredRestaurantData() async{
    LocationData location = LocationData();
    await location.getLocation();
    
    var url = Uri.parse("$googlePlaceUrl?location=25.0338,121.5646&radius=1000&keyword=牛排&language=zh-TW&key=$apiKey");

    NetworkHelper networkHelper = NetworkHelper(url);
    var restaurantData = await networkHelper.getRestaurantData();
    return restaurantData;
  }

}