import "package:flutter/material.dart";

import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:foodrop/screens/client/theme/client_theme_data.dart';
import 'package:foodrop/screens/vendor/business/tabs/vendor_business_overview_tab_screen.dart';
import 'package:foodrop/screens/vendor/business/tabs/vendor_business_overview_today.dart';
import 'package:foodrop/screens/vendor/order/vendor_order_screen.dart';
import 'package:foodrop/screens/vendor/promotion/vendor_promotion_screen.dart';
import 'package:foodrop/screens/vendor/rewards/vendor_rewards_screen.dart';
import 'package:foodrop/screens/vendor/theme/vendor_theme_data.dart';

class VendorBottomNavigation extends StatefulWidget {
  void Function(int) onTap;

  VendorBottomNavigation({this.onTap});

  @override
  _VendorBottomNavigationState createState() => _VendorBottomNavigationState();
}

class _VendorBottomNavigationState extends State<VendorBottomNavigation> {
  var _selectedIndex = 0;

  final _vendorBottomNavigationScreens = [
    VendorBusinessTabScreen(),
    VendorPromotionScreen(),
    VendorRewardScreen(),
    VendorOrderScreen(),
  ];

  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vendorBottomNavigationScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onTapHandler,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Promotions"),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Rewards"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Orders"),
        ],
      ),
    );
  }
}
