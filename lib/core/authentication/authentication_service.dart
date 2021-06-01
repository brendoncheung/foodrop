import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodrop/core/models/UserProfile/UserProfile.dart';

// import 'package:google_sign_in/google_sign_in.dart';

import '../models/UserProfile/UserProfile.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  void switchToVendorMode() {}

  Future<bool> createClientWithEmailAndPassword(
      String email, String password) async {
    var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user != null;
  }

  User getUser() {
    // _auth.currentUser.providerData.add(UserInfo(sampleData));
    return _auth.currentUser;
  }

  Future<Stream<UserProfile>> logInUserWithEmailAndPassword(
      String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    return _auth.authStateChanges().map((user) {
      return UserProfile(
        auth: AuthenticationService(),
        uid: user.uid,
        isAnonymous: false,
        emailAddress: user.email,
        mobileNumber: user.uid,
      );
    });
  }

  // Future<UserClient> signInWithGoogle() async {
  //   var googleSignIn = GoogleSignIn();
  //   print("attempting to sign in with google");
  //   var googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     var googleAuth = await googleAccount.authentication;
  //     if (googleAuth.idToken != null) {
  //       final credential = GoogleAuthProvider.credential(
  //           idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  //       final userCredential = await _auth.signInWithCredential(credential);
  //       return UserClient(
  //         uid: userCredential.user.uid,
  //         firstName: userCredential.user.displayName,
  //       );
  //     } else {
  //       throw FirebaseAuthException(message: "access token denied");
  //     }
  //   } else {
  //     throw FirebaseAuthException(message: "sign in aborted by user");
  //   }
  // }

  Future<UserProfile> signInAnonymous() async {
    final userCredential = await _auth.signInAnonymously();
    return UserProfile(
        uid: userCredential.user.uid,
        isAnonymous: true,
        auth: AuthenticationService());
  }

  Future<void> logOutUser() async {
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut(); //sign out of google
    _auth.signOut(); // sign out from firebase
  }

  Future<bool> isUserVendor() async {
    var result = await _auth.currentUser.getIdTokenResult(true);
    print("Claims: ${result.claims}");
    print("result: ${result.claims["vendor"]}");
    return result.claims["vendor"];
  }

  Stream<UserProfile> onAuthChangeStream() {
    print("####### Trigger onAuthChangeStream #####");
    return _auth
        .authStateChanges()
        .map((user) => _firebaseUserToUserClient(user));
  }

  UserProfile _firebaseUserToUserClient(User user) {
    return UserProfile(uid: user.uid, auth: AuthenticationService());
  }

  // Future<void> signOut() async {
  //   // final googleSignIn = GooggleSignIn();
  //   // await googleSignIn.signOut();
  //   // final facebookLogin = FacebookLogin();
  //   // await facebookLogin.logOut();
  //   await _auth.signOut();
  // }
}
