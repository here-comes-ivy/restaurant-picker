import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/locationDataProvider.dart';
import '../utils/decorationStyles.dart';
import '../components/mapPage/spinner_spinBottomSheet.dart';
// https://pub.dev/packages/modal_bottom_sheet
import '../components/mapPage/filter_FilterRow.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../components/mapPage/spinner_spinBottomSheet.dart';
import '../components/mapPage/filter_FilterRow.dart';
import '../components/mapPage/spinner_spinbutton.dart';



class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final LatLng defaultLocation =
      LatLng(25.0340637447189, 121.56452691031619); // 台北101

  void _onMapCreated(GoogleMapController controller) {
  _mapController = controller;
}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationDataProvider>().getLocation();
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationDataProvider>(
      builder: (context, locationProvider, child) {
        if (locationProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          LatLng mapCenter =
              locationProvider.currentLocation ?? defaultLocation;
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
                            },
                          ),
                          SizedBox(height: 5),
                          SearchFilterRow(),
                        ],
                      ),
                      SpinButton(),
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
