import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  FilterCard({
    required this.color,
    this.cardChild,
    this.onPress,
  });

  final Color color;
  final Widget? cardChild;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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
        onTap: () {}, // 添加這個空的onTap以啟用水波紋效果
        child: Padding(
          padding: customPadding ?? EdgeInsets.all(6.0),
          child: cardChild,
        ),
      ),
    );
  }
}
