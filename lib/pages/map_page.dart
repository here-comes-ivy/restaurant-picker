import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location.dart';
import '../utils/decorationStyles.dart';
import 'filter_page.dart';
import '../components/map_modalBottomSheet2.dart';
// https://pub.dev/packages/modal_bottom_sheet
import '../components/map_filterChips.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;

  LocationData location = LocationData();
  LatLng defaultLocation =
      LatLng(25.0340637447189, 121.56452691031619); // 預設為台北101

  Future<LatLng?> getLocationData() async {
    return await location.getLocation();
  }
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng?>(
      future: getLocationData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          LatLng mapCenter = snapshot.data ?? defaultLocation;
          return Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: mapCenter,
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: kSearchAddressInputDecoration,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage()));
                            },
                          ),
                          SizedBox(height: 5),
                          SearchFilterChips(),                         
                        ],
                      ),
                      ModalBottomSheetContent(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
