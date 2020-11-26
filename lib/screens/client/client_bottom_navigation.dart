import 'package:flutter/material.dart';

class ClientBottomNavigation extends StatefulWidget {
  void Function(int) onTap;

  ClientBottomNavigation({this.onTap});

  @override
  _ClientBottomNavigationState createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        widget.onTap(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "Gift"),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
      ],
    );
  }
}
