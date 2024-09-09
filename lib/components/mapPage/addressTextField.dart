import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'filter_filterBottomSheet.dart';
import 'package:restaurant_picker/services/addressAutoCompletion.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';


class AddressTextField extends StatefulWidget {
  final Function(String)? onAddressSelected;

  AddressTextField({this.onAddressSelected});

  @override
  _AddressTextFieldState createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  Future<List<String>>? _predictions;
  TextEditingController _controller = TextEditingController();

  void _onSearchChanged(String searchText) {
    if (searchText.isNotEmpty) {
      setState(() {
        _predictions = AddressAutoCompletion().getPlacesAutocomplete(searchText);
      });
    } else {
      setState(() {
        _predictions = null;
      });
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
                color: Theme.of(context).colorScheme.surface,
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
        if (_predictions != null)
          FutureBuilder<List<String>>(
            future: _predictions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
              
                return Container();
              } else if (snapshot.hasData) {
                final predictions = snapshot.data!;
                return Container(
                  color: Colors.white,
                  height: 200,
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          predictions[index],
                          style: TextStyle(color: Theme.of(context).colorScheme.surface),
                        ),
                        onTap: () {
                          setState(() {
                            _controller.text = predictions[index];
                            _predictions = null;
                          });
                          if (widget.onAddressSelected != null) {
                            widget.onAddressSelected!(_controller.text);
                          }
                        },
                      );
                    },
                  ),
                );
              } else {
                return SizedBox.shrink();
                }
              },
           ),
         ],
       );
     }
   }