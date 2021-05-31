import 'package:flutter/material.dart';
import 'package:foodrop/screens/authentication/email_sign_in_form_userprofile_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  // EmailSignInPage({this.userClient});
  // UserClient userClient;
  @override
  Widget build(BuildContext context) {
    print("build sign in page");
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormUserProfileChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
