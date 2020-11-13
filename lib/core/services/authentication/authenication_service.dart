import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:foodrop/core/models/user.dart';

class AuthenticationService {
  final fb.FirebaseAuth _fb_auth = fb.FirebaseAuth.instance;

  Future createUserWithEmailAndPassword(String email, String password) {
    return _fb_auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future signInUserWithEmailAndPassword(String email, String password) {
    return _fb_auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  void signUserOut() {
    _fb_auth.signOut();
  }

  Stream<User> get currentUser {
    return _fb_auth.authStateChanges().map((fbUser) {
      return User(uid: fbUser.uid);
    });
  }
}
