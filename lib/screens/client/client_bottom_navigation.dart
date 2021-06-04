import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/screens/client/favourite/client_favourite_screen.dart';
import 'package:foodrop/screens/client/gift/client_gift_screen.dart';
import 'package:foodrop/screens/client/home/client_home_screen.dart';
import 'package:foodrop/screens/client/orders/client_order_screen.dart';
import 'package:provider/provider.dart';

class ClientBottomNavigation extends StatefulWidget {
  // void Function(int) onTap;
  // ClientBottomNavigation({this.onTap});

  @override
  _ClientBottomNavigationState createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  var _selectedIndex = 0;

  final _clientBottomNavigationScreens = [
    ClientHomeScreen(),
    ClientFavouriteScreen(),
    ClientGiftScreen(),
    ClientOrderScreen(),
    // ClientProfileScreen(),
  ];

  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _clientBottomNavigationScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.comment_rounded, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded, size: 35), label: ""),
        ],
      ),
    );
  }
}
