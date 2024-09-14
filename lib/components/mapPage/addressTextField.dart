import 'package:flutter/material.dart';
import 'filter_filterBottomSheet.dart';
import 'package:restaurant_picker/services/addressAutoCompletion.dart';


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
          
          
          style:TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.my_location,
              ),
              onPressed: () {
                FilterBottomSheet.show(context);
              },
            ),
            hintText: 'Search address on Maps',
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