import 'package:flutter/material.dart';

import '../../screens/authentication/widgets/sign_in_button.dart';
import '../../screens/authentication/widgets/social_sign_in_button.dart';
import 'email_sign_in_page.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:time_tracker_flutter_course/app/screens/email_sign_in.dart';
//import 'package:time_tracker_flutter_course/app/services/auth.dart';
//import 'package:time_tracker_flutter_course/app/widgets/sign_in_button.dart';
//import 'package:time_tracker_flutter_course/app/widgets/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({this.onLoggedIn});
  VoidCallback onLoggedIn;
//  Auth auth;

//  const SignInPage({Key key, this.auth}) : super(key: key);

//  Future<void> _signInAnonymously() async {
//    try {
//      final auth = Provider.of<AuthenticationService>();
//      await auth.signInAnonymous().then((value) => print(value));
//    } catch (e) {
//      print(e.toString());
//    }
//  }

  Future<void> _signInWithFacebook() async {
//    try {
//      await auth.signInWithFacebook().then((value) => print(value));
//    } catch (e) {
//      print(e.toString());
//    }
  }

  void _signInWithEmail(BuildContext context) {
    // final userClient = Provider.of<UserClient>(context);

    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(
              onLoggedIn: onLoggedIn,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Align(alignment: Alignment.center, child: Text('Restaurant Diary')),
        elevation: 4.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 48.0),
          // SocialSignInButton(
          //     assetName: 'assets/images/google-logo.png',
          //     text: 'Sign in with Google',
          //     textColor: Colors.black87,
          //     color: Colors.white,
          //     onPressed: () async {
          //       try {
          //         final auth = Provider.of<AuthenticationService>(context,
          //             listen: false);
          //         await auth.signInWithGoogle().then((value) => print("XXXXX"));
          //       } catch (e) {
          //         print(e.toString());
          //       }
          //     }),
          // SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'assets/images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: _signInWithFacebook,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {
              _signInWithEmail(context);
            },
          ),
          // SizedBox(height: 8.0),
          // Text(
          //   'or',
          //   style: TextStyle(fontSize: 14.0, color: Colors.black87),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 8.0),
          // SignInButton(
          //     text: 'Go anonymous',
          //     textColor: Colors.black,
          //     color: Colors.lime[300],
          //     onPressed: () async {
          //       final auth =
          //           Provider.of<AuthenticationService>(context, listen: false);
          //       await auth.signInAnonymous().then((value) => print(value));
          //     }),
        ],
      ),
    );
  }
}
