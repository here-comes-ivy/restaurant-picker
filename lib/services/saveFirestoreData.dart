import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveFirestoreUser {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    Future<void> updateUserData(User user) async {
    final userRef = firestore.collection('users').doc(user.uid);
    
    await userRef.set({
      'email': user.email,
      'lastSignIn': FieldValue.serverTimestamp(),
      'name': user.displayName,
      // 可以添加更多字段，如 displayName, photoURL 等
    }, SetOptions(merge: true));
  }
}