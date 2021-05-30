import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key key, this.db}) : super(key: key);
  final Database db;

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  bool isVendorMode = false;

  void switchMode(bool value) {
    setState(() {
      isVendorMode = value;
    });
  }

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
  @override
  Widget build(BuildContext context) {
    // var auth = Provider.of<AuthenticationService>(context);
    final db = Provider.of<Database>(context);
    final userFirebase = db.userClientStream();
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
      body: StreamBuilder<UserClient>(
        stream: db.userClientStream(),
        builder: (context, snapshot) => Text(snapshot.data.uid),
      ),
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
    } catch (e) {
      print(e.toString());
    }
  }
}
