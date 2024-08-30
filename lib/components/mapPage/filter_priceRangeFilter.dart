import 'package:flutter/material.dart';

/// Flutter code sample for [ActionChoice].


class PriceRangeChoiceChips extends StatefulWidget {
  const PriceRangeChoiceChips({super.key});

  @override
  State<PriceRangeChoiceChips> createState() => _PriceRangeChoiceChipsState();
}

class _PriceRangeChoiceChipsState extends State<PriceRangeChoiceChips> {
  int? _value = 1;

  @override
  Widget build(BuildContext context) {

    return  Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Price range'),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  String text = '\$' * (index + 1);
                  return ChoiceChip(
                    label: Text(text),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ],
        ),
      
    );
  }
}
