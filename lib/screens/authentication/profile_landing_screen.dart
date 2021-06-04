import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/screens/authentication/sign_in_page.dart';
import 'package:foodrop/screens/client/profile/client_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileLandingScreen extends StatelessWidget {
  var _userLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProfile>(context);
    print("build clientBottomNavigation ");
    print("user id is: ${user.uid}");
    if (user.emailAddress != null && user.emailAddress.isNotEmpty) {
      try {
        print("user email address: ${user.emailAddress}");
        _userLoggedIn = true;
      } catch (e) {
        print(e);
      }
    } else {
      print("xxxxx user not logged in xxxxxx");
    }
    return _userLoggedIn ? ClientProfileScreen() : SignInPage();
  }
}
