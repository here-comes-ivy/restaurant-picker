import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class RatingFilter extends StatefulWidget {
  final int starCount;

  RatingFilter({
    Key? key,
    this.starCount = 5,
  }) : super(key: key);

  @override
  _RatingFilterState createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {

  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>(context);

    return FilterCard(
      isPremiumFeature: true,
      title: 'Rating',
      cardChild: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.starCount, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRating = index + 1;
                    filterProvider.updateRating(index.toDouble());
                  });
                  //widget.onRatingSelected(_rating);
                },
                child: Icon(
                  index < selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber[600],
                  size: 30,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}