import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class LocationData {
  LatLng? currentLocation; 
  bool isLoading = true;

  Future<LatLng?> getLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low
      );
      currentLocation = LatLng(position.latitude, position.longitude);
      isLoading = false;
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      return currentLocation;

    } catch (e) { 
      isLoading = false;
      print('Error getting location: $e');
    }

  }

}