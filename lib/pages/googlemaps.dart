import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(25.04423044419125, 121.41970072259883), // 職訓局座標
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        // Perform any additional setup if needed
      },
    );
  }
}