import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'spinner_spinBottomSheet.dart';


class TypeItem extends StatefulWidget {
  TypeItem({required this.name, required this.img});
  final String name;
  final String img;

  @override
  State<TypeItem> createState() => _TypeItemState();
}

class _TypeItemState extends State<TypeItem> {

bool isSelected = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterProvider, child) {
        
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.surface.withOpacity(0.3) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.asset(widget.img),
                    ),
                    SizedBox(height:5,),
                    Text(
                      widget.name,
                      style: TextStyle(
                          
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
                updatedList.remove(widget.name.toUpperCase());
              } else {
                updatedList.add(widget.name.toUpperCase());
              }
              filterProvider.updateRestaurantType(updatedList);
              SpinnerBottomSheet.show(context);
              setState(() => isSelected = !isSelected);

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
