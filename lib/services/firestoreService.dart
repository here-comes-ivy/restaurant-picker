import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'userDataProvider.dart';
import 'RestaurantDataProvider.dart';

class FirestoreService {
  final firestore = FirebaseFirestore.instance;
  Future<void> updateUserData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.loggedinUserID != null &&
        userProvider.loggedinUserEmail != null) {
      final userRef =
          firestore.collection('users').doc(userProvider.loggedinUserID);
      try {
        await userRef.set({
          'email': userProvider.loggedinUserEmail,
          'lastSignIn': FieldValue.serverTimestamp(),
          'name': userProvider.loggedinUserName ?? '',
        }, SetOptions(merge: true));
      } catch (e) {
        print('Failed to update user data: $e');
      }
    } else {
      print('User ID or email is null');
    }
  }

  Future<void> updateFavoriteList({
    required String? loggedinUserID,
    required String? restaurantID,
    required String? restaurantName,
    required double? rating,
    required int? ratingCount,
    required String? address,
    required String? priceLevel,
    required bool savedAsFavorite,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(restaurantID)
          .set({
        'name': restaurantName,
        'rating': rating,
        'ratingCount': ratingCount,
        'address': address,
        'priceLevel': (priceLevel != '')? priceLevel: 'N/A',
        'savedAsFavorite': savedAsFavorite,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Restaurant ID $restaurantID has been saved to Firestore with savedAsFavorite status set to $savedAsFavorite' );
    } catch (e) {
      print('Failed to save restaurant ID: $e');
    }
  }

 Future<void> updateFavoriteStatus({
    required String? loggedinUserID,
    required String? restaurantID,
    required bool savedAsFavorite,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(restaurantID)
          .set({
        'savedAsFavorite': savedAsFavorite,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Favorite status of Restaurant ID $restaurantID has been updated to Firestore.');
    } catch (e) {
      print('Failed to update favorite status: $e');
    }
  }


Stream<QuerySnapshot> fetchFavoriteRestaurants(String? loggedinUserID) {
  try {
    return firestore
        .collection('users')
        .doc(loggedinUserID)
        .collection('favoriteRestaurant')
        .where('savedAsFavorite', isEqualTo: true)
        .snapshots();
  } catch (e) {
    print('Error starting stream: $e');
    return Stream.empty();
  }
}


  Stream<bool> fetchFavoriteStatus({
    required String? loggedinUserID,
    required String? restaurantID,
  }) {
    return firestore
        .collection('users')
        .doc(loggedinUserID)
        .collection('favoriteRestaurant')
        .doc(restaurantID)
        .snapshots()
        .map((doc) => doc.exists && doc.data()?['savedAsFavorite'] == true);
  }
}
