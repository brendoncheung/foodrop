import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

class ClientSignUpScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/sign-up-screen';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String emailValidator(String v) {
    //TODO: write validation code for emails
  }

  String passwordValidator(String v) {
    //TODO: write password validator code
    v.length >= 6 ? null : "Password should be at least 6 characters";
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: emailValidator,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                controller: passwordController,
                validator: passwordValidator,
                decoration: InputDecoration(hintText: "Password"),
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () async {
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();
                  await auth.createClientWithEmailAndPassword(email, password);
                  //TODO need to validate if the creation was successful
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
