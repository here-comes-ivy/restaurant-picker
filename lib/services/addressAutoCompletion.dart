import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetails {
  final LatLng location;
  final String name;

  PlaceDetails({required this.location, required this.name});
}

class AddressAutoCompletion {
  final String googApikey = dotenv.env['googApikey']!;

  Future<List<Map<String, String>>> getPlacesAutocomplete({
    required String input,
  }) async {
    var url = Uri.parse('https://places.googleapis.com/v1/places:autocomplete');
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': googApikey,
      'X-Goog-FieldMask': 'suggestions.placePrediction.description,suggestions.placePrediction.placeId,suggestions.placePrediction.structuredFormat'
    };

    var body = json.encode({
      "textQuery": input,
      "languageCode": "zh-TW",
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> suggestions = jsonResponse['suggestions'];
      return suggestions.map<Map<String, String>>((suggestion) {
        var placePrediction = suggestion['placePrediction'];
        return {
          'description': '${placePrediction['structuredFormat']['mainText']['text']}, ${placePrediction['structuredFormat']['secondaryText']['text']}',
          'placeId': placePrediction['placeId'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<PlaceDetails> getPlaceDetails(String placeId) async {
    var url = Uri.parse('https://places.googleapis.com/v1/places/$placeId?fields=location,displayName');
    var response = await http.get(url, headers: {
      'X-Goog-Api-Key': googApikey,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var location = data['location'];
      var name = data['displayName']['text'];
      return PlaceDetails(
        location: LatLng(location['latitude'], location['longitude']),
        name: name,
      );
    } else {
      throw Exception('Failed to get place details');
    }
  }
}
