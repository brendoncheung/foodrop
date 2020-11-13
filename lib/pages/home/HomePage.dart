import 'package:flutter/material.dart';
import 'package:foodrop/core/services/authentication/authenication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationService().signUserOut();
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Text("Home page"),
    );
  }
}
