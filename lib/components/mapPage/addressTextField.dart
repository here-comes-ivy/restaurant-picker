import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressTextField extends StatefulWidget {
  final String apiKey;
  final String country;
  final Function(String)? onAddressSelected;
  final InputDecoration? decoration;

  const AddressTextField({
    Key? key,
    required this.apiKey,
    this.country = 'tw',
    this.onAddressSelected,
    this.decoration,
  }) : super(key: key);

  @override
  _AddressTextFieldState createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  List<dynamic> predictions = [];
  TextEditingController _controller = TextEditingController();

  Future<void> _onSearchChanged(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        predictions = [];
      });
      return;
    }

    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchText&key=${widget.apiKey}&components=country:${widget.country}';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          predictions = json.decode(response.body)['predictions'];
        });
      } else {
        print('Failed to load predictions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching predictions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onSearchChanged,
          decoration: widget.decoration ?? InputDecoration(
            hintText: 'Search places...',
            border: OutlineInputBorder(),
          ),
        ),
        if (predictions.isNotEmpty)
          Container(
            height: 200, // 可以根据需要调整高度
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(predictions[index]['description']),
                  onTap: () {
                    setState(() {
                      _controller.text = predictions[index]['description'];
                      predictions = []; // 清空预测列表
                    });
                    if (widget.onAddressSelected != null) {
                      widget.onAddressSelected!(_controller.text);
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
