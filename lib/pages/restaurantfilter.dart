import 'package:flutter/material.dart';

class RestaurantFilterCard extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilterChanged;

  const RestaurantFilterCard({Key? key, required this.onFilterChanged}) : super(key: key);

  @override
  _RestaurantFilterCardState createState() => _RestaurantFilterCardState();
}

class _RestaurantFilterCardState extends State<RestaurantFilterCard> {
  RangeValues _priceRange = const RangeValues(0, 1000);
  double _rating = 3.0;
  String _selectedCuisine = '不限';
  bool _deliveryAvailable = false;
  double _distance = 5.0;

  void _updateFilters() {
    widget.onFilterChanged({
      'priceRange': _priceRange,
      'rating': _rating,
      'cuisine': _selectedCuisine,
      'delivery': _deliveryAvailable,
      'distance': _distance,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('餐廳篩選'),
            const SizedBox(height: 16),
            Text('價格範圍'),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                '${_priceRange.start.round()}',
                '${_priceRange.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                  _updateFilters();
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Rating'),
            Slider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _rating.toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value;
                  _updateFilters();
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Category'),
            DropdownButton<String>(
              value: _selectedCuisine,
              isExpanded: true,
              items: <String>['All', 'Chinese', 'Western', 'Japanese', 'Korean', 'Thai']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCuisine = newValue!;
                  _updateFilters();
                });
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Delivery service provided'),
              value: _deliveryAvailable,
              onChanged: (bool? value) {
                setState(() {
                  _deliveryAvailable = value!;
                  _updateFilters();
                });
              },
            ),
            const SizedBox(height: 16),
            Text('Distance'),
            Slider(
              value: _distance,
              min: 1,
              max: 20,
              divisions: 19,
              label: '${_distance.round()} km',
              onChanged: (double value) {
                setState(() {
                  _distance = value;
                  _updateFilters();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}