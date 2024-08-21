import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {

  static final PlaceService _instance = PlaceService._internal();
  factory PlaceService() {
    return _instance;
  }

  PlaceService._internal();

  Future<List<Map<String, dynamic>>> getNearbyRestaurants() async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s',
      'X-Goog-FieldMask': 'places.id, places.displayName, places.shortFormattedAddress, places.priceLevel, places.types, places.rating, places.userRatingCount, regularOpeningHours, businessStatus, places.googleMapsUri, places.photos'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["restaurant"],
      "maxResultCount": 5,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": 25.03, "longitude": 121.56},
          "radius": 500
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final restaurauntData = jsonDecode(responseBody);

      return (restaurauntData['places'] as List<dynamic>).map<Map<String, dynamic>>((place) {
        return {
          'id': place['placeId'] as String,
          'name': place['displayName']['text'] as String,
          'address': place['shortFormattedAddress'] as String,
          'rating': place['rating'] as double? ?? 0.0,
          'ratingCount': place['userRatingCount'] as int? ?? 0,
          'type': place['types'] as List<String>,
          'priceLevel': place['priceLevel'] as String? ?? 'N/A',
          'openingHours': place['openingHours'] as Map<String, dynamic>,
          'businessStatus': place['businessStatus'] as String? ?? 'N/A',
          'googleMapsUri': place['googleMapsUri'] as String? ?? '',
          'photos': place['photos'] as List<dynamic> 
        };
      }).toList();

    } else {
      throw Exception('Failed to generate response');
    }
  }

}

