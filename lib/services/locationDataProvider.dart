import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationDataProvider extends ChangeNotifier {
  LatLng? _currentLocation;
  bool _isLoading = true;

  LatLng? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle this case
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low
      );
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      notifyListeners();
    } catch (e) { 
      _isLoading = false;
      print('Error getting location: $e');
      notifyListeners();
    }
  }
}