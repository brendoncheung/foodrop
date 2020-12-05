import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:foodrop/screens/authentication/_sign_in_screen.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:provider/provider.dart';

class AuthenticationFlowScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var client_auth = Provider.of<AuthenticationService>(context);

    return StreamProvider<UserClient>.value(
      catchError: (context, error) {
        print(error.toString());
        return null;
      },
      value: client_auth.onAuthChangeStream(),
      builder: (context, child) {
        return Consumer<UserClient>(
          builder: (_, userClient, child) {
            print("wrapper");
            userClient == null ? print("user is null") : print("user is not null");
            return userClient == null ? SignInScreen() : ClientBottomNavigation();
          },
        );
      },
    );
  }
}
