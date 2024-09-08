import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';

class FeaturesToUnlock extends StatelessWidget {
  final List<Map<String, String>> unlockFeatureList = [
    {
      'title': 'Unlimited Spins',
      'description': 'Unlock endless possibilities by enabling unlimited spins. Discover a new dining experience every time without any restrictions!'
    },
    {
      'title': 'Group Chat Feature',
      'description': 'Coordinate with friends and family in real-time. Share restaurant options, vote on favorites, and finalize your dining plans seamlessly within the app.'
    },
    {
      'title': 'Advanced Filtering',
      'description': 'Tailor your search with precision using advanced filters. Whether you\'re craving a specific cuisine, need a quiet spot, or have dietary restrictions, find the perfect restaurant that meets all your criteria.'
    },
    {
      'title': 'Loyalty Program',
      'description': 'Earn rewards every time you dine! Our integrated loyalty program lets you collect points and unlock exclusive discounts at your favorite restaurants, making every meal more rewarding.'
    },
    {
      'title': 'In-App Reservations',
      'description': 'Easily book a table at your selected restaurant without leaving the app. Check availability in real-time and receive instant confirmation for a seamless dining experience.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: unlockFeatureList.length,
      itemBuilder: (BuildContext context, int index) {
        return RestaurantCard(
          cardChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.lock, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unlockFeatureList[index]['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          unlockFeatureList[index]['description']!,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}