import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:foodrop/screens/authentication/_email_sign_in_screen.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../vendor/vendor_bottom_navigation.dart';
import '_sign_in_screen_new.dart';

class AuthenticationFlowWrapper extends StatelessWidget {
  static String ROUTE_NAME = "/authentication-wrapper";

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context);

    return StreamProvider<UserClient>.value(
      catchError: (context, error) {
        print(error.toString());
        return null;
      },
      value: auth.onAuthChangeStream(),
      builder: (context, child) {
        return Consumer<UserClient>(
          builder: (_, userClient, child) {
            return userClient == null ? SignInScreenNew() : ClientBottomNavigation();
          },
        );
      },
    );
  }
}
