import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import '../services/location.dart';
import 'map_page.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState(
  );
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
  }

  LocationData location = LocationData();
  LatLng defaultLocation = LatLng(25.0340637447189, 121.56452691031619);
  Future<LatLng?> getLocationData() async {
 // 預設為台北101 
    return await location.getLocation();
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
          return Container();
        }
      },
    );
  }

}


    // Navigator.push(
    //   context, MaterialPageRoute(
    //     builder: (context){
    //       return MapPage();
    //     }));
