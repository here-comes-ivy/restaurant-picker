import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'userDataProvider.dart';

class FirestoreService  {
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

  Future<void> updateFavoriteList(context,{
    required String? restaurantID,
    required String? restaurantName,
    required double? rating,
    required int? ratingCount,
    required String? address,
    required String? priceLevel,
    required String? photoUrl,
    required bool savedAsFavorite,
  }) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    String? loggedinUserID = userProvider.loggedinUserID ;

    try {
      await firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(restaurantID)
          .set({
        'name': restaurantName,
        'rating': rating,
        'ratingCount': ratingCount,
        'address': address,
        'priceLevel': (priceLevel != '')? priceLevel: 'N/A',
        'savedAsFavorite': savedAsFavorite,
        'photoUrl': photoUrl,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Restaurant ID $restaurantID has been saved to Firestore with savedAsFavorite status set to $savedAsFavorite' );
      print(photoUrl);
    } catch (e) {
      print('Failed to save restaurant ID: $e');
    }
  }

 Future<void> updateFavoriteStatus(BuildContext context, {required bool savedAsFavorite,required String? restaurantID}) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    String? loggedinUserID = userProvider.loggedinUserID ;
    String? restaurantID;
    bool? savedAsFavorite;

    try {
      await firestore
          .collection('users')
          .doc(loggedinUserID)
          .collection('favoriteRestaurant')
          .doc(restaurantID)
          .set({
        'savedAsFavorite': savedAsFavorite,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Favorite status of Restaurant ID $restaurantID has been updated to Firestore.');
    } catch (e) {
      print('Failed to update favorite status: $e');
    }
  }


Future<List<Map<String, dynamic>>> fetchFavoriteRestaurants(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String? loggedinUserID = userProvider.loggedinUserID;
  
  if (loggedinUserID == null) {
    print('User ID is null');
    return [];
  }

  try {
    final querySnapshot = await firestore
        .collection('users')
        .doc(loggedinUserID)
        .collection('favoriteRestaurant')
        .where('savedAsFavorite', isEqualTo: true)
        .get();

return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id; 
        return data;
      }).toList();
      
  } catch (e) {
    print('Error fetching favorite restaurants: $e');
    return [];
  }
}


  Stream<bool> fetchFavoriteStatus(BuildContext context,{
    required String? restaurantID,
  }) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String? loggedinUserID = userProvider.loggedinUserID;

    return firestore
        .collection('users')
        .doc(loggedinUserID)
        .collection('favoriteRestaurant')
        .doc(restaurantID)
        .snapshots()
        .map((doc) => doc.exists && doc.data()?['savedAsFavorite'] == true);
  }

}
