import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


// autocompletion not working for manual input

class AddressAutoCompletion {
  String googApikey = dotenv.env['googApikey']!;
  LocationProvider locationProvider = LocationProvider();
  FilterProvider filterProvider = FilterProvider();

  Future<List<String>> getPlacesAutocomplete({
    required String input,
  }) async {
    String? input;

    await locationProvider.getLocation();
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
      "input": input?? "restaurant",
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
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      List<dynamic> suggestions = jsonResponse['suggestions'];
      return suggestions.map<String>((suggestion) {
        var placePrediction = suggestion['placePrediction'];
        return '${placePrediction['structuredFormat']['mainText']['text']}, ${placePrediction['structuredFormat']['secondaryText']['text']}';
      }).toList();
    } else {
      print(
          'Failed to load autocomplete suggestions: ${response.reasonPhrase}');
      throw Exception('Failed to load autocomplete suggestions');
    }
  }
}
