import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'filter_filterBottomSheet.dart';


class AddressAutoCompleteTextField extends StatefulWidget {
  final String apiKey = dotenv.env['googApikey']!;
  final String country;
  final Function(String)? onAddressSelected;
  final InputDecoration? decoration;

  AddressAutoCompleteTextField({
    Key? key,
    this.country = 'tw',
    this.onAddressSelected,
    this.decoration,
  }) : super(key: key);

  @override
  _AddressAutoCompleteTextFieldState createState() => _AddressAutoCompleteTextFieldState();
}

class _AddressAutoCompleteTextFieldState extends State<AddressAutoCompleteTextField> {
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
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.tune,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.8),
                              ),
                              onPressed: () {
                                FilterBottomSheet.show(context);
                              },
                            ),
                            hintText: 'Search on Map',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
          controller: _controller,
          onChanged: _onSearchChanged,
        ),
        if (predictions.isNotEmpty)
          Container(
            color: Colors.white,
            height: 200, 
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(predictions[index]['description'], style: TextStyle(color: Theme.of(context)
                                    .colorScheme
                                    .surface),),
                  onTap: () {
                    setState(() {
                      _controller.text = predictions[index]['description'];
                      predictions = []; 
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
