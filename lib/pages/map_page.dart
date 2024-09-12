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

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng defaultLocation = LatLng(25.0340637447189, 121.56452691031619);
  String? googApikey;
  bool isMapReady = false;

  @override
  void initState() {
    super.initState();
    googApikey = dotenv.env['googApikey'];
    if (googApikey == null) {
      print('Warning: Google API key is not set');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        if (locationProvider.isLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          LatLng mapCenter =
              locationProvider.currentLocation ?? defaultLocation;
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          child: IconButton(
                            color: Color.fromRGBO(255, 181, 160, 1),
                            icon: Icon(Icons.tune),
                            onPressed: () => FilterBottomSheet.show(context),
                          ),
                        ),
                        SizedBox(width: 10),
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
                              child: Center(child: SpinButton()),
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
