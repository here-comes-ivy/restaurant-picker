import 'package:flutter/material.dart';

class FavoriteFAB extends StatefulWidget {
  @override
  _FavoriteFABState createState() => _FavoriteFABState();
}

class _FavoriteFABState extends State<FavoriteFAB> {
  bool isFavorited = false; // Initial state for favorite status

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      mini: true,
      elevation: 20,
      backgroundColor: isFavorited
          ? Theme.of(context).colorScheme.primaryContainer // Color when favorited
          : Theme.of(context).colorScheme.secondaryContainer, // Color when not favorited
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited; // Toggle the favorite status
        });
      },
      child: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border, // Icon changes
        color: isFavorited
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }
}
