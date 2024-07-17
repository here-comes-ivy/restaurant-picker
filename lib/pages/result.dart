import 'package:flutter/material.dart';
import '/utils/colorSetting.dart';
import '/utils/responsiveSize.dart';
import 'googlemaps.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
// https://pub.dev/packages/google_maps_flutter


class resultPage extends StatefulWidget {
  const resultPage({super.key});

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
        leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MapSample(),
            Text('Your result is...'),
            SizedBox(height: 20),
            Text('Location: 123 Main St, City, State, Zip'),
            SizedBox(height: 20),
            Text('Distance: 12.3 miles'),
            SizedBox(height: 20),
            Text('Duration: 2 hours and 30 minutes'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.map),
      ),
      backgroundColor: Colors.white, // Set background color to white
    );
  }
}