import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';


class MapWidget extends StatefulWidget {

  final LatLng? searchedLocation;
  
  const MapWidget({
    super.key,

    this.searchedLocation,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  LatLng? mapCenter;
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeMapData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: mapCenter!,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            circles: circles,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _initializeMapData() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    mapCenter = locationProvider.currentLocation;
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    addCircle(mapCenter!, filterProvider.apiRadius ?? 1000);
    if (widget.searchedLocation != null) {
      addMarker();
    }
  }

  void addMarker() {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context, listen: false);
    LatLng position = locationProvider.searchedLocation!;
    Marker marker = Marker(
      markerId: const MarkerId("searchedLocation"),
      position: position,
    );

    setState(() {
      markers.clear();
      markers.add(marker);
      _mapController.animateCamera(CameraUpdate.newLatLng(position));
    });
  }
  
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void addCircle(LatLng position, double radius) {
    Circle circle = Circle(
      circleId: const CircleId("myCircle"),
      center: position,
      radius: radius,
      fillColor: Colors.blue.withOpacity(0.1),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );

    setState(() {
      circles.clear();  
      circles.add(circle); 
    });
  }
}