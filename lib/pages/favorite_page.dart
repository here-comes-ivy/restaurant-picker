import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/utils/restaurantSymbolsBuilder.dart';
import '../components/favoritePage/editAndDeleteDialog.dart';


class FavoriteRestaurantsList extends StatefulWidget {
  @override
  State<FavoriteRestaurantsList> createState() =>
      _FavoriteRestaurantsListState();
}

class _FavoriteRestaurantsListState extends State<FavoriteRestaurantsList> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String? loggedinUserID = userProvider.loggedinUserID;
    if (loggedinUserID == null) {
      return Center(
          child: Text(
              'You need to be logged in to view your favorite restaurants.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.fetchFavoriteRestaurants(loggedinUserID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No favorite restaurants saved yet.'));
          }

          var favoriteRestaurants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoriteRestaurants.length,
            itemBuilder: (context, index) {
              var restaurant =
                  favoriteRestaurants[index].data() as Map<String, dynamic>;
              String restaurantName = restaurant['name'];
              String restaurantAddress = restaurant['address'];
              String rating = restaurant['rating'];
              String ratingCount = restaurant['ratingCount'];
              String priceLevel = restaurant['priceLevel'];

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
                  builder: (BuildContext context) => DeleteConfirmationDialog(
                    itemName: restaurant['name'],
                    onDelete: () {
                      setState(() {
                      });
                    },
                  ),
                );
              } else {
                return false;
              }
            },
                child: RestaurantCard(
                  cardChild: Column(
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
                          Text(rating.toString()),
                          SizedBox(width: 8),
                          buildStars(double.parse(rating)),
                          Text(' ($ratingCount)'),
                          SizedBox(width: 8),
                          Text(priceLevel),
                        ],
                      ),
                      Text(restaurantAddress),
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
