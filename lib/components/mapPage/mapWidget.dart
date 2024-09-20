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
  GoogleMapController? _mapController;
  LatLng? mapCenter;
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMapData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeMapData();
  }

  Future<void> _initializeMapData() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    LatLng center = locationProvider.getSearchLocation();
    double radius = filterProvider.apiRadius ?? 1000;

    if (mounted) {
      setState(() {
        mapCenter = center;
        circles.clear();
        circles.add(Circle(
          circleId: const CircleId("myCircle"),
          center: center,
          radius: radius,
          fillColor: Colors.blue.withOpacity(0.1),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
        _updateMarker();
      });
    }

    if (_mapController != null) {
      _updateMapPosition();
    }
  }

  void _updateMarker() {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context, listen: false);
    LatLng position = locationProvider.getSearchLocation();
    
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("searchedLocation"),
      position: position,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        if (mapCenter == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: mapCenter!,
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {
            setState(() {
            _mapController = controller;
          });
            _updateMapPosition();
          },
          circles: circles,
          markers: markers,
        );
      },
    );
  }

void _updateMapPosition() {
  if (_mapController == null) return;
  
  LocationProvider locationProvider = Provider.of<LocationProvider>(context, listen: false);
  LatLng position = locationProvider.getSearchLocation();
  _mapController!.animateCamera(CameraUpdate.newLatLng(position));
  print('Updating map position to: ${position.latitude}, ${position.longitude}');

}
  
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}