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




class ProfileCard extends StatelessWidget {

  ProfileCard({
    this.cardChild,
  });
  
  final Widget? cardChild;

  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 4.0,
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: cardChild 
    ),
                    );
  }
}

