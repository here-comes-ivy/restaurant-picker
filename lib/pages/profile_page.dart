import 'package:flutter/material.dart';
import '../utils/cardStyles.dart';
import '../components/profilePage/cardslider.dart';
import '../utils/decorationStyles.dart';
import '../components/profilePage/paymentGrid.dart';
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
    String userName = (userProvider.name ?? '').isEmpty ? 'Anonymous User' : userProvider.name!;
    String userEmail = (userProvider.email ?? '').isEmpty ? 'No email' : userProvider.email!;

    return Scaffold(
      appBar: AppBar(
        actions:[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              FireStoreUser.clearUser();
            },
          ),
        ],),
      //drawer: profileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: <Widget>[
              ProfileUserData(userName: userName, userEmail: userEmail),
              ProfileTitle(text: 'Recommended'),
              SliverToBoxAdapter(child: CardSlider(),),
              ProfileTitle(text: 'Browse History'),
              SliverFixedExtentList(
                itemExtent: 100.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return RestaurantCard(
                      cardChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('List Item ${index + 1}'),
                          Text('Details of Item${index + 1}'),
                        ],
                      ),
                    );
                  },
                  childCount: 5, // 設置列表項目數量
                ),
              ),
              ProfileTitle(text: 'Support Us'),
              PaymentGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileUserData extends StatelessWidget {
  const ProfileUserData({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                Icons.account_circle,
              ),
              backgroundColor: Colors.white,
              radius: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(userEmail),
              ],
            ),
          ],
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
