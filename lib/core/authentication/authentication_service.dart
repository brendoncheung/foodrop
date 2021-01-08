import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;

  void switchToVendorMode() {}

  Future<bool> createClientWithEmailAndPassword(String email, String password) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user != null;
  }

  Future<bool> logInUserWithEmailAndPassword(String email, String password) async {
    var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user != null;
  }

  Future<void> logOutUser() {
    _auth.signOut();
  }

  Future<bool> isUserClient() async {
    var result = await _auth.currentUser.getIdTokenResult(true);
    return result.claims["client"];
  }

  Future<bool> isUserVendor() async {
    var result = await _auth.currentUser.getIdTokenResult(true);
    print("Claims: ${result.claims}");
    return result.claims["vendor"];
  }

  Stream<UserClient> onAuthChangeStream() {
    return _auth.authStateChanges().map(_firebaseUserToUserClient);
  }

  UserClient _firebaseUserToUserClient(User user) {
    var value = user.getIdTokenResult(true);
    value.then((value) => {print("Claims: ${value.claims}")});
    return UserClient(uid: user.uid);
  }
}
