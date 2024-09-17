import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({super.key, 
    required this.title,
    required this.cardChild,
    required this.isPremiumFeature,
  });

  final Widget cardChild;
  final String title;
  final bool isPremiumFeature;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: isPremiumFeature ? 0.5 : 1.0,
          child: SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        )),
                    cardChild,
                  ],
                ),
              ),
            ),
          ),
        ),
                if (isPremiumFeature)
        const Positioned(
          right: 10,
          top: 10,
          child: Icon(Icons.lock, color: Colors.grey), 
        ),
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, 
    this.cardChild,
    this.customPadding,
    this.customMargin,
  });

  final Widget? cardChild;
  final EdgeInsetsGeometry? customPadding;
  final EdgeInsetsGeometry? customMargin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: customMargin ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: customPadding ?? const EdgeInsets.all(6.0),
          child: cardChild,
        ),
      ),
    );
  }
}
