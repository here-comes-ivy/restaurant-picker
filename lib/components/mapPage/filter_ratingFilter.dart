import 'package:flutter/material.dart';

class RatingFilter extends StatefulWidget {
  final int starCount;
 // final Function(int)? onRatingSelected;

  RatingFilter({
    Key? key,
    this.starCount = 5,
  //  this.onRatingSelected,
  }) : super(key: key);

  @override
  _RatingFilterState createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Rating'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.starCount, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _rating = index + 1;
                  });
                  //widget.onRatingSelected(_rating);
                },
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
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