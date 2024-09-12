import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NearbyRestaurantData {
  final String googApikey = dotenv.env['googApikey']!;

  static final NearbyRestaurantData _instance = NearbyRestaurantData._internal();
  factory NearbyRestaurantData() {
    return _instance;
  }

  NearbyRestaurantData._internal();

  Future<String> getPhotoUrl(dynamic place, {int maxWidth = 400, int maxHeight = 400}) async {
    if (place['photos'] != null && place['photos'].isNotEmpty) {
      String photoName = place['photos'][0]['name'] as String;
      if (photoName.isNotEmpty) {
        var url = Uri.parse('https://places.googleapis.com/v1/$photoName/media?maxHeightPx=$maxHeight&maxWidthPx=$maxWidth&key=$googApikey');
        var request = http.Request('GET', url);
        
        try {
          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            return url.toString(); 
          } else {
            print('Error fetching photo: ${response.reasonPhrase}');
          }
        } catch (e) {
          print('Exception when fetching photo: $e');
        }
      }
    }
    return 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  }

  Future<List<Map<String, dynamic>>> fetchData({
    required LatLng location,
    required double radius,
    required List<String> restaurantType,
  }) async {
    double lat = location.latitude;
    double lng = location.longitude;

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googApikey,
      'X-Goog-FieldMask': 'places.id,places.displayName,places.rating,places.userRatingCount,places.shortFormattedAddress,places.photos,places.priceLevel'
    };

    var request = http.Request('POST', Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));

    var requestBody = {
      "languageCode": 'zh-TW',
      "includedTypes": restaurantType,
      "maxResultCount": 20,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": lat, "longitude": lng},
          "radius": radius
        }
      }
    };

    request.body = json.encode(requestBody);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final restaurantData = jsonDecode(responseBody);

        if (restaurantData['places'] == null || !(restaurantData['places'] is List)) {
          print('API response does not contain expected "places" list');
          return [];
        }

        print('Fetching data with criteria: Radius: $radius, Restaurant type: $restaurantType');
        
        List<Map<String, dynamic>> results = [];
        for (var place in restaurantData['places']) {
          String photoUrl = await getPhotoUrl(place);
          results.add({
            'id': place['id'] as String? ?? '',
            'name': place['displayName']?['text'] as String? ?? 'No Name',
            'address': place['shortFormattedAddress'] as String? ?? 'No Address',
            'rating': (place['rating'] as num?)?.toDouble() ?? 0.0,
            'ratingCount': place['userRatingCount'] as int? ?? 0,
            'priceLevel': place['priceLevel'] as String? ?? 'N/A',
            'photo': photoUrl,
          });
        }
        print(results);
        return results;
      } else {
        print('Error: API request error: ${response.statusCode}');
        print('Error message: $responseBody');
        throw Exception('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurs when fetching data: $e');
      rethrow;
    }
  }
}