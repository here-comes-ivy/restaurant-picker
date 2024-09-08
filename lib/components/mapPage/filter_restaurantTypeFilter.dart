import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';

class RestaurantTypeMultipleChoice extends StatefulWidget {
  const RestaurantTypeMultipleChoice({super.key});

  @override
  State<RestaurantTypeMultipleChoice> createState() =>
      RestaurantTypeMultipleChoiceState();
}

class RestaurantTypeMultipleChoiceState
    extends State<RestaurantTypeMultipleChoice> {
  List<String> typeList = [
    'American',
    'Bar',
    'Barbecue',
    'Brazilian',
    'Breakfast',
    'Brunch',
    'Cafe',
    'Chinese',
    'Coffee Shop',
    'Fast Food',
    'French',
    'Greek',
    'Hamburger',
    'Ice Cream Shop',
    'Indian',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Lebanese',
    'Mediterranean',
    'Mexican',
    'Middle Eastern',
    'Pizza',
    'Ramen',
    'Sandwich Shop',
    'Seafood',
    'Spanish',
    'Steak House',
    'Sushi',
    'Thai',
    'Turkish',
    'Vegan',
    'Vegetarian',
    'Vietnamese',
  ];

  List<String> multipleSelected = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    void setMultipleSelected(List<String> value) {
      setState(() => multipleSelected = value);
      filterProvider.updateRestaurantType(value);
    }

    return FilterCard(
      title: 'Restaurant Type',
      cardChild: Column(
        children: [
          InlineChoice<String>(
            multiple: true,
            clearable: true,
            value: multipleSelected,
            onChanged: setMultipleSelected,
            itemCount: typeList.length,
            itemBuilder: (selection, i) {
              return ChoiceChip(
                selected: selection.selected(typeList[i]),
                onSelected: selection.onSelected(typeList[i]),
                label: Text(typeList[i]),
              );
            },
            listBuilder: ChoiceList.createWrapped(
              spacing: 6,
              runSpacing: 6,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
