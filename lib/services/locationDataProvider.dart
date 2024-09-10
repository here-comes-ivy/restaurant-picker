import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
}