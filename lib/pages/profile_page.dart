import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key}); 

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      //drawer: profileDrawer(),
      body: CustomScrollView(
        slivers:  <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true, // 可選
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Profile Page'),
              background: Image.asset(
                'assets/slide_4.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item $index',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'This is some additional information for item $index.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  );
              },
              childCount: 10, // 示例中的項目數量
            ),
          ),
        ],

      ),
    );
  }
}
