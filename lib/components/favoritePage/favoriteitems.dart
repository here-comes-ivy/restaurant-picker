import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/utils/restaurantSymbolsBuilder.dart';
import 'editAndDeleteDialog.dart';


class FavoriteRestaurantsItems extends StatefulWidget {
  final String? loggedinUserID;

  FavoriteRestaurantsItems({required this.loggedinUserID});

  @override
  State<FavoriteRestaurantsItems> createState() => _FavoriteRestaurantsItemsState();
}

class _FavoriteRestaurantsItemsState extends State<FavoriteRestaurantsItems> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      firestoreService.fetchFavoriteRestaurants(widget.loggedinUserID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text('No favorite restaurants saved yet.'));
                    }

                    var favoriteRestaurants = snapshot.data!.docs;
                    print(favoriteRestaurants);

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: favoriteRestaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = favoriteRestaurants[index].data()
                            as Map<String, dynamic>;

                        String restaurantName =
                            restaurant['name'] ?? 'Unknown Restaurant';
                        double restaurantRating = restaurant['rating'];
                        int restaurantRatingCount = restaurant['ratingCount'];

                        String restaurantAddress =
                            restaurant['address'] ?? 'Unknown Address';
                        String restaurantPriceLevel = buildPriceLevel(
                            restaurant['priceLevel'] ?? 'Unknown Price Level');
                        String displayRating = restaurantRating.toString();
                        String displayRatingCount =
                            restaurantRatingCount.toString();

                        return Dismissible(
                          key: Key(restaurant['name']),
                          secondaryBackground: DeleteBackground(),
                          background: EditBackground(),
                          dismissThresholds: {
                            DismissDirection.endToStart: 0.2,
                            DismissDirection.startToEnd: 0.2,
                          },
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    DeleteConfirmationDialog(
                                  itemName: restaurant['name'],
                                  onDelete: () {
                                    setState(() {});
                                  },
                                ),
                              );
                            } else {
                              return false;
                            }
                          },
                          child: RestaurantCard(
                            cardChild: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurantName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(displayRating),
                                        SizedBox(width: 8),
                                        buildStars(restaurantRating),
                                        Text(' ($displayRatingCount)'),
                                        SizedBox(width: 8),
                                        Text(restaurantPriceLevel),
                                      ],
                                    ),
                                    Text(restaurantAddress),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
  }
}
