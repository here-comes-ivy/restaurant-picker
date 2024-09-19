import 'package:flutter/material.dart';
import 'filter_filterBottomSheet.dart';
import 'package:restaurant_picker/services/addressAutoCompletion.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:provider/provider.dart';

class AddressAutoCompleteTextField extends StatefulWidget {
  final Function(String)? onAddressSelected;

  const AddressAutoCompleteTextField({super.key, this.onAddressSelected});

  @override
  _AddressAutoCompleteTextFieldState createState() =>
      _AddressAutoCompleteTextFieldState();
}

class _AddressAutoCompleteTextFieldState
    extends State<AddressAutoCompleteTextField> {
  Future<List<String>>? _predictions;
  final TextEditingController _controller = TextEditingController();

  void _onSearchChanged(String searchText) {
    if (searchText.isNotEmpty) {
      setState(() {
        _predictions = AddressAutoCompletion()
            .getPlacesAutocomplete(input: searchText)
            .then((suggestions) => suggestions
                .map((suggestion) => suggestion['name'] as String)
                .toList());
      });
    } else {
      setState(() {
        _predictions = null;
      });
    }
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      _controller.text = suggestion;
      _predictions = null;
    });

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    
    AddressAutoCompletion().getPlacesAutocomplete(input: suggestion).then((suggestions) {
      if (suggestions.isNotEmpty) {
        String placeId = suggestions.firstWhere((s) => s['name'] == suggestion, orElse: () => {'placeId': ''})['placeId'];
        if (placeId.isNotEmpty) {
          locationProvider.getLocationFromPlaceId(placeId);
        }
      }
    });

    if (widget.onAddressSelected != null) {
      widget.onAddressSelected!(suggestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.my_location,
              ),
              onPressed: () {
                FilterBottomSheet.show(context);
              },
            ),
            hintText: 'Search address on Maps',
            hintStyle: const TextStyle(color: Colors.grey),
            border: const OutlineInputBorder(
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
                return const CircularProgressIndicator();
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
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
                        ),
                        onTap: () => _onSuggestionSelected(predictions[index]),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
      ],
    );
  }
}
