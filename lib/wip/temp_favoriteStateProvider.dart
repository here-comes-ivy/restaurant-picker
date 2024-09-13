import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavoriteStateProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  final FirestoreService _firestoreService = FirestoreService();

  final firestore = FirebaseFirestore.instance;


  bool isFavorite(String restaurantID) => _favorites[restaurantID] ?? false;

  Future<bool> isRestaurantFavorited({
    required String? loggedinUserID,
    required String? restaurantID,
  }) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(restaurantID)
          .get();
      return doc.exists && doc.data()?['savedAsFavorite'] == true;
    } catch (e) {
      print('Failed to check if restaurant is favorited: $e');
      return false;
    }
  }

  Future<void> toggleFavorite(BuildContext context, {
    required String loggedinUserID,
    required String restaurantID,
    required String restaurantName,
    required double rating,
    required int ratingCount,
    required String address,
    required String priceLevel,
  }) async {
    final newState = !isFavorite(restaurantID);
    _favorites[restaurantID] = newState;
    notifyListeners();

    await _firestoreService.updateFavoriteList(
      context,
      restaurantID: restaurantID,
      restaurantName: restaurantName,
      rating: rating,
      ratingCount: ratingCount,
      address: address,
      priceLevel: priceLevel,
      savedAsFavorite: newState,
    );
  }

  Future<void> initializeFavorite(String loggedinUserID, String restaurantID) async {
    if (!_favorites.containsKey(restaurantID)) {
      final isFavorited = await isRestaurantFavorited(
        loggedinUserID: loggedinUserID,
        restaurantID: restaurantID,
      );
      _favorites[restaurantID] = isFavorited;
      notifyListeners();
    }
  }

    

}