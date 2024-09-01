import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'userDataProvider.dart';

class SaveFirestoreUser {
  final firestore = FirebaseFirestore.instance;

  // 方法接收 BuildContext 以获取 UserProvider
  Future<void> updateUserData(BuildContext context) async {
    // 从 Provider 获取 UserProvider 实例
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // 确保 userID 和 email 不为空
    if (userProvider.loggedinUserID != null && userProvider.loggedinUserEmail != null) {
      final userRef = firestore.collection('users').doc(userProvider.loggedinUserID);

      await userRef.set({
        'email': userProvider.loggedinUserEmail,
        'lastSignIn': FieldValue.serverTimestamp(),
        'name': userProvider.loggedinUserName ?? '', 
      }, SetOptions(merge: true));
    } else {
      print('User ID or email is null');
    }
  }
}
