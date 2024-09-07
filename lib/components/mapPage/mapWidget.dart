import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;

  const MapWidget({
    Key? key,
    required this.initialPosition,
  }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  Set<Circle> circles = Set<Circle>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void addCircle(LatLng position, double radius) async {
    Circle circle = Circle(
      circleId: CircleId("myCircle"),
      center: position,
      radius: radius,
      fillColor: Colors.blue.withOpacity(0.1),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
    
    setState(() {
      circles.add(circle);

    });

    if (_mapController != null) {
        LatLngBounds visibleRegion = await _mapController.getVisibleRegion();
              _mapController.animateCamera(CameraUpdate.newLatLngBounds(visibleRegion, 50));
      }
  }


  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    double apiRadius = filterProvider.apiRadius;

    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        addCircle(widget.initialPosition, apiRadius);
      },
      circles: circles,
    );
  }
}
