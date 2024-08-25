import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FireStoreUser {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? _user;
  static String? _displayName;
  static String? _email;
  static String? _uid;

  static Future<void> initUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      _displayName = _user!.displayName;
      _email = _user!.email;
      _uid = _user!.uid;
    }
  }

  static void clearUser() {
    _user = null;
    _displayName = null;
    _email = null;
    _uid = null;
  }

  static String? get userName => _displayName;
  static String? get userEmail => _email;
  static String? get userId => _uid;


}


class FireStoreFavorite {
  final _firestore = FirebaseFirestore.instance;

  // 添加收藏地點
  Future<void> addFavoritePlace(String userId, Map<String, dynamic> placeData) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('places')
        .doc(placeData['id'])
        .set({
      'name': placeData['name'],
      'address': placeData['address'],
      'latitude': placeData['latitude'],
      'longitude': placeData['longitude'],
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // 獲取用戶的所有收藏地點
  Stream<QuerySnapshot> getFavoritePlaces(String userId) {
    return _firestore
        .collection('favorites')
        .doc(userId)
        .collection('places')
        .snapshots();
  }

  // 刪除收藏地點
  Future<void> removeFavoritePlace(String userId, String placeId) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('places')
        .doc(placeId)
        .delete();
  }
}