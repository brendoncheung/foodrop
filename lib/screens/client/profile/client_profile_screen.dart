import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key key}) : super(key: key);

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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not a vendor'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You must register to become a vendor'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Return'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: isVendorMode,
            onChanged: (value) async {
              switchMode(value);
              var isVendor = await auth.isUserVendor();
              if (!isVendor && isVendorMode) {
                _showMyDialog();
              }
            },
            title: Text(
              "Vendor mode",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: Text(
              "This will switch to vendor mode",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          ListTile(
            onTap: () async {
              await auth.logOutUser();
            },
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
