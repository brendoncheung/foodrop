import 'package:flutter/material.dart';
import 'package:foodrop/core/services/authentication/authenication_service.dart';
import 'package:foodrop/pages/SignUp/components/SignUpTextFormField.dart';

class SignUpPage1 extends StatefulWidget {
  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // stateful
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              elevation: 0,
              title: Text("Welcome aboard!"),
              backgroundColor: Colors.grey[900],
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SignUpTextFormField(
                      labelText: "Email",
                      validator: _validateEmail,
                      controller: emailController,
                    ),
                    SignUpTextFormField(
                      labelText: "Password",
                      validator: _validatePassword,
                      controller: passwordController,
                    ),
                    SizedBox(height: 16),
                    RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textColor: Colors.white,
                      child: Text("Sign up"),
                      onPressed: _onRegistrationButtonPressed,
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          );
  }

  String _validateEmail(String val) {
    print("validate email");
    return val.contains("@") ? null : "Please input a valid email";
  }

  String _validatePassword(String val) {
    print("validate password");
    return val.length >= 6 ? null : "Password must be 6 characters or more";
  }

  void _onRegistrationButtonPressed() async {
    if (_formKey.currentState.validate()) {
      try {
        await AuthenticationService().createUserWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        Navigator.pop(context);
      } catch (e) {}
    }
  }
}
