import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../services/getNearbyRestaurants.dart';

final placesService = PlaceService();

late Future<List<Map<String, dynamic>>> nearbyRestaurantsFuture = placesService.fetchData();


FortuneItem restaurantData() {
    return FortuneItem(
      child: Card(
        child: Column(
          children: [
            Text('name'),
            buildstars(5),
            Text('Restaurant Category'),
            SizedBox(height: 10),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.open_in_full),
                  SizedBox(width: 8),
                  Text('Details'),
                ], 
              ),
              onPressed: () {}
            ),
            ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.directions),
                  SizedBox(width: 8),
                  Text('Direction'),
                ],
              ),
              onPressed: () {}
            ),
          ],
        ),
      ),
    );
  }
  

Row buildstars(int starsnum) {
  List<Widget> stars = [];
  for (int i = 0; i < 5; i++) {
    if (i < starsnum) {
      stars.add(Icon(Icons.star));
    } else {
      stars.add(Icon(Icons.star_border));
    }
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: stars,
  );
}

Future<List<FortuneItem>> convertToFortuneItems(Future<List<Map<String, dynamic>>> futureData) async {
  // 等待 Future 完成
  final List<Map<String, dynamic>> data = await futureData;
  
  // 將每個 item 轉換為 FortuneItem
  return data.map((item) {
    return FortuneItem(
      child: Text(item['name'] as String),
      style: FortuneItemStyle(
        color: Colors.blue, // 你可以根據需要自定義顏色
        borderWidth: 2,
      ),
      // 你可以根據需要添加更多 FortuneItem 的屬性
    );
  }).toList();
}
