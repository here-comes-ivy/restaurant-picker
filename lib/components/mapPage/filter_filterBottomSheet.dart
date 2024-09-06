import 'package:flutter/material.dart';
import 'filter_radiusSlider.dart';
import 'filter_restaurantTypeFilter.dart';
import 'filter_priceLevelFilter.dart';
import 'filter_optionSwitchList.dart';
import 'filter_ratingFilter.dart';
import 'filter_openingHour.dart';
import 'spinner_spinBottomSheet.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(child: Text("Set Filter"), padding: EdgeInsets.all(10)),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                OpeningHourFilter(),
                FilterDivider,
                RadiusSlider(),
                FilterDivider,
                RatingFilter(),
                FilterDivider,
                PriceRangeChoiceChips(),
                FilterDivider,
                RestaurantTypeMultipleChoice(),
                FilterDivider,
                OptionSwitchList(),
                FilterDivider,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text(
                    'Clear all',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {},
                ),
                FilledButton(
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    SpinnerBottomSheet.show(context);
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) => FilterBottomSheet(),
    );
  }
}

Widget FilterDivider = Padding(
  padding: const EdgeInsets.all(10.0),
  child: Divider(),
);
