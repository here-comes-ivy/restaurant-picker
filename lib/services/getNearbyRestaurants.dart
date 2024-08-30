import 'package:http/http.dart' as http;
import 'dart:convert';
import 'networking.dart';
import 'locationDataProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyRestaurantData {

  LocationDataProvider locationProvider = LocationDataProvider();
  String googApikey = 'AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s';

  static final NearbyRestaurantData _instance = NearbyRestaurantData._internal();
  factory NearbyRestaurantData() {
    return _instance;
  }

  NearbyRestaurantData._internal();

  Future<List<Map<String, dynamic>>> fetchData() async {

    await locationProvider.getLocation();
    LatLng location = locationProvider.currentLocation!;
    double lat = location.latitude;
    double lng = location.longitude;

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googApikey,
      'X-Goog-FieldMask':
          'places.id,places.displayName,places.rating,places.userRatingCount,places.shortFormattedAddress,places.photos'
      //可能會用到的欄位: 
      //Advanced Filter: places.priceLevel,places.types,places.regularOpeningHours,places.businessStatus,

      //Preference filter (boolean): places.delivery,places.allowsDogs,places.servesVegetarianFood,places.reservable,places.goodForGroups

      //Direction? places.googleMapsUri
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["restaurant"],
      "maxResultCount": 5,
      "locationRestriction": {
        "circle": {
          "center": {
        "latitude": lat,
        "longitude": lng},
          "radius": 1000
        }
      }
    });
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

          // [WIP] Photo URL for the restaurant
          // String getPhotoUrl(dynamic place, {int maxWidth = 400, int maxHeight = 400}) {
          //   if (place['photos'].isNotEmpty) {
          //     String photoName = place['photos'][0]['name'] as String? ?? '';
          //     if (photoName.isNotEmpty) {
          //       return 'https://places.googleapis.com/v1/$photoName/media?key=googApikey&maxHeightPx=$maxHeight&maxWidthPx=$maxWidth';
          //     }
          //   }
          //   return ''; // 返回空字符串或者默认图片 URL
          // }

          return {
            'id': place['id'] as String? ?? '',
            'name': place['displayName']?['text'] as String? ?? 'No Name',
            'address':
                place['shortFormattedAddress'] as String? ?? 'No Address',
            'rating': (place['rating'] as num?)?.toDouble() ?? 0.0,
            'ratingCount': place['userRatingCount'] as int? ?? 0,
            'photo': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            //'photo': getPhotoUrl(place),

            // 'types': (place['types'] as List<dynamic>?)?.cast<String>() ?? [],
            // 'priceLevel': place['priceLevel'] as String? ?? 'N/A',
            // 'openingHours': place['regularOpeningHours'] as Map<String, dynamic>? ?? {},
            // 'businessStatus': place['businessStatus'] as String? ?? 'N/A',
            // 'googleMapsUri': place['googleMapsUri'] as String? ?? '',
          };
        }).toList();
      } else {
        print('Error: API request error: ${response.statusCode}');
        print('Error message: $responseBody');
        throw Exception('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurs when fetchDataing: $e');
      rethrow;
    }
  }
}
