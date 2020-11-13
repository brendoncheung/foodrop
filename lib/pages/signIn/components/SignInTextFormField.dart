import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignInTextFormField extends StatelessWidget {
  final labelText;
  final isObscured;
  final validator;
  final controller;

  SignInTextFormField(
      {@required this.labelText,
      this.isObscured = false,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: isObscured,
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey[100],
          )),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
