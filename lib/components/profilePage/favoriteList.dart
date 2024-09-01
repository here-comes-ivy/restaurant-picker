import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';

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
                  childCount: 5, // 設置列表項目數量
                ),
              );
  }
}