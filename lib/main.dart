import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/repositories/vendor/vendor_menu_item_repository.dart';
import 'package:foodrop/core/services/firestore_service.dart';
import 'package:foodrop/screens/authentication/_sign_up_screen.dart';
import 'package:foodrop/screens/authentication/authentication_flow_wrapper.dart';
import 'package:foodrop/screens/client/theme/client_theme_data.dart';
import 'package:foodrop/screens/error/unknown_route_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/rendering.dart';

void main() async {
  // you have to call this because firebase calls native code to configure firebase:
  // https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-d
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  debugPaintSizeEnabled = false;

  // connect authentication emulator
  // try {
  //   String host = Platform.isAndroid ? '10.0.2.2:8080' : ' :8080';
  //   FirebaseFirestore.instance.settings =
  //       Settings(host: host, sslEnabled: false, persistenceEnabled: false);
  //   await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  // } catch (e) {
  //   print("unable to connect and use emulator");
  // }

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
      providers: [
        Provider(create: (_) => VendorMenuItemRepository()),
        Provider(create: (_) => AuthenticationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticationFlowWrapper(),
        routes: {
          SignUpScreen.ROUTE_NAME: (_) => SignUpScreen(),
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
