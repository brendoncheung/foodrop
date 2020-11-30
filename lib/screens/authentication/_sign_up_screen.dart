import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  static const String ROUTE_NAME = '/sign-up-screen';

  @override
  Widget build(BuildContext context) {
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
                child: Text("Register"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
