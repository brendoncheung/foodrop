import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/client_authentication_service.dart';
import 'package:foodrop/screens/authentication/_sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client_auth = Provider.of<ClientAuthenticationService>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              RaisedButton(
                child: Text("Log in"),
                onPressed: () {
                  client_auth.logInUserWithEmailAndPassword("ming.cheung@outlook.com", "Bme19900112");
                },
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.ROUTE_NAME);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
