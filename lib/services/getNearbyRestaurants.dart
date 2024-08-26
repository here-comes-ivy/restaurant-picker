import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {

  static final PlaceService _instance = PlaceService._internal();
  factory PlaceService() {
    return _instance;
  }

  PlaceService._internal();

  Future<List<Map<String, dynamic>>> fetchData() async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s',
      'X-Goog-FieldMask': 'places.id,places.displayName,places.rating,places.shortFormattedAddress,'
      //可能會用到的欄位: places.priceLevel,places.types,places.rating,places.userRatingCount,places.regularOpeningHours,places.businessStatus,places.googleMapsUri,places.photos'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["restaurant"],
      "maxResultCount": 5,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": 25.03, "longitude": 121.56},
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
        
        if (restaurantData['places'] == null || !(restaurantData['places'] is List)) {
          print('API response does not contain expected "places" list');
          return [];
        }

        return (restaurantData['places'] as List<dynamic>).map<Map<String, dynamic>>((place) {
          return {
            'id': place['id'] as String? ?? '',
            'name': place['displayName']?['text'] as String? ?? 'No Name',
            'address': place['shortFormattedAddress'] as String? ?? 'No Address',
            'rating': (place['rating'] as num?)?.toDouble() ?? 0.0,
            'ratingCount': place['userRatingCount'] as int? ?? 0,
            'types': (place['types'] as List<dynamic>?)?.cast<String>() ?? [],
            'priceLevel': place['priceLevel'] as String? ?? 'N/A',
            'openingHours': place['regularOpeningHours'] as Map<String, dynamic>? ?? {},
            'businessStatus': place['businessStatus'] as String? ?? 'N/A',
            'googleMapsUri': place['googleMapsUri'] as String? ?? '',
            'photos': place['photos'] as List<dynamic>? ?? []
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

