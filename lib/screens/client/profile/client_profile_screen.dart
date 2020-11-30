import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/client_authentication_service.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key key}) : super(key: key);

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  bool isVendorMode = false;

  void switchMode(bool value, ClientAuthenticationService service) {
    setState(() {
      isVendorMode = value;
    });

    service.switchToVendorMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          Consumer<ClientAuthenticationService>(
            builder: (context, clientAuth, child) {
              return SwitchListTile(
                value: isVendorMode,
                onChanged: (value) => switchMode(value, clientAuth),
                title: Text(
                  "Vendor mode",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: Text(
                  "This will switch to vendor mode",
                  style: Theme.of(context).textTheme.caption,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
