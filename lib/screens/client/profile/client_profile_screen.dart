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
  bool isLoading = false;
  void switchMode(bool value, AuthenticationService service) {
    setState(() {
      isVendorMode = value;
    });
    service.switchToVendorMode();
  }

  void setLoading(bool b) {
    setState(() {
      isLoading = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              // TODO probably dumb for having two consumers here, might be better to convert to local scope
              children: [
                Consumer<AuthenticationService>(
                  builder: (context, clientAuth, child) {
                    print("auth from switch tile: hash = ${clientAuth.hashCode}");
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
                Consumer<AuthenticationService>(
                  builder: (context, clientAuth, child) {
                    print("auth from list tile: hash = ${clientAuth.hashCode}");
                    return ListTile(
                      // TODO: sign out actually returns in future, use a provider to async it
                      onTap: () async {
                        setLoading(true);
                        await Future.delayed(Duration(seconds: 1));
                        print("signing out");
                        await clientAuth.logOutUser();
                        setLoading(false);
                      },
                      title: Text(
                        "Log out",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      trailing: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }
}
