import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:provider/provider.dart';

class AuthenticationFlowWrapper extends StatelessWidget {
  static String ROUTE_NAME = "/authentication-wrapper";

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context, listen: false);
    print("building AuthenticationFlowWrapper");
    return StreamProvider<UserClient>.value(
      catchError: (context, error) {
        print(error.toString());
        return null;
      },
      value: auth.onAuthChangeStream(),
      builder: (context, child) {
        return Consumer<UserClient>(
          builder: (_, userClient, child) {
            if (userClient == null) {
              // signInAnonymously if the user hasn't signed in yet.
              auth.signInAnonymous();
            }
            final user = auth.getUser();

            try {
              if (user.email != null) {
                print(
                    "user signed in =========================> ${user.email}");
                //TODO: retrieve user info.
                // Create UserClient instance
              }
            } catch (e) {
              print("User is Anonymous xxxxxxxxxxxxxxxxxxxxxxx");
            }

            // print("rebuild authentication flow ");
            // print("uid: ${userClient.uid}, email: ${userClient.emailAddress}");

            return ClientBottomNavigation();
          },
        );
      },
    );
  }
}
