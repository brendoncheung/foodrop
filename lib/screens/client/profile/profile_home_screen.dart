import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/core/services/repositories/user_profile_repository.dart';
import 'package:foodrop/screens/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'profile_update_screen.dart';

class ProfileHomeScreen extends StatelessWidget {
  ProfileHomeScreen({this.userProfile});
  final UserProfile userProfile;

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthenticationService>(context, listen: false);
      await auth.logOutUser();
      // widget.onLoggedIn();
      // Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text("Update Profile"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ClientProfileScreen(db: db, userFile: userProfile);
                  },
                ),
              ),
            ),
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
