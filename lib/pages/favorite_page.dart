import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import '../components/favoritePage/favoriteItems.dart';
import '../components/mapPage/spinner_spinbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FirestoreService firestoreService = FirestoreService();


  @override
  Widget build(BuildContext context) {
    final Future<List<Map<String, dynamic>>>dataFuture =
        firestoreService.fetchFavoriteRestaurants(context);
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String? loggedinUserID = userProvider.loggedinUserID;

    if (loggedinUserID == null) {
      return const Center(
          child: Text(
              'You need to be logged in to view your favorite restaurants.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: dataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No favorite restaurants found.'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Recently Added',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            FavoriteRestaurantsItems(),
                            
                            // Text('Favorite Lists',
                            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            // PersonalFavoriteList(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Center(child: SpinButton(dataFuture: dataFuture)),
            ],
          ),
        ),
      ),
    );
  }
}
