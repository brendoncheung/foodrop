import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/screens/authentication/email_sign_in_form_userprofile_change_notifier.dart';

class ProfileHomeScreen extends StatelessWidget {
  ProfileHomeScreen({this.userProfile});
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
                title: Text("Update Profile"),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EmailSignInFormUserProfileChangeNotifier.create(
                            context: context,
                            firebaseUserProfile: userProfile)))),
            ListTile(
              title: Text("Join a business"),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
