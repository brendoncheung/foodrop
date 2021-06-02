import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key key, this.db, this.onLoggedIn})
      : super(key: key);
  final Database db;
  final VoidCallback onLoggedIn;

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final TextEditingController _tecFirstName = TextEditingController();
  final TextEditingController _tecLastName = TextEditingController();
  final TextEditingController _tecUserName = TextEditingController();
  final TextEditingController _tecMobileNumber = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _fnFirstName = FocusNode();
  final FocusNode _fnLastName = FocusNode();
  final FocusNode _fnUserName = FocusNode();
  final FocusNode _fnMobileNumber = FocusNode();
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnPassword = FocusNode();

  // EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _tecFirstName.dispose();
    _tecLastName.dispose();
    _tecUserName.dispose();
    _tecMobileNumber.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fnFirstName.dispose();
    _fnLastName.dispose();
    _fnUserName.dispose();
    _fnMobileNumber.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();

    super.dispose();
  }

  // final String uid;
  // final String firstName;
  // final String lastName;
  // // final String age;
  // final DateTime dob;
  // final bool isVendor;
  // final bool isAnonymous;
  // final bool signedInViaEmail;
  // final bool signedInviaGoogle;
  // final bool signedInViaFaceBook;
  // final String photoUrl;
  // final String username;
  // final String mobileNumber;
  // final String emailAddress;
  // final bool
  // isMobileVerified; // verification ideally to be done every 6 month to ensure customer detail is up to date.
  // final bool isEmailVerified;

  //TODO: Text editing controller

  // bool isVendorMode = false;
  //
  // void switchMode(bool value) {
  //   setState(() {
  //     isVendorMode = value;
  //   });
  // }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Not a vendor'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('You must register to become a vendor'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Register'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Return'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // await auth.logOutUser();
  // Navigator.of(context).pop();

  // var user;

  @override
  Widget build(BuildContext context) {
    print("rebuild ClientProfileScreen");
    var auth = Provider.of<AuthenticationService>(context);
    final db = Provider.of<Database>(context);

    final uid = auth.getUser().uid;
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
        body: Consumer<UserProfile>(
          builder: (_, userProfile, __) {
            UserProfile user;
            db.userClientStream(uid).first.then((u) => user = u);
            print("check user is loaded: $user");
            return Column(
              children: [
                Text(userProfile.uid),
                // Text(user.emailAddress),
                // Text(user.firstName)
              ],
            );
          },
        )
        // body: StreamBuilder<UserProfile>(
        //   stream: db.userClientStream(auth.getUser().uid),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     }
        //     // print("================");
        //     // print(auth.getUser().uid);
        //
        //     if (snapshot.connectionState == ConnectionState.active) {
        //       try {
        //         if (snapshot.hasData) {
        //           print("XXXXX Client Profile Screen XXXXX");
        //           print(snapshot.data.toMap().toString());
        //           return Text(snapshot.data.toMap().toString());
        //         } else {
        //           db.userClientStream(auth.getUser().uid);
        //         }
        //       } catch (e) {
        //         print("snapshot has no data");
        //       }
        //     }
        //
        //     return Text("No data");
        //   },
        // ),
        );
  }

  Future<void> _confirmSignOut() async {
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
      widget.onLoggedIn();
      // Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }
}
