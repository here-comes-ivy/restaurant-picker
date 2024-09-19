import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteFAB extends StatefulWidget {
  const FavoriteFAB({
    super.key,
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
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    _setupFavoriteStream();
  }

  void _setupFavoriteStream() {
    firestoreService
        .fetchFavoriteStatus(context,
      restaurantID: widget.restaurantID,
    )
        .listen((isFavorite) {
      setState(() {
        _isFavorite = isFavorite;
      });
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    final newStatus = !_isFavorite;

    setState(() {
      _isFavorite = newStatus;
    });

    try {
      await firestoreService.updateFavoriteList(
        context,
        restaurantID: widget.restaurantID,
        restaurantName: widget.restaurantName,
        rating: widget.restaurantRating,
        ratingCount: widget.restaurantRatingCount,
        address: widget.restaurantAddress,
        priceLevel: widget.restaurantPriceLevel,
        savedAsFavorite: newStatus,
        photoUrl: widget.photoUrl,
      );
    } catch (e) {
      setState(() {
        _isFavorite = !newStatus;
      });
      print('Failed to update favorite status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorite status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<bool>(
      stream: firestoreService.fetchFavoriteStatus(
        context, restaurantID: widget.restaurantID,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final isFavorite = snapshot.data ?? false;

        return FloatingActionButton(
          shape: const CircleBorder(),
          mini: true,
          elevation: 20,
          backgroundColor: isFavorite
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.secondaryContainer,
          onPressed: () => _toggleFavoriteStatus(),
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      },
    );
  }

}