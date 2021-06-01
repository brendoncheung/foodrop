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
            print("rebuilding Consumer <UserProfile>");
            // signInAnonymously if the user hasn't signed in yet.
            if (userProfile == null) {
              auth.signInAnonymous();
              print("Consumer<UserProfile> userProfile is null");
              print("signed in anonymously${auth.getUser()}");
            }

            // retrieve user info from firebase if user logged in
            // user is deemed to have logged in if user has UID and email
            // _updateUserProfile(userProfile);
            try {
              final authUser = auth.getUser();
              if (authUser.uid.isNotEmpty && authUser.email.isNotEmpty) {
                print("auth.user.email is not null");
                print("user profile email: ${userProfile.emailAddress}");
                print("user profile phone: ${userProfile.mobileNumber}");
                _updateUserProfile(authUser.uid);
              }
            } catch (e) {
              print(e);
            }

            final user = auth.getUser();

            return Provider<Database>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                child: ClientBottomNavigation());
          },
        );
      },
    );
  }

  void _updateUserProfile(String uid) async {
    try {
      final _userProfile =
          await FirestoreDatabase().userClientStream(uid).first;
      print(_userProfile);
      FirebaseAuth.instance.authStateChanges().map((user) => _userProfile);
    } catch (e) {
      print(e);
    }
  }
}
