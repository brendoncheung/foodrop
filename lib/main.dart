import 'package:flutter/material.dart';
import 'package:foodrop/core/services/authentication/authenication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodrop/pages/wrapper.dart';

import 'package:provider/provider.dart';

import 'package:foodrop/core/models/user.dart';

// TODO: find out how provider package can DI your services

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FoodropRoot());
}

class FoodropRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return StreamProvider<User>.value(
      catchError: (context, error) {
        print("StreamBuilder $error");
      },
      value: AuthenticationService().currentUser,
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Wrapper(),
        ),
      ),
    );
  }
}
