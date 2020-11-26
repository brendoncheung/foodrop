import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser(String username, String password) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
  }
}
