import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';


class FavoriteFAB extends StatefulWidget {
  FavoriteFAB({
    required this.restaurantID,
    required this.restaurantName,
    required this.restaurantRating,
    required this.restaurantRatingCount,
    required this.restaurantAddress,
    required this.restaurantPriceLevel,
  });

  final String restaurantID;
  final String restaurantName;
  final double restaurantRating;
  final int restaurantRatingCount;
  final String restaurantAddress;
  final String restaurantPriceLevel;

  @override
  FavoriteFABState createState() => FavoriteFABState();
}

class FavoriteFABState extends State<FavoriteFAB> {
  late FirestoreService firestoreService;
  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();

  }


  @override
Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  String? loggedinUserID = userProvider.loggedinUserID;

  return StreamBuilder<bool>(
    stream: firestoreService.fetchFavoriteStatus(
      loggedinUserID: loggedinUserID,
      restaurantID: widget.restaurantID,
    ),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // 或者你可以顯示一個佔位的圖標
      }
      bool isFavorited = snapshot.data ?? false;

      return FloatingActionButton(
        shape: const CircleBorder(),
        mini: true,
        elevation: 20,
        backgroundColor: isFavorited
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () async {
          await firestoreService.updateFavoriteList(
            loggedinUserID: loggedinUserID,
            restaurantID: widget.restaurantID,
            restaurantName: widget.restaurantName,
            rating: widget.restaurantRating,
            ratingCount: widget.restaurantRatingCount,
            address: widget.restaurantAddress,
            priceLevel: widget.restaurantPriceLevel,
            savedAsFavorite: !isFavorited,
          );
        },
        child: Icon(
          isFavorited ? Icons.favorite : Icons.favorite_border,
          color: isFavorited
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      );
    },
  );
}
}