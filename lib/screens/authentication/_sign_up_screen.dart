import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/authentication_flow_wrapper.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/sign-up-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var isLoading = false;

  var signUpError = "";

  String emailValidator(String v) {
    //TODO: write validation code for emails
  }

  String passwordValidator(String v) {
    //TODO: write password validator code
    v.length >= 6 ? null : "Password should be at least 6 characters";
  }

  void setLoading(bool b) {
    setState(() {
      isLoading = b;
    });
  }

  void setErrorMessage(String msg) {
    signUpError = msg;
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
                  try {
                    setLoading(true);
                    await auth.createClientWithEmailAndPassword(email, password);
                    Navigator.of(context).popUntil((route) {
                      return route.isFirst;
                    });
                  } on FirebaseAuthException catch (err) {
                    setErrorMessage(err.message);
                  } finally {
                    setLoading(false);
                  }
                },
              ),
              Center(
                child: Visibility(
                  child: CircularProgressIndicator(),
                  visible: isLoading,
                ),
              ),
              Text(
                signUpError,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
