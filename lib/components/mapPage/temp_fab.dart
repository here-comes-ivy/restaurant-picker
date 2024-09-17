import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteFAB extends StatefulWidget {
  const FavoriteFAB({super.key, 
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
  late Stream<bool> favoriteStream;
  final _favoriteSubject = BehaviorSubject<bool>();
  late ValueNotifier<bool> _favoriteNotifier;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService();
    _setupFavoriteStream();
    _favoriteNotifier = ValueNotifier<bool>(false);
  }

  void _setupFavoriteStream() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String? loggedinUserID = userProvider.loggedinUserID;
    favoriteStream = firestoreService.fetchFavoriteStatus(
      loggedinUserID: loggedinUserID,
      restaurantID: widget.restaurantID,
    );

    _favoriteSubject
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((isFavorite) {
      _updateFavoriteStatus(isFavorite);
      _favoriteNotifier.value = isFavorite;
    });

    favoriteStream.listen((isFavorite) {
      _favoriteSubject.add(isFavorite);
    });
  }

  Future<void> _updateFavoriteStatus(bool isFavorite) async {
    try {
      await firestoreService.updateFavoriteList(
        context,
        restaurantID: widget.restaurantID,
        restaurantName: widget.restaurantName,
        rating: widget.restaurantRating,
        ratingCount: widget.restaurantRatingCount,
        address: widget.restaurantAddress,
        priceLevel: widget.restaurantPriceLevel,
        savedAsFavorite: isFavorite,
        photoUrl: widget.photoUrl,
      );
    } catch (e) {
      print('Failed to update favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _favoriteNotifier,
      builder: (context, isFavorited, child) {
        return FloatingActionButton(
          shape: const CircleBorder(),
          mini: true,
          elevation: 20,
          backgroundColor: isFavorited
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.secondaryContainer,
          onPressed: () async {
            _favoriteSubject.add(!isFavorited);
          },
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
    _favoriteNotifier.dispose();
    super.dispose();
  }
}