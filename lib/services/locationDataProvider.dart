import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LocationProvider extends ChangeNotifier {
  LatLng? searchedLocation;
  bool isLoading = true;
  LatLng? currentLocation;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle this case
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low
      );
      currentLocation = LatLng(position.latitude, position.longitude);

      searchedLocation = currentLocation;

      isLoading = false;
      print('Searching current location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      notifyListeners();
    } catch (e) { 
      isLoading = false;
      print('Error getting location: $e');
      notifyListeners();
    }
  }

    Future<void> getLocationFromPlaceId(String placeId) async {
    final String apiKey = dotenv.env['googApikey']!;
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final location = data['result']['geometry']['location'];
        searchedLocation = LatLng(location['lat'], location['lng']);
        notifyListeners();
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      print('Error getting place details: $e');
    }
  }
}