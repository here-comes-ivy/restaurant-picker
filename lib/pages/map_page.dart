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
import '../components/mapPage/addressAutoCompleteTextField.dart';
import '../components/mapPage/filter_restaurantTypeRow.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng defaultLocation =
      LatLng(25.0340637447189, 121.56452691031619); // 台北101

  String googApikey = dotenv.env['googApikey']!;

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
                    child: Column(
                      children: [
                        Expanded(child: AddressAutoCompleteTextField()),
                        SizedBox(height:10.0),
                        RestaurantTypeFilterRow(),
                      ],
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
