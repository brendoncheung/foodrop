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

  void switchMode(bool value, AuthenticationService service) async {
    bool isVendor = await service.isUserVendor();
    setState(() {
      isVendorMode = value;
    });
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
            onChanged: (value) => switchMode(value, auth),
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
