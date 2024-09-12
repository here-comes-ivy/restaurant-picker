import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  FilterCard({
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
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        )),
                    cardChild,
                  ],
                ),
              ),
            ),
          ),
        ),
                if (isPremiumFeature)
        Positioned(
          right: 10,
          top: 10,
          child: Icon(Icons.lock, color: Colors.grey), 
        ),
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  RestaurantCard({
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
      margin: customMargin ?? EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: customPadding ?? EdgeInsets.all(6.0),
          child: cardChild,
        ),
      ),
    );
  }
}
