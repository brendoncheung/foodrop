import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile.dart';
import 'package:foodrop/core/services/database/database.dart';
import 'package:foodrop/screens/authentication/email_sign_in_form_userprofile_change_notifier.dart';
import 'package:foodrop/screens/business/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key key, this.db, this.userFile}) : super(key: key);
  final Database db;
  final UserProfile userFile;

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  // final TextEditingController _tecFirstName = TextEditingController();
  // final TextEditingController _tecLastName = TextEditingController();
  // final TextEditingController _tecUserName = TextEditingController();
  // final TextEditingController _tecMobileNumber = TextEditingController();
  // final TextEditingController _tecEmail = TextEditingController();
  // final TextEditingController _tecPassword = TextEditingController();
  //
  // final FocusNode _fnFirstName = FocusNode();
  // final FocusNode _fnLastName = FocusNode();
  // final FocusNode _fnUserName = FocusNode();
  // final FocusNode _fnMobileNumber = FocusNode();
  // final FocusNode _fnEmail = FocusNode();
  // final FocusNode _fnPassword = FocusNode();

  // EmailSignInChangeModel get model => widget.model;

  @override
  // void dispose() {
  //   _tecFirstName.dispose();
  //   _tecLastName.dispose();
  //   _tecUserName.dispose();
  //   _tecMobileNumber.dispose();
  //   _tecEmail.dispose();
  //   _tecPassword.dispose();
  //   _fnFirstName.dispose();
  //   _fnLastName.dispose();
  //   _fnUserName.dispose();
  //   _fnMobileNumber.dispose();
  //   _fnEmail.dispose();
  //   _fnPassword.dispose();
  //   super.dispose();
  // }

  Future<void> _confirmSignOut() async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to logout?',
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
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildForm(BuildContext context, UserProfile uProfile) {
    print(uProfile);
    return EmailSignInFormUserProfileChangeNotifier.create(context: context, firebaseUserProfile: uProfile);
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild ClientProfileScreen");

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: _confirmSignOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: _buildForm(context, widget.userFile),
    );
  }

  Widget _circularProgressIndicatorInCenter() {
    return Center(
        child: Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Loading"),
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator()
      ]),
    ));
  }
}
