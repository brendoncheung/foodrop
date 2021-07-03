import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/screens/authentication/sign_in_page.dart';
import 'package:foodrop/screens/user/profile/profile_home_screen.dart';
import 'package:provider/provider.dart';

class ProfileLandingScreen extends StatefulWidget {
  @override
  _ProfileLandingScreenState createState() => _ProfileLandingScreenState();
}

class _ProfileLandingScreenState extends State<ProfileLandingScreen> {
  var _userLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    print("build clientBottomNavigation ");

    _onUserStateChanges(_getCurrentUser(context));

    return _userLoggedIn
        ? Consumer<UserProfile>(builder: (_, userProfile, __) {
            print("this is the profile ${userProfile}");
            return ProfileHomeScreen(
              userProfile: userProfile,
              //onLoggedIn: () => _onLoggedIn(context),
            );
          })
        : SignInPage(
            //onLoggedIn: () => _onLoggedIn(context),
            );

    // return Consumer<UserProfile>(
    //   builder: (_, userProfile, __) {
    //     if (userProfile != null) {
    //       return ClientProfileScreen(
    //         onLoggedIn: () => _onLoggedIn(context),
    //       );
    //     }
    //     return SignInPage(
    //       onLoggedIn: () => _onLoggedIn(context),
    //     );
    //   },
    // );
  }

  User _getCurrentUser(BuildContext context) {
    try {
      final auth = Provider.of<AuthenticationService>(context);
      final _user = auth.getUser();
      return _user;
    } catch (e) {
      return null;
    }
  }

  void _onUserStateChanges(User _user) {
    try {
      if (_user.email != null && _user.email.isNotEmpty) {
        setState(() {
          _userLoggedIn = true;
        });
      } else {
        print("xxxxx Profile Landing Page - user not logged in xxxxxx");
      }
    } catch (e) {
      print(e);
    }
  }

  // void _onLoggedIn(BuildContext context) {
  //   print(
  //       "Triggered voidcall back on sign in / logout --------------------------");
  // setState(() {});
  // }
}
