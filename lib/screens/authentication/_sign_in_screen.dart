import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/_sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var loading = false;

  void setLoading(bool b) {
    setState(() {
      loading = b;
    });
  }

  var _key = GlobalKey<FormState>();
  var emailTextFieldController = TextEditingController();
  var passwordTextFieldController = TextEditingController();
  var loginError = "";

  @override
  Widget build(BuildContext context) {
    final client_auth = Provider.of<AuthenticationService>(context);

    void _onLogInButtonPressedHandler() async {
      if (_key.currentState.validate()) {
        // https://stackoverflow.com/questions/44991968/how-can-i-dismiss-the-on-screen-keyboard/56946311#56946311
        // hide the keyboard
        FocusScope.of(context).unfocus();
        setLoading(true);
        var email = emailTextFieldController.text.trim();
        var password = passwordTextFieldController.text.trim();
        await Future.delayed(Duration(seconds: 1));

        try {
          await client_auth.logInUserWithEmailAndPassword(email, password);
        } on FirebaseAuthException catch (err) {
          loginError = err.message;
        } finally {
          setLoading(false);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Sign in"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Stack(
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: emailTextFieldController,
                    validator: _emailValidator,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: passwordTextFieldController,
                    validator: _passwordValidator,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  RaisedButton(child: Text("Log in"), onPressed: _onLogInButtonPressedHandler),
                  RaisedButton(
                    child: Text("Register"),
                    onPressed: () => Navigator.pushNamed(context, SignUpScreen.ROUTE_NAME),
                  ),
                  Text(
                    loginError,
                    style: TextStyle(color: Colors.red),
                  ),
                  Center(
                    child: Visibility(
                      child: CircularProgressIndicator(),
                      visible: loading,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _passwordValidator(String value) {
    return value.length >= 6 ? null : "Characters must be 6 or above";
  }

  String _emailValidator(String value) {
    return value.contains("@") ? null : "Please input a valid email";
  }
}
