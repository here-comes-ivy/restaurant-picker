import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  FilterButton({required this.label});
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: FilledButton.tonal(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surface.withOpacity(0.8)),
        ),
        onPressed: () {},
        child: Text(label),
      ),
    );
  }
}

class SearchFilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterButton(label: 'RestaurantType'),
          FilterButton(label: 'Distance'),
          FilterButton(label: 'OpeningHour'),
          FilterButton(label: 'Price Range'),
        ],
      ),
    );
  }
}
