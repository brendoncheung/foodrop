import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/client/client_bottom_navigation.dart';
import 'package:provider/provider.dart';

class AuthenticationFlowWrapper extends StatelessWidget {
  static String ROUTE_NAME = "/authentication-wrapper";

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context, listen: false);
    print("building AuthenticationFlowWrapper");
    return StreamProvider<UserProfile>.value(
      catchError: (context, error) {
        print(error.toString());
        return null;
      },
      value: auth.onAuthChangeStream(),
      builder: (context, child) {
        return Consumer<UserProfile>(
          builder: (_, userProfile, child) {
            // signInAnonymously if the user hasn't signed in yet.
            if (userProfile == null) {
              auth.signInAnonymous();
              print("signed in anonymously${auth.getUser()}");
            }

            // retrieve user info from firebase if user logged in
            // user is deemed to have logged in if user has UID and email
            _updateUserProfile(userProfile);
            // else {
            //
            print("OOOOOO verified user ${auth.getUser()} OOOOOO");
            // }

            final user = auth.getUser();

            return Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                child: ClientBottomNavigation());
          },
        );
      },
    );
  }

  void _updateUserProfile(UserProfile userProfile) async {
    if (userProfile.uid.isNotEmpty && userProfile.emailAddress.isNotEmpty) {
      final _userProfile = await FirestoreDatabase().userClientStream().first;
      FirebaseAuth.instance.authStateChanges().map((user) => _userProfile);
    }
  }
}
