
import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/firestoreService.dart';

class FavoriteFAB extends StatefulWidget {
  FavoriteFAB({
    required this.restaurantID,
    required this.restaurantName,
    required this.restaurantRating,
    required this.restaurantRatingCount,
    required this.restaurantAddress,
    required this.restaurantPriceLevel,
    required this.photoUrl,
  });
  final String restaurantID;
  final String restaurantName;
  final double restaurantRating;
  final int restaurantRatingCount;
  final String restaurantAddress;
  final String restaurantPriceLevel;
  final String photoUrl;

  @override
  FavoriteFABState createState() => FavoriteFABState();
}

class FavoriteFABState extends State<FavoriteFAB> {
  late FirestoreService firestoreService;
  bool _isFavorited = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    _loadInitialFavoriteStatus();
  }

  Future<void> _loadInitialFavoriteStatus() async {
    try {
      bool status = await firestoreService.fetchFavoriteStatus(
        context,
        restaurantID: widget.restaurantID,
      ).first;
      if (mounted) {
        setState(() {
          _isFavorited = status;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading initial favorite status: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleFavoriteStatus() {
    if (!mounted) return;

    // 立即更新 UI
    setState(() {
      _isFavorited = !_isFavorited;
    });

    // 在背景更新 Firestore
    _updateFirestore();
  }

  Future<void> _updateFirestore() async {
    try {
      await firestoreService.updateFavoriteList(
        context,
        restaurantID: widget.restaurantID,
        restaurantName: widget.restaurantName,
        rating: widget.restaurantRating,
        ratingCount: widget.restaurantRatingCount,
        address: widget.restaurantAddress,
        priceLevel: widget.restaurantPriceLevel,
        savedAsFavorite: _isFavorited,
        photoUrl: widget.photoUrl,
      );
      print('Firestore updated successfully');
    } catch (e) {
      print('Failed to update Firestore: $e');
      // 如果更新失敗，恢復 UI 狀態
      if (mounted) {
        setState(() {
          _isFavorited = !_isFavorited;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favorite status')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      mini: true,
      elevation: 20,
      backgroundColor: _isFavorited
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      onPressed: _isLoading ? null : _toggleFavoriteStatus,
      child: _isLoading
          ? CircularProgressIndicator()
          : Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
    );
  }
}