import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'googlemaps.dart';
import 'restaurantfilter.dart';
import 'profile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  int _selectedIndex = 0;


  static List<Widget> _widgetOptions = [

        GoogleMapWidget(),
        Center(child: Text('Restaurant Filter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Center(child: Text('AI Chat Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // moving to googlemaps.dart
  final LatLng _center = const LatLng(121.41958448080783, 25.044335752553348);

  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: 
          _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bolt),
                label: 'Shuffle',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quickreply),
                label: 'Chat with AI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        );
  }
}