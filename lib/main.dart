import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/authentication/cloud_function_testing.dart';
import 'package:foodrop/core/repositories/vendor/vendor_menu_item_repository.dart';
import 'package:foodrop/screens/authentication/_client_sign_up_screen.dart';
import 'package:foodrop/screens/authentication/wrapper.dart';
import 'package:foodrop/screens/client/theme/client_theme_data.dart';
import 'package:foodrop/screens/error/unknown_route_screen.dart';
import 'package:foodrop/screens/vendor/settings/vendor_add_menu_items_screen.dart';
import 'package:foodrop/screens/vendor/theme/vendor_theme_data.dart';

import 'package:provider/provider.dart';

void main() async {
  // you have to call this because firebase calls native code to configure firebase:
  // https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-d
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp fba = await Firebase.initializeApp();

  runApp(FoodropRoot());
}

class FoodropRoot extends StatefulWidget {
  @override
  _FoodropRootState createState() => _FoodropRootState();
}

class _FoodropRootState extends State<FoodropRoot> {
  var isVendorMode = true;

  var a = TestingFirebaseFunctions();

  @override
  Widget build(BuildContext context) {
    a.callable();
    print("context: ${context.hashCode}");
    return MultiProvider(
      providers: [
        Provider(create: (_) => VendorMenuItemRepository()),
        Provider(create: (_) => AuthenticationService()),
      ],
      child: MaterialApp(
        home: AuthenticationFlowScreenWrapper(),
        theme: isVendorMode ? VendorThemeData.themeData : ClientThemeData.themeData,
        routes: {
          VendorAddMenuItemsScreen.ROUTE_NAME: (_) => VendorAddMenuItemsScreen(),
          ClientSignUpScreen.ROUTE_NAME: (_) => ClientSignUpScreen(),
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

// var fs = FirebaseFirestore.instance.collection('/restaurants').doc('/ewP3B6XWNyqjM98GYYaq').collection('/reviews').snapshots();

// fs.listen((querySnapshot) {
//   querySnapshot.docs.forEach((queryDocumentSnapshot) {
//     print("looooooading");
//     print(queryDocumentSnapshot.data()['comment']);
//   });
// });
