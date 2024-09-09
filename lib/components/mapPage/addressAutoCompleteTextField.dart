import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'filter_filterBottomSheet.dart';
import 'package:restaurant_picker/services/addressAutoCompletion.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';


class AddressAutoCompleteTextField extends StatefulWidget {
  final Function(String)? onAddressSelected;

  AddressAutoCompleteTextField({this.onAddressSelected});

  @override
  _AddressAutoCompleteTextFieldState createState() => _AddressAutoCompleteTextFieldState();
}

class _AddressAutoCompleteTextFieldState extends State<AddressAutoCompleteTextField> {
  Future<List<String>>? _predictions;
  TextEditingController _controller = TextEditingController();

  void _onSearchChanged(String searchText) {
    if (searchText.isNotEmpty) {
      setState(() {
        _predictions = AddressAutoCompletion().getPlacesAutocomplete(input: searchText);
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
          
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.tune,
                //color: Colors.white,
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