import 'package:flutter/material.dart';
import 'map_page.dart';
//import 'chat_page.dart';
import 'chat_test_page.dart';
import 'profile_page.dart';
import 'favorite_page.dart';




class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const MapPage(),
    FavoritePage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Shuffle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quickreply),
            label: 'Chat with AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
