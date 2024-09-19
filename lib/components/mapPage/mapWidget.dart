import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final LatLng? searchedLocation;
  
  const MapWidget({
    super.key,
    required this.initialPosition,
    this.searchedLocation,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  Set<Circle> circles = <Circle>{};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    addCircle(widget.initialPosition, Provider.of<FilterProvider>(context, listen: false).apiRadius??3000);
      if (widget.searchedLocation != null) {
      addMarker(widget.searchedLocation!);
    }
  }

  void addMarker(LatLng position) {
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

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
    
      circles: circles,  
    );
  }
}