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
  final _favoriteSubject = BehaviorSubject<bool>();

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    _setupFavoriteStream();
  }

  void _setupFavoriteStream() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String? loggedinUserID = userProvider.loggedinUserID;

    firestoreService
        .fetchFavoriteStatus(
      loggedinUserID: loggedinUserID,
      restaurantID: widget.restaurantID,
    )
        .listen((isFavorite) {
      _favoriteSubject.add(isFavorite);
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    final currentStatus = _favoriteSubject.valueOrNull ?? false;
    final newStatus = !currentStatus;

    _favoriteSubject.add(newStatus);

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
      // If update fails, revert the UI
      _favoriteSubject.add(currentStatus);
      print('Failed to update favorite status: $e');
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorite status')),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _favoriteSubject.stream,
      builder: (context, snapshot) {
        final isFavorited = snapshot.data ?? false;
        return FloatingActionButton(
          shape: const CircleBorder(),
          mini: true,
          elevation: 20,
          backgroundColor: isFavorited
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.secondaryContainer,
          onPressed: _toggleFavoriteStatus,
          child: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _favoriteSubject.close();
    super.dispose();
  }
}