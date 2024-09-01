import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  // Firebase 用户实例
  User? loggedinUser;

  String? loggedinUserName;
  String? loggedinUserEmail;
  String? loggedinUserID;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }


  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      loggedinUser = firebaseUser;
      loggedinUserName = firebaseUser.displayName ?? "No name"; 
      loggedinUserEmail = firebaseUser.email;
      loggedinUserID = firebaseUser.uid;
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
}
