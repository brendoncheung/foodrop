import 'package:flutter/material.dart';
import 'package:foodrop/core/services/authentication/authenication_service.dart';
import 'package:foodrop/pages/SignUp/SignUpPage1.dart';
import 'package:foodrop/pages/signIn/components/SignInTextFormField.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  // state
  bool _switchState = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey[900],
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Foodrop",
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300]),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SignInTextFormField(
                    labelText: "Email",
                    controller: _emailTextController,
                    validator: _emailValidator,
                  ),
                  SignInTextFormField(
                    labelText: "Password",
                    controller: _passwordTextController,
                    isObscured: true,
                    validator: _passwordValidator,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: _switchState,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      _switchState = !_switchState;
                    });
                  },
                ),
                Text(
                  "As vendor?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[500]),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Login"),
                    onPressed: () {
                      if (_switchState == false) {
                        _loginAsUser();
                      } else {
                        print("Login as vendor");
                      }
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textColor: Colors.white,
                    child: Text("Sign up"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage1()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _emailValidator(String val) {
    return val.contains("@") ? null : "Please enter a valid email";
  }

  String _passwordValidator(String val) {
    return val.length >= 6 ? null : "Password must be 6 characters or more";
  }

  void _loginAsUser() {
    if (_formkey.currentState.validate()) {
      String email = _emailTextController.text.trim();
      String password = _passwordTextController.text.trim();
      print("logging in....with username $email and password $password");
      AuthenticationService().signInUserWithEmailAndPassword(email, password);
    }
  }
}
