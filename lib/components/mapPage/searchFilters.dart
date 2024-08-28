import 'package:flutter/material.dart';
import 'filterBottomSheet.dart';
import 'restaurantTypeFilter.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({required this.child, required this.widget, this.shape });

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
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => widget,
          );
        },
        child: child,
      ),
    );
  }
}

class SearchFilterRow extends StatelessWidget {
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
                side: BorderSide(color: Colors.grey),
              ),),
            child: Icon(
              Icons.tune,
            ),
            widget: SearchBottomSheet(),
          ),
          SearchFilter(
            child: Text('RestaurantType'),
            widget: SearchBottomSheet(),
          ),
          SearchFilter(
            child: Text('Distance'),
            widget: SearchBottomSheet(),
          ),
          SearchFilter(
            child: Text('OpeningHour'),
            widget: SearchBottomSheet(),
          ),
          SearchFilter(
            child: Text('Price Range'),
            widget: SearchBottomSheet(),
          ),
        ],
      ),
    );
  }
}
