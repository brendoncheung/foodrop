import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:cloud_functions/cloud_functions.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;

  void switchToVendorMode() {
    // TODO check whether the user is in fact a vendor, if not, initiate vendor authentication screen flow
  }

  Future<void> createClientWithEmailAndPassword(String email, String password) async {
    var userCredential = _auth.createUserWithEmailAndPassword(email: email, password: password);
    // TODO: return a future of Map<String : dynamic> for things like onData or onError to notify the register page
    // _functions.httpsCallable('addClientRole');
    // callable.call(<String, dynamic>{"uid": userCredential.user.uid});
  }

  void logInUserWithEmailAndPassword(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    var token = await _auth.currentUser.getIdTokenResult();
    print(token.claims);
  }

  Future<void> logOutUser() {
    _auth.signOut();
  }

  Stream<UserClient> onAuthChangeStream() {
    return _auth.authStateChanges().map(_firebaseUserToUserClient);
  }

  UserClient _firebaseUserToUserClient(User user) {
    return UserClient(uid: user.uid);
  }
}
