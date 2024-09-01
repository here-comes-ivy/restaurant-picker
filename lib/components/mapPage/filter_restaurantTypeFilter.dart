import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class RestaurantTypeMultipleChoice extends StatefulWidget {
  const RestaurantTypeMultipleChoice({super.key});

  @override
  State<RestaurantTypeMultipleChoice> createState() => RestaurantTypeMultipleChoiceState();
}

class RestaurantTypeMultipleChoiceState extends State<RestaurantTypeMultipleChoice> {
List<String> typeList = [
  'American',
  'Bakery',
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
  'Meal Delivery',
  'Meal Takeaway',
  'Mediterranean',
  'Mexican',
  'Middle Eastern',
  'Pizza',
  'Ramen',
  'Restaurant',
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

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
           Text(
            'Restaurant Type',
          ),
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
