import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddressAutoCompletion {
  String googApikey = dotenv.env['googApikey']!;
  LocationProvider locationProvider = LocationProvider();
  FilterProvider filterProvider = FilterProvider();

  Future<List<Map<String, dynamic>>> getPlacesAutocomplete({
    required String input,
  }) async {
    await locationProvider.getCurrentLocation();
    LatLng location = locationProvider.currentLocation!;
    double lat = location.latitude;
    double lng = location.longitude;
    double? radius = filterProvider.apiRadius;

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googApikey
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:autocomplete'));
    request.body = json.encode({
      "input": input,
      "locationBias": {
        "circle": {
          "center": {"latitude": lat, "longitude": lng},
          "radius": radius,
        }
      }
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> predictionNames = json.decode(responseBody);

      List<Map<String, dynamic>> suggestions = [];
      for (var suggestion in predictionNames['suggestions'] ?? []) {
        var placePrediction = suggestion['placePrediction'];
        if (placePrediction != null) {
          String name = '';
          String? placeId = placePrediction['placeId'];

          if (placePrediction['structuredFormat'] != null) {
            var mainText = placePrediction['structuredFormat']['mainText']['text'];
            var secondaryText = placePrediction['structuredFormat']['secondaryText']['text'];
            name = '$mainText, $secondaryText'.trim();
          } else {
            name = placePrediction['text']['text'] ?? '';
          }

          suggestions.add({
            'placeId': placeId,
            'name': name,
          });
        }
      }

      print('Final suggestions: $suggestions');
      return suggestions;
    } else {
      print(
          'Failed to load autocomplete suggestions: ${response.reasonPhrase}');
      throw Exception('Failed to load autocomplete suggestions');
    }
  }
}