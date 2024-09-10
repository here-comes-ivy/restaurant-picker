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
    addCircle(widget.initialPosition, Provider.of<FilterProvider>(context, listen: false).apiRadius??3000);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void addCircle(LatLng position, double radius) {
    Circle circle = Circle(
      circleId: CircleId("myCircle"),
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
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },

      circles: circles,  
    );
  }
}
