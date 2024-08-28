import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  // Firebase 用户实例
  User? _firebaseUser;

  String? _name;
  String? _email;
  String? _userID;

  UserProvider() {
    // 监听 Firebase Authentication 状态的变化
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  String? get name => _name;
  String? get email => _email;
  String? get userID => _userID;

  void _onAuthStateChanged(User? firebaseUser) {
    if (firebaseUser != null) {
      _firebaseUser = firebaseUser;
      _name = firebaseUser.displayName ?? "No name"; // 如果 displayName 是 null，则使用默认值
      _email = firebaseUser.email;
      _userID = firebaseUser.uid;
    } else {
      _firebaseUser = null;
      _name = null;
      _email = null;
      _userID = null;
    }
    notifyListeners();
  }

  // 更新用户的名称
  Future<void> updateName(String newName) async {
    if (_firebaseUser != null) {
      await _firebaseUser!.updateDisplayName(newName);
      _name = newName;
      notifyListeners();
    }
  }

  // 更新用户的电子邮件
  Future<void> updateEmail(String newEmail) async {
    if (_firebaseUser != null) {
      await _firebaseUser!.updateEmail(newEmail);
      _email = newEmail;
      notifyListeners();
    }
  }
}
