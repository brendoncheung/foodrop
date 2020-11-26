import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:foodrop/screens/client/theme/client_theme_data.dart';
import 'package:foodrop/screens/vendor/business/tabs/vendor_business_overview_today.dart';
import 'package:foodrop/screens/vendor/order/vendor_order_screen.dart';
import 'package:foodrop/screens/vendor/promotion/vendor_promotion_screen.dart';
import 'package:foodrop/screens/vendor/rewards/vendor_rewards_screen.dart';
import 'package:foodrop/screens/vendor/theme/vendor_theme_data.dart';

import 'package:foodrop/screens/vendor/vendor_bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FoodropRoot());
}

class FoodropRoot extends StatefulWidget {
  @override
  _FoodropRootState createState() => _FoodropRootState();
}

class _FoodropRootState extends State<FoodropRoot> {
  var isVendorMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: isVendorMode ? VendorBottomNavigation() : ClientBottomNavigation(),
        theme: isVendorMode ? VendorThemeData.themeData : ClientThemeData.themeData);
  }
}
