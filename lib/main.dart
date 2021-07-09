import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'core/authentication/authentication_service.dart';
import 'screens/authentication/_sign_up_screen.dart';
import 'screens/authentication/authentication_flow_wrapper.dart';

import 'package:provider/provider.dart';

void main() async {
  // you have to call this because firebase calls native code to configure firebase:
  // https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-d
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  debugPaintSizeEnabled = false;
  runApp(FoodropRoot());
}

class FoodropRoot extends StatefulWidget {
  @override
  _FoodropRootState createState() => _FoodropRootState();
}

class _FoodropRootState extends State<FoodropRoot> {
  // var isVendorMode = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseFirestore.instance),
        Provider(create: (_) => AuthenticationService()),
      ],
      child: MaterialApp(
        theme: new ThemeData(
            // scaffoldBackgroundColor: Colors.grey[900],

            appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
            backgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: AuthenticationFlowWrapper(),
        routes: {
          SignUpScreen.ROUTE_NAME: (_) => SignUpScreen(),
        },
      ),
    );
  }
}
