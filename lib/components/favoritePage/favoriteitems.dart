import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';
import 'editAndDeleteDialog.dart';

class FavoriteRestaurantsItems extends StatefulWidget {
  const FavoriteRestaurantsItems({super.key});

  @override
  State<FavoriteRestaurantsItems> createState() =>
      _FavoriteRestaurantsItemsState();
}

class _FavoriteRestaurantsItemsState extends State<FavoriteRestaurantsItems> {
  final FirestoreService firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _favoritesFuture;
  List<Map<String, dynamic>> currentFavorites = [];

  @override
  void initState() {
    super.initState();
    refreshFavorites();
  }

  Future<void> refreshFavorites() async {
    setState(() {
      _favoritesFuture = firestoreService.fetchFavoriteRestaurants(context);
    });
  }

  Future<void> removeRestaurant(String restaurantID) async {
    await firestoreService.updateFavoriteStatus(context,
        restaurantID: restaurantID, savedAsFavorite: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String? loggedinUserID = userProvider.loggedinUserID;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _favoritesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No favorite restaurants saved yet.'));
        }

        currentFavorites = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: currentFavorites.length,
          itemBuilder: (context, index) {
            var restaurant = currentFavorites[index];
            String restaurantName = restaurant['name'] ?? 'Unknown Restaurant';
            double restaurantRating = restaurant['rating'];
            int restaurantRatingCount = restaurant['ratingCount'];

            String restaurantAddress =
                restaurant['address'] ?? 'Unknown Address';
            String restaurantPriceLevel = buildPriceLevel(
                restaurant['priceLevel'] ?? 'Unknown Price Level');
            String displayRating = restaurantRating.toString();
            String displayRatingCount = restaurantRatingCount.toString();

            return Dismissible(
              key: Key(restaurant['name']),
              background: DeleteWidget(),
              dismissThresholds: const {DismissDirection.startToEnd: 0.7},
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        DeleteFavoriteConfirmationDialog(
                      itemName: restaurant['name'],
                      onDelete: () {
                        setState(() {});
                      },
                      restaurantID: currentFavorites[index]['id'],
                      loggedinUserID: loggedinUserID!,
                    ),
                  );
                } else {
                  return false;
                }
              },
              child: RestaurantCard(
                cardChild: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: [
                              Text(displayRating),
                              const SizedBox(width: 8),
                              buildStars(restaurantRating),
                              Text(' ($displayRatingCount)'),
                              const SizedBox(width: 8),
                              Text(restaurantPriceLevel),
                            ],
                          ),
                          Text(
                            restaurantAddress,
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
      },
    );
  }
}
