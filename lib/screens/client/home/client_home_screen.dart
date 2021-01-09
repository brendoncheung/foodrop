import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';

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
    print(client_auth);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => client_auth.logOutUser())
        ],
      ),
      body: Center(
        child: Text("home"),
      ),
    );
  }
}
