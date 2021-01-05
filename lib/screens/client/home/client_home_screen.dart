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

    return Center(
      child: Column(
        children: [
          RaisedButton(
            child: Text("Check claims"),
            onPressed: () async {
              var isClient = await client_auth.isUserClient();
              setState(() {
                isUserClient = isClient;
              });
            },
          ),
          isUserClient ? Text("User is client") : CircularProgressIndicator()
        ],
      ),
    );
  }
}
