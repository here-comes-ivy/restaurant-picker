import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location.dart';
import '../utils/constants.dart';
import 'filter_page.dart';


// https://pub.dev/packages/modal_bottom_sheet

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();

}

class _MapPageState extends State<MapPage> {
  LocationData location = LocationData();
  LatLng defaultLocation = LatLng(25.0340637447189, 121.56452691031619); // 預設為台北101 

  Future<LatLng?> getLocationData() async{
    return await location.getLocation();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
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
                    markers: Set.of([
                      Marker(
                        markerId: MarkerId("CurrentLocation"),
                        position: mapCenter,
                      ),
                    ]),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.tune),
                            onPressed: (){
                              Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=> FilterPage())
                              );
                            }
                          ),
                          Expanded(
                            child: TextField(
                              style: 
                                TextStyle(
                                  color: Colors.black,
                                ),
                              decoration: kTextInputDecoration,
                              onTap: () {},
                            ),
                          ),
        
                        ],
                      ),
                   
                    ),
                   
                  ),
                ]
              );
            }
          },
        );
      }
    );
  }

}
