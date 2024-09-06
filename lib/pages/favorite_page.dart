import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_picker/services/firestoreService.dart';
import 'package:restaurant_picker/services/userDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_picker/utils/cardStyles.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';
import '../components/favoritePage/editAndDeleteDialog.dart';
import '../components/favoritePage/personalList.dart';
import '../components/favoritePage/favoriteItems.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String? loggedinUserID = userProvider.loggedinUserID;
    if (loggedinUserID == null) {
      return Center(
          child: Text(
              'You need to be logged in to view your favorite restaurants.'));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recently Added',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FavoriteRestaurantsItems(loggedinUserID: loggedinUserID),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Divider(),
              ),
              Text('Favorite Lists',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              PersonalFavoriteList(),
            ],
          ),
        ),
      ),
    );
  }
}
