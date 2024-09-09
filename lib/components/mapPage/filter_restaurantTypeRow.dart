import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';

class TypeItem extends StatelessWidget {
  TypeItem({required this.name, required this.img});

  final String name;
  final String img;
  late List<String> typeList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        child: Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.only(right: 2.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
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
          typeList.add(name);
          FilterProvider().updateRestaurantType(typeList);
        },
      ),
    );
  }
}

class RestaurantTypeFilterRow extends StatelessWidget {
  List<String> displayTypeList = [
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
                    name: type.toUpperCase(),
                    img: 'assets/foodType/$type.png',
                  ))
              .toList(),
        ),
      ),
    );
  }
}
