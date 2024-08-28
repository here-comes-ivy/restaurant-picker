import 'networking.dart';
import 'locationDataProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const apiKey = "AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s"; 
const googlePlaceUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

const googlePlaceDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json";


class RestaurantModel {
  LocationDataProvider locationProvider = LocationDataProvider();


  Future<dynamic> getNearbyRestaurantData(String cityName) async{
    await locationProvider.getLocation();
    LatLng location = locationProvider.currentLocation!;
    var url = Uri.parse("$googlePlaceUrl?location=$location&radius=1000&type=restaurant&language=zh-TW&key=123456");
    NetworkHelper networkHelper = NetworkHelper(url);
    var restaurantData = await networkHelper.getRestaurantData();
    return restaurantData;
  }

// WIP
  Future<dynamic> getFilteredRestaurantData() async{
    await locationProvider.getLocation();
    var url = Uri.parse("$googlePlaceUrl?location=25.0338,121.5646&radius=1000&keyword=牛排&language=zh-TW&key=$apiKey");

    NetworkHelper networkHelper = NetworkHelper(url);
    var restaurantData = await networkHelper.getRestaurantData();
    return restaurantData;
  }

  Future<dynamic> getRestaurantDetailsData() async{    
    var place_id;
    var url = Uri.parse("$googlePlaceDetailsUrl?place_id=$place_id&language=zh-TW&key=$apiKey");
    NetworkHelper networkHelper = NetworkHelper(url);
    var restaurantData = await networkHelper.getRestaurantData();
    return restaurantData;
  }




}