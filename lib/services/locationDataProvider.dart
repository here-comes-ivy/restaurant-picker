import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider extends ChangeNotifier {
  bool isLoading = true;
  LatLng? currentLocation;
  LatLng? searchedLocation;


  LatLng getSearchLocation() {
    return searchedLocation ?? currentLocation ?? LatLng(25.0340637447189, 121.56452691031619);
  }

  void setSearchedLocation(LatLng? location) {
    searchedLocation = location;
    notifyListeners();
  }


  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading = false;
          notifyListeners();
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      currentLocation = LatLng(position.latitude, position.longitude);

      isLoading = false;
      print(
          'Searching current location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error getting location: $e');
      notifyListeners();
    }
  }

  Future<void> getLocationFromPlaceId(String placeId) async {
    final String apiKey = dotenv.env['googApikey']!;

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask': 'location'
    };

    var url = Uri.parse(
        'https://places.googleapis.com/v1/places/$placeId');

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        searchedLocation = LatLng(data['location']['latitude'], data['location']['longitude']);
        print('Seached Lat Lng changed to : $searchedLocation');
        notifyListeners();
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception(
            'Failed to load place details: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error getting place details: $e');
      rethrow;
    }
  }


}
