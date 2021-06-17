import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business.dart';
import 'package:foodrop/screens/authentication/email_sign_in_form_userprofile_change_notifier.dart';
import 'package:provider/provider.dart';

class EmailSignInPage extends StatelessWidget {
  // EmailSignInPage({this.onLoggedIn});
  // VoidCallback onLoggedIn;
  // EmailSignInPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    print("build sign in page");
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:
              EmailSignInFormUserProfileChangeNotifier.create(context: context),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
