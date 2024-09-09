import 'package:flutter/material.dart';

class TypeItem extends StatelessWidget {
  TypeItem({required this.name, required this.img});

  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(img),
        ),
        SizedBox(height: 8),
        Text(name),
      ],
    );
  }
}

class RestaurantTypeFilterRow extends StatelessWidget {
  final List<String> typeList = ['Fried Chicken', 'Hamburger', 'Pizza', 'Ramen', 'Sushi'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: typeList.map((type) => TypeItem(
            name: type,
            img: 'assets/foodType/$type.png',
          )).toList(),
        ),
      ),
    );
  }
}