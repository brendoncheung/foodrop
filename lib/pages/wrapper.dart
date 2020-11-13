import 'package:flutter/material.dart';
import 'package:foodrop/core/models/user.dart';
import 'package:foodrop/pages/home/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:foodrop/pages/signIn/SignInPage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
    print("User in wrapper: $_user");
    return _user == null ? SignInPage() : HomePage();
  }
}
