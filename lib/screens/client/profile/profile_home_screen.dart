import 'package:flutter/material.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:provider/provider.dart';

import 'client_profile_screen.dart';

class ProfileHomeScreen extends StatelessWidget {
  ProfileHomeScreen({this.userProfile});
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

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
                        ClientProfileScreen(db: db, userFile: userProfile)))),
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
