import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/client/profile/client_profile_screen.dart';
import 'package:provider/provider.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  var isUserClient = false;

  @override
  Widget build(BuildContext context) {
    var client_auth = Provider.of<AuthenticationService>(context);
    // print("xxxxxxxxxxxxxxxx");
    // print(client_auth.);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        // actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => client_auth.logOutUser())],
        actions: [
          CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ClientProfileScreen(),
                    fullscreenDialog: false),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      body: Center(
        child: Text("home"),
      ),
    );
  }
}
