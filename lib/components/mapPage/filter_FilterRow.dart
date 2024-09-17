import 'package:flutter/material.dart';
import 'filter_filterBottomSheet.dart';


class SearchFilter extends StatelessWidget {
  SearchFilter({super.key, required this.child, required this.widget, this.shape });

  Widget widget;
  Widget child;
  WidgetStateProperty<OutlinedBorder?>? shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: FilledButton.tonal(
        style: ButtonStyle(
          shape: shape,
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surface.withOpacity(0.8)),
        ),
        onPressed: () {
          FilterBottomSheet.show(context);
        },
        child: child,
      ),
    );
  }
}

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SearchFilter(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.grey),
              ),),
            widget: FilterBottomSheet(),
            child: Icon(
              Icons.tune,
            ),
          ),
          SearchFilter(
            widget: FilterBottomSheet(),
            child: Text('RestaurantType'),
          ),
          SearchFilter(
            widget: FilterBottomSheet(),
            child: Text('Distance'),
          ),
          SearchFilter(
            widget: FilterBottomSheet(),
            child: Text('OpeningHour'),
          ),
          SearchFilter(
            widget: FilterBottomSheet(),
            child: Text('Price Range'),
          ),
        ],
      ),
    );
  }
}
