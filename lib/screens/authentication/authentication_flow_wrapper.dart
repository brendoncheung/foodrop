import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/user/client_bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'logout_await_screen.dart';

class AuthenticationFlowWrapper extends StatelessWidget {
  static String ROUTE_NAME = "/authentication-wrapper";
  var errorDetected = false;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context, listen: false);

    return StreamProvider<UserProfile>.value(
      catchError: (context, error) {
        return null;
      },
      value: auth.onAuthChangeStream(),
      builder: (context, child) {
        return Consumer<UserProfile>(
          builder: (_, userProfile, child) {
            errorDetected = false;
            final user = auth.getUser();

            try {
              if (userProfile == null) {
                auth.signInAnonymous();
              }

              if (user.uid.isNotEmpty && user.email.isNotEmpty) {
                _updateUserProfile(user.uid);
                print(userProfile.isAnonymous);
              }
            } catch (e) {
              print(e);
            }

            try {} catch (e) {
              // show logoutAwaitScreen

              errorDetected = true;
            }

            return errorDetected
                ? LogoutAwaitScreen()
                : Provider<Database>(
                    create: (_) => FirestoreDatabase(uid: user.uid),
                    child: Consumer<Database>(
                      builder: (_, db, __) => ClientBottomNavigation.create(context, db),
                    ),
                  );
          },
        );
      },
    );
  }

  void _updateUserProfile(String uid) async {
    try {
      final _userProfile = await FirestoreDatabase().userClientStream(uid).first;
      print(_userProfile);
      FirebaseAuth.instance.authStateChanges().map((user) => _userProfile);
    } catch (e) {
      print(e);
    }
  }
}
