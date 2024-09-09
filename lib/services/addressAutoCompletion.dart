import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceAutoComplete {
  Future<List<String>> getPlacesAutocomplete(String input,
      {double? latitude, double? longitude, double? radius}) async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s'
    };

    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:autocomplete'));
    request.body = json.encode({
      "input": input,
      "locationBias": {
        "circle": {
          "center": {"latitude": latitude, "longitude": longitude},
          "radius": radius
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      List<dynamic> predictions = jsonResponse['predictions'];
      return predictions
          .map((prediction) => prediction['description'] as String)
          .toList();
    } else {
      throw Exception(
          'Failed to load autocomplete suggestions: ${response.reasonPhrase}');
    }
  }
}
