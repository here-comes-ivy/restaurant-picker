import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/components/favoritePage/favoriteitems.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';


class FavoritedList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SliverFixedExtentList(
                itemExtent: 100.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return RestaurantCard(
                      cardChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('List Item ${index + 1}'),
                          Text('Details of Item${index + 1}'),
                        ],
                      ),
                    );
                  },
                  childCount: 5,

                ),
              );
  }
}