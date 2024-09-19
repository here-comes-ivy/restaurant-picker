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
    setState(() {
      currentFavorites
          .removeWhere((restaurant) => restaurant['id'] == restaurantID);
    });
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
        print('currentFavorites: $currentFavorites');
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
          child: ListView.builder(
            itemCount: currentFavorites.length,
            itemBuilder: (context, index) {
              var restaurant = currentFavorites[index];
              String restaurantID = restaurant['id'] ?? 'unknown';
              String restaurantName = restaurant['name'] ?? 'Unknown Restaurant';
              double restaurantRating = restaurant['rating'];
              int restaurantRatingCount = restaurant['ratingCount'];
          
              String restaurantAddress =
                  restaurant['address'] ?? 'Unknown Address';
              String restaurantPriceLevel = buildPriceLevel(
                  restaurant['priceLevel'] ?? 'Unknown Price Level');
              String displayRating = restaurantRating.toString();
              String displayRatingCount = restaurantRatingCount.toString();
              String photoUrl = restaurant['photoUrl'] ?? '';
          
              return Dismissible(
                key: ValueKey(restaurantID),
                background: DeleteWidget(),
                dismissThresholds: const {DismissDirection.startToEnd: 0.7},
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          DeleteFavoriteConfirmationDialog(
                        itemName: restaurantName,
                        onDelete: () {
                          removeRestaurant(restaurantID);
                        },
                        restaurantID: restaurantID,
                        loggedinUserID: loggedinUserID!,
                      ),
                    );
                  } else {
                    return false;
                  }
                },
                child: RestaurantCard(
                  cardChild: Stack(
                    children: [
                      if (photoUrl.isNotEmpty)
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.7,
                            child: Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey),
                            ),
                          ),
                        ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
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
                                Text(restaurantAddress),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
