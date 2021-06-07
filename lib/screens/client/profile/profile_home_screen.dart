import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/models/business_user_link.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/core/services/repositories/user_profile_repository.dart';
import 'package:foodrop/screens/client/profile/join_buisness_screen.dart';
import 'package:foodrop/screens/common_widgets/asyncSnapshot_Item_Builder.dart';
import 'package:foodrop/screens/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'profile_update_screen.dart';

class ProfileHomeScreen extends StatefulWidget {
  ProfileHomeScreen({this.userProfile});
  final UserProfile userProfile;

  @override
  _ProfileHomeScreenState createState() => _ProfileHomeScreenState();
}

class _ProfileHomeScreenState extends State<ProfileHomeScreen> {
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

  Widget _buildProfileBody(BuildContext context, Database db) {
    return Padding(
      padding: EdgeInsets.only(top: 38.0),
      child: Container(
        // color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Divider(
                thickness: 1.0,
              ),
              ListTile(
                title: Text("Update Profile"),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ClientProfileScreen(
                          db: db, userFile: widget.userProfile);
                    },
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Join a business"),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return JoinBusinessScreen(
                        db: db,
                        userProfile: widget.userProfile,
                      );
                    },
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _vendorModeSwitch1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 18),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
        ),
        child: SwitchListTile(
          value: widget.userProfile.defaultVendorMode,
          onChanged: (value) => _toggleVendorSwitch(context, value),
          title: Text("Vendor Mode"),
        ),
      ),
    );
  }

  Widget _vendorModeSwitch() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: TextField(
        // controller: _tecSearchField,
        // onEditingComplete: _submit,
        decoration: InputDecoration(
          fillColor: Colors.lightGreen,
          filled: true,
          // errorText: !_tecSearchField.text.isNotEmpty && _hasSubmitted
          //     ? "cannot be empty"
          //     : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 0.8),
          ),
          hintText:
              "type '1112223' to test ", //Enter companies office number // TODO: correct the hint text
          prefixIcon: Icon(
            Icons.search,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            // onPressed: () => _tecSearchField.text = "",
          ),
        ),
      ),
    );
  }

  _toggleVendorSwitch(BuildContext context, bool value) async {
    final db = FirestoreDatabase(uid: widget.userProfile.uid);
    //TODO: is this safe to do? Instead of using Provider, I instantiate a new Database class.
    print("toggle $value");
    setState(() {
      widget.userProfile.updateWith(defaultVendorMode: value);
    });
    print(
        "userprofile.defaultVendorMode: ${widget.userProfile.defaultVendorMode}");
    await db.setUser(widget.userProfile);
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);

    print(widget.userProfile.hasBusiness);
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
            Stack(
              children: [
                _buildProfileBody(context, db),
                if (widget.userProfile.hasBusiness) _vendorModeSwitch1(),
              ],
            ),
            if (widget.userProfile.defaultVendorMode)
              SingleChildScrollView(
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32, left: 12, right: 12),
                    child: Container(
                      // color: Colors.grey,
                      height: 400,
                      child: StreamBuilder<List<BusinessUserLink>>(
                        stream: db.businessUserLinkStream(
                            userId: "HoI4jOVYkFg8uRqCr0tf7trSQjv1"),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              {
                                return CircularProgressIndicator();
                              }
                              break;
                            case ConnectionState.active:
                              {
                                return AsyncSnapshotItemBuilder<
                                    BusinessUserLink>(
                                  snapshot: snapshot,
                                  itemBuilder: (context, businessUserLink) {
                                    return Card(
                                        color: Colors.blue,
                                        child: ListTile(
                                          onTap: () {},
                                          title: Text(
                                              "${businessUserLink.businessLegalName}"),
                                        ));
                                  },
                                );
                                // if (snapshot.hasData) {
                                //   return ListView.separated(
                                //       itemBuilder: (context, index) {
                                //         return Card(
                                //             color: Colors.blue,
                                //             child: ListTile(
                                //               onTap: () {},
                                //               title: Text(
                                //                   "${snapshot.data[index].businessTradingName}"),
                                //             ));
                                //       },
                                //       separatorBuilder: (context, index) =>
                                //           Divider(height: 0.5),
                                //       itemCount: snapshot.data.length);
                                // }
                                // return Text("No data");
                              }
                              break;
                            default:
                              {
                                return CircularProgressIndicator();
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
