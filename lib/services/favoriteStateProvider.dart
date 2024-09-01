import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';

class FavoriteStateProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};
  final FirestoreService _firestoreService = FirestoreService();

  bool isFavorite(String restaurantID) => _favorites[restaurantID] ?? false;

  Future<void> toggleFavorite({
    required String loggedinUserID,
    required String restaurantID,
    required String restaurantName,
    required String rating,
    required String ratingCount,
    required String address,
    required String priceLevel,
  }) async {
    final newState = !isFavorite(restaurantID);
    _favorites[restaurantID] = newState;
    notifyListeners();

    await _firestoreService.updateBrowseHistory(
      loggedinUserID: loggedinUserID,
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
      final isFavorited = await _firestoreService.isRestaurantFavorited(
        loggedinUserID: loggedinUserID,
        restaurantID: restaurantID,
      );
      _favorites[restaurantID] = isFavorited;
      notifyListeners();
    }
  }
}