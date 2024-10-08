import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class PriceRangeChoiceChips extends StatefulWidget {
  const PriceRangeChoiceChips({super.key});

  @override
  State<PriceRangeChoiceChips> createState() => _PriceRangeChoiceChipsState();
}

class _PriceRangeChoiceChipsState extends State<PriceRangeChoiceChips> {
  bool isPremiumFeature = true;

  int? displayPriceLevel;

  @override
  Widget build(BuildContext context) {

    final filterProvider = Provider.of<FilterProvider>(context);


    return  FilterCard(
      isPremiumFeature: true,
        title: 'Price Level',

        cardChild: Column(
          children: <Widget>[
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(
                4,
                (int index) {
                  String text = '\$' * (index + 1);
                  return ChoiceChip(
                    label: Text(text),
                    selected: displayPriceLevel == index,
                    onSelected: (bool selected) {
                      setState(() {
                        displayPriceLevel = selected ? index : null;
                        filterProvider.updatePriceRange(displayPriceLevel);
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
