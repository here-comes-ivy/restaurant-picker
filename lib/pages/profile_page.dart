import 'package:flutter/material.dart';
import '../components/reusableCard.dart';
import '../components/cardslider.dart';
import '../utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List emoji = ["🍩", "☕", "🧋", "🍺"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: profileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
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
                            'User Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text('UserID'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'Recommended',
                  style: kProfileTitleStyle,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CardSlider(),
                  ),
                ),
              SliverToBoxAdapter(
                child: Text(
                  'Browse History',
                  style: kProfileTitleStyle,
                ),
              ),
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
              SliverToBoxAdapter(
                child: Text(
                  'Support Us',
                  style: kProfileTitleStyle,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      color: Colors.deepOrange[100 * (index+1 % 9)],
                      child: Center(
                        child: Text('Buy me a ${emoji[index]}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    );
                  },
                  childCount: 4, // 設置網格項目數量
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
