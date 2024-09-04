import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_picker/services/firestoreService.dart';


class FavoriteRestaurantsList extends StatelessWidget {
  final String? loggedinUserID;
  final FirestoreService firestoreService = FirestoreService();

  FavoriteRestaurantsList({required this.loggedinUserID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
              var restaurant = favoriteRestaurants[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(restaurant['name'] ?? 'Unnamed Restaurant'),
                subtitle: Text(restaurant['address'] ?? 'No address available'),
                trailing: Text('Rating: ${restaurant['rating'] ?? 'N/A'} (${restaurant['ratingCount'] ?? '0'} reviews)'),
              );
            },
          );
        },
      
    );
  }
}
