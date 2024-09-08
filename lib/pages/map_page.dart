import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/locationDataProvider.dart';
import '../utils/decorationStyles.dart';
// https://pub.dev/packages/modal_bottom_sheet
import '../components/mapPage/filter_FilterRow.dart';
import '../components/mapPage/spinner_spinbutton.dart';
//import '../components/mapPage/mapWidget.dart';
import '../components/mapPage/temp_mapWidget.dart';
import '../components/mapPage/filter_filterBottomSheet.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng defaultLocation =
      LatLng(25.0340637447189, 121.56452691031619); // 台北101

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        if (locationProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          LatLng mapCenter =
              locationProvider.currentLocation ?? defaultLocation;
          return Scaffold(
            body: Stack(
              children: [
                MapWidget(initialPosition: mapCenter),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.tune,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.8),
                            ),
                            onPressed: () {
                              FilterBottomSheet.show(context);
                            },
                          ),
                          hintText: 'Search on Map',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(child: SpinButton()),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
