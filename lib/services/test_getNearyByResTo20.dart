import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyRestaurantData {
  LocationDataProvider locationProvider = LocationDataProvider();
  FilterProvider filterProvider = FilterProvider();

  String googApikey = 'YOUR_API_KEY';

  static final NearbyRestaurantData _instance = NearbyRestaurantData._internal();
  factory NearbyRestaurantData() {
    return _instance;
  }

  NearbyRestaurantData._internal();

  Future<List<Map<String, dynamic>>> fetchFilteredData({
    int desiredCount = 20,
    double minRating = 0,
    String? priceLevel,
  }) async {
    List<Map<String, dynamic>> filteredResults = [];
    int offset = 0;
    int maxAttempts = 5; // Limit the number of API calls to avoid infinite loop

    while (filteredResults.length < desiredCount && maxAttempts > 0) {
      List<Map<String, dynamic>> batch = await fetchData(offset: offset);
      
      if (batch.isEmpty) {
        break; // No more results available
      }

      for (var place in batch) {
        if (place['rating'] >= minRating &&
            (priceLevel == null || place['priceLevel'] == priceLevel)) {
          filteredResults.add(place);
          if (filteredResults.length == desiredCount) {
            break;
          }
        }
      }

      offset += batch.length;
      maxAttempts--;
    }

    return filteredResults;
  }

  Future<List<Map<String, dynamic>>> fetchData({int offset = 0}) async {
    await locationProvider.getLocation();
    LatLng location = locationProvider.currentLocation!;
    double lat = location.latitude;
    double lng = location.longitude;
    double? radius = filterProvider.apiRadius;

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googApikey,
      'X-Goog-FieldMask':
          'places.id,places.displayName,places.rating,places.userRatingCount,places.shortFormattedAddress,places.photos,places.priceLevel'
    };

    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));

    var requestBody = {
      "includedTypes": ["restaurant"],
      "maxResultCount": 20,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": lat, "longitude": lng},
          "radius": radius
        }
      },
      "rankPreference": "DISTANCE",
      "pageOffset": offset,
    };

    request.body = json.encode(requestBody);
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final restaurantData = jsonDecode(responseBody);

        if (restaurantData['places'] == null ||
            !(restaurantData['places'] is List)) {
          print('API response does not contain expected "places" list');
          return [];
        }

        return (restaurantData['places'] as List<dynamic>)
            .map<Map<String, dynamic>>((place) {
          return {
            'id': place['id'] as String? ?? '',
            'name': place['displayName']?['text'] as String? ?? 'No Name',
            'address':
                place['shortFormattedAddress'] as String? ?? 'No Address',
            'rating': (place['rating'] as num?)?.toDouble() ?? 0.0,
            'ratingCount': place['userRatingCount'] as int? ?? 0,
            'photo': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            'priceLevel': place['priceLevel'] as String? ?? 'N/A',
          };
        }).toList();
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
