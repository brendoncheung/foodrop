import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:foodrop/core/repositories/vendor/vendor_menu_item_repository.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:foodrop/screens/client/theme/client_theme_data.dart';
import 'package:foodrop/screens/error/unknown_route_screen.dart';
import 'package:foodrop/screens/vendor/settings/add_menu_items/vendor_add_edit_menu_items_screen.dart';
import 'package:foodrop/screens/vendor/theme/vendor_theme_data.dart';

import 'package:foodrop/screens/vendor/vendor_bottom_navigation.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [Provider(create: (_) => VendorMenuItemRepository())],
      child: MaterialApp(
        home: isVendorMode ? VendorBottomNavigation() : ClientBottomNavigation(),
        theme: isVendorMode ? VendorThemeData.themeData : ClientThemeData.themeData,
        routes: {
          VendorAddEditMenuItemsScreen.ROUTE_NAME: (_) => VendorAddEditMenuItemsScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (_) => UnknownRouteScreen(
                    routeInfo: settings.name,
                  ));
        },
      ),
    );
  }
}
