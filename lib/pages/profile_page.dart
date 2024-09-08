import 'package:flutter/material.dart';
import '../utils/cardStyles.dart';
import '../components/profilePage/cardslider.dart';
import '../utils/decorationStyles.dart';
import '../components/profilePage/paymentGrid.dart';
import '../components/profilePage/featuresToUnlockList.dart';
import '../components/profilePage/profileUserDetails.dart';
import 'auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/getFirestoreData.dart';
import '../services/userDataProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    await FireStoreUser.initUser();
    setState(() {
      _isLoading = false;
    });
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
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: ProfileUserData(
                        userName: userName,
                        userEmail: userEmail,
                        userPhoto: userPhoto),
                  ),
                  SliverToBoxAdapter(
                    child: ProfileTitle(text: 'Recommended'),
                  ),
                  SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CardSlider(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProfileTitle(text: 'Features To Unlock'),
                  ),
                  // SliverToBoxAdapter(
                  //   child: FeaturesToUnlock(),
                  // ),
                  SliverToBoxAdapter(
                    child: ProfileTitle(text: 'Support Us'),
                  ),
                  SliverToBoxAdapter(
                    child: PaymentGrid(),
                  ),
                ],
              ),
      ),
    );
  }
}

class ProfileTitle extends StatelessWidget {
  ProfileTitle({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: kProfileTitleStyle,
      ),
    );
  }
}
