import 'package:flutter/material.dart';
import '../utils/cardStyles.dart';
import '../components/profilePage/cardslider.dart';
import '../utils/decorationStyles.dart';
import '../components/profilePage/paymentGrid.dart';
import '../components/profilePage/favoriteList.dart';
import '../components/profilePage/profileUserDetails.dart';

import 'auth_gate.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../services/getFirestoreData.dart';
import '../services/userDataProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    FireStoreUser.initUser();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    String userName = (userProvider.loggedinUserName ?? '').isEmpty
        ? 'Anonymous User'
        : userProvider.loggedinUserName!;
    String userEmail = (userProvider.loggedinUserEmail ?? '').isEmpty
        ? 'No email'
        : userProvider.loggedinUserEmail!;
    String userPhoto = (userProvider.loggedinUserPhoto ?? '').isEmpty
        ? 'No Photo'
        : userProvider.loggedinUserPhoto!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              FireStoreUser.clearUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
          ),
        ],
      ),
      //drawer: profileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: <Widget>[
              ProfileUserData(userName: userName, userEmail: userEmail, userPhoto: userPhoto),
              ProfileTitle(text: 'Recommended'),
              SliverToBoxAdapter(
                child: CardSlider(),
              ),
              ProfileTitle(text: 'Browse History'),
              FavoritedList(),
              ProfileTitle(text: 'Support Us'),
              PaymentGrid(),
            ],
          ),
        ),
      ),
    );
  }
}



class ProfileTitle extends StatelessWidget {
  ProfileTitle({required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: kProfileTitleStyle,
        ),
      ),
    );
  }
}
