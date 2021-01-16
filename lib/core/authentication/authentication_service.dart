import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodrop/core/models/client/client_user.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/client/client_user.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;

  void switchToVendorMode() {}

  Future<bool> createClientWithEmailAndPassword(String email, String password) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user != null;
  }

  Future<UserClient> signInWithGoogle() async {
    var googleSignIn = GoogleSignIn();
    print("attempting to sign in with google");
    var googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      var googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        final userCredential = await _auth.signInWithCredential(credential);
        return UserClient(
          uid: userCredential.user.uid,
          firstName: userCredential.user.displayName,
        );
      } else {
        throw FirebaseAuthException(message: "access token denied");
      }
    } else {
      throw FirebaseAuthException(message: "sign in aborted by user");
    }
  }

  Future<UserClient> signInAnonymous() async {
    final userCredential = await _auth.signInAnonymously();
    return UserClient(uid: userCredential.user.uid);
  }

  Future<bool> logInUserWithEmailAndPassword(String email, String password) async {
    var userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user != null;
  }

  Future<void> logOutUser() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut(); //sign out of google
    _auth.signOut(); // sign out from firebase
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
    return UserClient(uid: user.uid, isVendor: false);
  }
}
