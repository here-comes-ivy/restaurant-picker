import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/favoriteStateProvider.dart';


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
  final String restaurantRating;
  final String restaurantRatingCount;
  final String restaurantAddress;
  final String restaurantPriceLevel;

  @override
  FavoriteFABState createState() => FavoriteFABState();
}

class FavoriteFABState extends State<FavoriteFAB> {
  bool isFavorited = false;
  late FirestoreService firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    // checkIfFavorited();
  }

  // Future<void> checkIfFavorited() async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final favoriteState = Provider.of<FavoriteStateProvider>(context);

  //   bool favorited = await firestoreService.isRestaurantFavorited(
  //     loggedinUserID: userProvider.loggedinUserID,
  //     restaurantID: widget.restaurantID,
  //   );
  //   setState(() {
  //     isFavorited = favorited;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return FloatingActionButton(
      shape: const CircleBorder(),
      mini: true,
      elevation: 20,
      backgroundColor: isFavorited
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      onPressed: () async {
        await firestoreService.updateBrowseHistory(
          loggedinUserID: userProvider.loggedinUserID,
          restaurantID: widget.restaurantID,
          restaurantName: widget.restaurantName,
          rating: widget.restaurantRating,
          ratingCount: widget.restaurantRatingCount,
          address: widget.restaurantAddress,
          priceLevel: widget.restaurantPriceLevel,
          savedAsFavorite: !isFavorited, // Toggle the favorite status
        );
        setState(() {
          isFavorited = !isFavorited;
        });
      },
      child: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }
}