import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/utils/restaurantTypeNames.dart';

class RestaurantTypeMultipleChoice extends StatefulWidget {
  const RestaurantTypeMultipleChoice({super.key});

  @override
  State<RestaurantTypeMultipleChoice> createState() =>
      RestaurantTypeMultipleChoiceState();
}

class RestaurantTypeMultipleChoiceState
    extends State<RestaurantTypeMultipleChoice> {


  List<String> displayNames = [
    for (var i in restaurantTypeConversion) i['displayName']!
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

  List<String?> apiNames = [
    for (var i in value) convertToAPIName(i)
  ];

  filterProvider.updateRestaurantType(apiNames.where((apiName) => apiName != null).cast<String>().toList());
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
            itemCount: displayNames.length,
            itemBuilder: (selection, i) {
              return ChoiceChip(
                selected: selection.selected(displayNames[i]),
                onSelected: selection.onSelected(displayNames[i]),
                label: Text(displayNames[i]),
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
