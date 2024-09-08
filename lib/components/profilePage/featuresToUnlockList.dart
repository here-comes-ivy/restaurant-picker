import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';

class FeaturesToUnlock extends StatelessWidget {
  final List<Map<String, dynamic>> unlockFeatureList = [
    {
      'title': 'Unlimited Spins',
      'description':
          'Unlock to explore endless restaurant options within 24 hours.',
      'price': 3.99
    },
    {
      'title': 'Advanced Filtering',
      'description':
          'Tailor your search with precision using advanced filters.',
      'price': 5.99
    },
    {
      'title': 'In-App Reservations',
      'description':
          'Easily book a table without leaving the app.',
      'price': 6.99
    },
    {
      'title': 'Group Chat Feature',
      'description':
          'Plan dining with friends and family in real-time by group chats.',
      'price': 7.99
    },
    {
      'title': 'Loyalty Program',
      'description':
          'Earn rewards and unlock exclusive discounts every time you dine.',
      'price': 10.99
    },
  ];

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: unlockFeatureList.length,
      itemBuilder: (BuildContext context, int index) {

      String displayPrice = unlockFeatureList[index]['price']!.toString();
      String featureTitle = unlockFeatureList[index]['title']!;
      String featureDescription = unlockFeatureList[index]['description']!;

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
                        featureTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        featureDescription,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(40, 15)),
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 6))
                    
                  ),
                  onPressed: () {},
                  child: Text('\$$displayPrice',style: TextStyle(fontWeight:FontWeight.bold),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
