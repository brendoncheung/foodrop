import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/sign_in_page.dart';
import 'package:foodrop/screens/client/profile/client_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileLandingScreen extends StatefulWidget {
  @override
  _ProfileLandingScreenState createState() => _ProfileLandingScreenState();
}

class _ProfileLandingScreenState extends State<ProfileLandingScreen> {
  var _userLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationService>(context);
    final _user = auth.getUser();
    print("build clientBottomNavigation ");
    // print("user id is: ${_user.uid}");
    if (_user.email != null && _user.email.isNotEmpty) {
      try {
        // print("user email address: ${_user.email}");
        setState(() {
          _userLoggedIn = true;
        });
      } catch (e) {
        print(e);
      }
    } else {
      print("xxxxx user not logged in xxxxxx");
    }

    return _userLoggedIn ? ClientProfileScreen() : SignInPage();
  }
}
