import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';


class lunchDecider extends StatefulWidget {
  @override
  _LunchDeciderState createState() => _LunchDeciderState();
}

class _LunchDeciderState extends State<lunchDecider> {
  final List<String> lunchOptions = [
    '牛肉麵',
    '定食',
    '早午餐',
    '漢堡',
    '披薩',
    '沙拉',
    '壽司',
  ];

  String selectedLunch = '';

  void decideLunch() {
    final random = Random();
    setState(() {
      selectedLunch = lunchOptions[random.nextInt(lunchOptions.length)];
    });
  }

  void searchOnMaps() async {
    String query = Uri.encodeComponent(selectedLunch);
    String url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedLunch.isEmpty ? "Not sure what to eat?" : "Let\'s have $selectedLunch",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Nah'),
              onPressed: decideLunch,
            ),
            SizedBox(height: 20),
            if (selectedLunch.isNotEmpty)
              ElevatedButton(
                child: Text("Let's Go!"),
                onPressed: searchOnMaps,
              ),
          ],
        ),
      ),
    );
  }
}