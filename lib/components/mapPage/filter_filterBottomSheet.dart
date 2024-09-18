import 'package:flutter/material.dart';
import 'filter_radiusSlider.dart';
import 'filter_restaurantTypeFilter.dart';
import 'filter_priceLevelFilter.dart';
import 'filter_optionSwitchList.dart';
import 'filter_ratingFilter.dart';
import 'filter_openingHour.dart';
import 'spinner_spinBottomSheet.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';
import 'package:restaurant_picker/services/getRestaurantData_test.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});
  final NearbyRestaurantData nearbyRestaurantData = NearbyRestaurantData();

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    LatLng location = locationProvider.searchedLocation;
    double radius = filterProvider.apiRadius;
    List<String> restaurantType = filterProvider.apiRestaurantType;
    
    final Future<List<Map<String, dynamic>>> dataFuture =
        nearbyRestaurantData.fetchData(location:location, radius:radius,restaurantType:restaurantType);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          BottomSheetHandler(),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                const RadiusSlider(),
                FilterDivider,
                RatingFilter(),
                FilterDivider,
                const PriceRangeChoiceChips(),
                FilterDivider,
                const OpeningHourFilter(),
                FilterDivider,
                const RestaurantTypeMultipleChoice(),
                FilterDivider,
                const OptionSwitchList(),
                FilterDivider,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {},
                ),
                FilledButton(
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    SpinnerBottomSheet.show(context, dataFuture);
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

Widget FilterDivider = const Padding(
  padding: EdgeInsets.all(6.0),
  child: Divider(),
);
