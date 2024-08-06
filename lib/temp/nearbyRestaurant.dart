import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:math';


Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}


Future<List<dynamic>> getNearbyRestaurants(double lat, double lng) async {
  final String apiKey = '2w9tGtHwzHVfI2_U35EjXyuHbmQ=';
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  
  final response = await http.get(Uri.parse(
    '$baseUrl?location=$lat,$lng&radius=1500&type=restaurant&key=$apiKey'
  ));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load restaurants');
  }
}


class NearbyRestaurantsWidget extends StatefulWidget {
  @override
  _NearbyRestaurantsWidgetState createState() => _NearbyRestaurantsWidgetState();
}

class _NearbyRestaurantsWidgetState extends State<NearbyRestaurantsWidget> {
  List<dynamic> restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      final position = await _getCurrentLocation();
      final nearbyRestaurants = await getNearbyRestaurants(
        position.latitude,
        position.longitude
      );
      
      // 隨機選擇 10 家餐廳（如果結果少於 10 家，則使用所有結果）
      nearbyRestaurants.shuffle();
      setState(() {
        restaurants = nearbyRestaurants.take(10).toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return ListTile(
          title: Text(restaurant['name']),
          subtitle: Text(restaurant['vicinity']),
        );
      },
    );
  }
}
