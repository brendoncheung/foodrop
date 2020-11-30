import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodrop/core/models/client/client_user.dart';

class ClientAuthenticationService {
  final _auth = FirebaseAuth.instance;

  void switchToVendorMode() {
    // TODO check whether the user is in fact a vendor, if not, initiate vendor authentication screen flow
  }

  void createUserWithEmailAndPassword(String email, String password) {
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  void logInUserWithEmailAndPassword(String email, String password) {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOutUser() {
    _auth.signOut();
  }

  Stream<UserClient> onAuthChangeStream() {
    return _auth.authStateChanges().map((event) {
      print("logged in, uid: ${event.uid}");
      return UserClient(uid: event.uid);
    });
  }
}
