import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/locationDataProvider.dart';
import '../components/mapPage/spinner_spinbutton.dart';
import '../components/mapPage/mapWidget.dart';
import '../components/mapPage/filter_filterBottomSheet.dart';
import '../components/mapPage/addressTextField.dart';
import '../components/mapPage/filter_restaurantTypeRow.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_picker/services/getRestaurantData.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final NearbyRestaurantData nearbyRestaurantData = NearbyRestaurantData();

  bool isMapReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        print('Current location: ${locationProvider.currentLocation}');
        print('Current location: ${locationProvider.searchedLocation}');
        if (locationProvider.isLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {

          LatLng mapCenter = locationProvider.currentLocation!;
          late final Future<List<Map<String, dynamic>>> dataFuture =
        nearbyRestaurantData.fetchData(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          child: IconButton(
                            color: const Color.fromRGBO(255, 181, 160, 1),
                            icon: const Icon(Icons.tune),
                            onPressed: () => FilterBottomSheet.show(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: RestaurantTypeFilterRow()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Expanded(
                              child: MapWidget(
                                initialPosition: mapCenter,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              right: 20,
                              child: AddressAutoCompleteTextField(),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: SpinButton(dataFuture: dataFuture)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
