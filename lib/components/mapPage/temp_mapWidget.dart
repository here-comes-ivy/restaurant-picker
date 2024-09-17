import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;
  const MapWidget({
    super.key,
    required this.initialPosition,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _mapController;
  Set<Circle> circles = <Circle>{};
  LatLng? _currentPosition;
  late LatLng _lastCameraPosition;
  bool _isMapCreated = false;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
    _lastCameraPosition = widget.initialPosition;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onLocationChange() {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final newPosition = locationProvider.searchedLocation;
    if (newPosition != null && newPosition != _currentPosition) {
      setState(() {
        _currentPosition = newPosition;
      });
      _updateMapPosition();
    }
  }

  void _updateMapPosition() {
    if (_currentPosition != null && _mapController != null && _isMapCreated) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      _updateCircle(_currentPosition!);
    }
  }

  void _updateCircle(LatLng center) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    Circle circle = Circle(
      circleId: const CircleId("myCircle"),
      center: center,
      radius: filterProvider.apiRadius,
      fillColor: Colors.blue.withOpacity(0.1),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );
    setState(() {
      circles = {circle};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        _currentPosition = locationProvider.searchedLocation ?? widget.initialPosition;
        
        return GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _currentPosition!,
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            _isMapCreated = true;
            _updateCircle(_currentPosition!);
          },
          circles: circles,
          onCameraMove: (CameraPosition position) {
            _lastCameraPosition = position.target;
            _updateCircle(_lastCameraPosition);
          },
          onCameraIdle: () {
            if (_currentPosition != _lastCameraPosition) {
              _updateCircle(_currentPosition!);
            }
          },
        );
      },
    );
  }
}