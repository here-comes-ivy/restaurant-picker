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
  bool isAllSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filterProvider =
          Provider.of<FilterProvider>(context, listen: false);
      filterProvider.resetFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    void setMultipleSelected(List<String> value) {
      setState(() {
        multipleSelected = value;
        isAllSelected = value.length == displayNames.length;
      });

      List<String?> apiNames = [for (var i in value) convertToAPIName(i)];

      filterProvider.updateRestaurantType(
          apiNames.where((apiName) => apiName != null).cast<String>().toList());
    }

    void toggleSelectAll() {
      setState(() {
        if (isAllSelected) {
          multipleSelected = [];
          isAllSelected = false;
        } else {
          multipleSelected = List.from(displayNames);
          isAllSelected = true;
        }
      });

      List<String?> apiNames = [
        for (var i in multipleSelected) convertToAPIName(i)
      ];

      filterProvider.updateRestaurantType(
          apiNames.where((apiName) => apiName != null).cast<String>().toList());
    }

    return FilterCard(
      isPremiumFeature: false,
      title: 'Restaurant Type',
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 添加這行
        children: [
          Align( // 使用 Align 包裹 Row
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min, // 設置為 min
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: toggleSelectAll,
                  child: const Text(
                    'Select All',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              spacing: 3,
              runSpacing: 3,
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
