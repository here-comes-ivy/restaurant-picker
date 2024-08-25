import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'landing_page.dart';
import '../services/saveFirestoreData.dart';

class AuthGate extends StatelessWidget {
  final String clientId = '311208916992-sennaidp9rigi5nmngpljm8doqe6odeb.apps.googleusercontent.com';

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

  final currentUser = auth.currentUser;
  print("Current user: $currentUser");

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: clientId),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/app_icon.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to WhatsForDinner, please sign in!')
                    : const Text('Welcome to WhatsForDinner, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'By signing in, you agree to our terms and conditions.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Continue without signing in'),
                    onPressed: () async {
                      try {
                        await auth.signInAnonymously();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    },
                  ),
                ],
              );
            },
            // 添加 actions 參數來處理身份驗證事件
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                if (state.user != null) {
                  SaveFirestoreUser().updateUserData(state.user!);
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (state.credential.user != null) {
                  SaveFirestoreUser().updateUserData(state.credential.user!);
                }
              }),
            ],
          );
        }
        return const LandingPage();
      },
    );
  }
}