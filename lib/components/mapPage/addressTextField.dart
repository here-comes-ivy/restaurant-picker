import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressTextFiled extends StatefulWidget {
  @override
  _AddressTextFiledState createState() => _AddressTextFiledState();
}

class _AddressTextFiledState extends State<AddressTextFiled> {

  List<dynamic> predictions = [];
  String googApiKey = 'AIzaSyBvCYfs_gzMM3iKU1NpW2XTOlPuwG13b1s';

  Future<void> _onSearchChanged(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        predictions = [];
      });
      return;
    }

    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchText&key=$googApiKey&components=country:tw';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        predictions = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: 'Search places...',
        border: OutlineInputBorder(),
      ),
    );
  }
}
