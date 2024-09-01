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

  Future<void> updateBrowseHistory({
    required String? loggedinUserID,
    required String? restaurantID,
    required String? restaurantName,
    required String? rating,
    required String? ratingCount,
    required String? address,
    required String? priceLevel,
    required bool savedAsFavorite,
  }) async {
    try {
      await firestore.collection('users').doc(loggedinUserID).collection('favoriteRestaurant').doc(restaurantID).set({
        'name': restaurantName,
        'rating': rating,
        'ratingCount': ratingCount,
        'address': address,
        'priceLevel': priceLevel,
        'savedAsFavorite': true,
        'lastUpdated': FieldValue.serverTimestamp(),
        
      }, SetOptions(merge: true));
      print('Restaurant ID $restaurantID has been saved to Firestore.');
    } catch (e) {
      print('Failed to save restaurant ID: $e');
    }
  }

  Future<bool> isRestaurantFavorited({
    required String? loggedinUserID,
    required String? restaurantID,
  }) async {
    try {
      final doc = await firestore.collection('users').doc(loggedinUserID).collection('favoriteRestaurant').doc(restaurantID).get();
      return doc.exists && doc.data()?['savedAsFavorite'] == true;
    } catch (e) {
      print('Failed to check if restaurant is favorited: $e');
      return false;
    }
  }

}
