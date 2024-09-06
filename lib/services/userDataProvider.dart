import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {

  User? loggedinUser;
  String? loggedinUserName;
  String? loggedinUserEmail;
  String? loggedinUserID;
  String? loggedinUserPhoto;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen(onAuthStateChanged);
  }


  void onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      loggedinUser = firebaseUser;
      loggedinUserName = firebaseUser.displayName ?? "No name"; 
      loggedinUserEmail = firebaseUser.email;
      loggedinUserID = firebaseUser.uid;
      loggedinUserPhoto = firebaseUser.photoURL?.toString()?? null;
    } else {
      loggedinUser = null;
      loggedinUserName = null;
      loggedinUserEmail = null;
      loggedinUserID = null;
    }
    notifyListeners();
  }

  Future<void> updateName(String newName) async {
    if (loggedinUser != null) {
      await loggedinUser!.updateDisplayName(newName);
      loggedinUserName = newName;
      notifyListeners();
    }
  }


  Future<void> updateEmail(String newEmail) async {
    if (loggedinUser != null) {
      await loggedinUser!.verifyBeforeUpdateEmail(newEmail);
      loggedinUserEmail = newEmail;
      notifyListeners();
    }
  }

    Future<void> updatePhotoUrl(String newPhoto) async {
    if (loggedinUser != null) {
      await loggedinUser!.verifyBeforeUpdateEmail(newPhoto);
      loggedinUserPhoto = newPhoto;
      notifyListeners();
    }
  }
}
