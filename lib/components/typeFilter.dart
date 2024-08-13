import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

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

class TypeFilter extends StatefulWidget {
  @override
  _TypeFilterState createState() => _TypeFilterState();
}

class _TypeFilterState extends State<TypeFilter> {
  List<String> selectedTypeList = [];

  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: typeList,
      selectedListData: selectedTypeList,
      choiceChipLabel: (item) => item,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (item, query) {
        return item.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedTypeList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
              onPressed: openFilterDialog,
              child: Text('Restaurant Type'),
            );
  }
}
