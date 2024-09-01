import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantProvider with ChangeNotifier {
  String? _restaurantId;
  String? _restaurantName;
  String? _rating;
  String? _ratingCount;
  String? _address;
  String? _priceLevel;
  bool _savedAsFavorite = false;
  bool _isLoading = false;
  String _error = '';

  String? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;
  String? get rating => _rating;
  String? get ratingCount => _ratingCount;
  String? get address => _address;
  String? get priceLevel => _priceLevel;
  bool get savedAsFavorite => _savedAsFavorite;
  bool get isLoading => _isLoading;
  String get error => _error;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setRestaurantDetails({
    required String id,
    required String name,
    required String rating,
    required String ratingCount,
    required String address,
    required String priceLevel,
  }) {
    _restaurantId = id;
    _restaurantName = name;
    _rating = rating;
    _ratingCount = ratingCount;
    _address = address;
    _priceLevel = priceLevel;
    notifyListeners();
  }

  void setSavedAsFavorite(bool value) {
    _savedAsFavorite = value;
    notifyListeners();
  }

  Future<void> updateBrowseHistory({required String loggedinUserID}) async {
    if (_restaurantId == null) {
      _error = 'Restaurant ID is not set';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(_restaurantId)
          .set({
        'name': _restaurantName,
        'rating': _rating,
        'ratingCount': _ratingCount,
        'address': _address,
        'priceLevel': _priceLevel,
        'savedAsFavorite': _savedAsFavorite,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('Restaurant ID $_restaurantId has been saved to Firestore.');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to save restaurant ID: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBrowseHistory({required String loggedinUserID}) async {
    if (_restaurantId == null) {
      _error = 'Restaurant ID is not set';
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      await _firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(_restaurantId)
          .get();

      print('Restaurant ID $_restaurantId has been fetched from Firestore.');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch restaurant ID: $e';
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> checkFavoriteStatus(String userId) async {
    if (_restaurantId == null) {
      _error = 'Restaurant ID is not set';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('favoriteRestaurant')
          .doc(_restaurantId);
      
      final docSnapshot = await docRef.get();
      _savedAsFavorite = docSnapshot.exists;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to check favorite status: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}