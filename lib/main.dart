import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/_sign_up_screen.dart';
import 'package:foodrop/screens/authentication/authentication_flow_wrapper.dart';
import 'package:foodrop/screens/client/home/detail/detail_item_screen.dart';
import 'package:foodrop/screens/error/unknown_route_screen.dart';
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
