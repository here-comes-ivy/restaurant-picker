import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class TypeItem extends StatelessWidget {
  TypeItem({required this.name, required this.img});
  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterProvider, child) {
        bool isSelected = filterProvider.apiRestaurantType?.contains(name.toLowerCase()) ?? false;
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.asset(img),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              List<String> updatedList = List<String>.from(filterProvider.apiRestaurantType ?? []);
              if (isSelected) {
                updatedList.remove(name.toLowerCase());
              } else {
                updatedList.add(name.toLowerCase());
              }
              filterProvider.updateRestaurantType(updatedList);
            },
          ),
        );
      },
    );
  }
}

class RestaurantTypeFilterRow extends StatelessWidget {
  final List<String> displayTypeList = [
    'brunch',
    'cafe',
    'chinese',
    'hamburger',
    'korean',
    'pizza',
    'ramen',
    'sushi',
    'thai',
    'vegetarian',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: displayTypeList
              .map((type) => TypeItem(
                    name: type,
                    img: 'assets/foodType/$type.png',
                  ))
              .toList(),
        ),
      ),
    );
  }
}
