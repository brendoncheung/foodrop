import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignUpTextFormField extends StatelessWidget {
  final labelText;
  final isObscured;
  final validator;
  final controller;

  SignUpTextFormField({
    @required this.labelText,
    this.isObscured = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isObscured,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[100],
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
