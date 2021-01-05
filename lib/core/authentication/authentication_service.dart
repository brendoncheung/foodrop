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
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      HttpsCallable callable = _functions.httpsCallable("addClientRole");
      await callable.call({
        "email": email,
        "uid": userCredential.user.uid,
      });
    } catch (err) {
      print("creating user error : ${err}");
    }
  }

  void logInUserWithEmailAndPassword(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    var token = await _auth.currentUser.getIdTokenResult();
    print(token.claims);
  }

  Future<void> logOutUser() {
    _auth.signOut();
  }

  Future<bool> isUserClient() async {
    var result = await _auth.currentUser.getIdTokenResult();
    return result.claims["client"];
  }

  Stream<UserClient> onAuthChangeStream() {
    return _auth.authStateChanges().map(_firebaseUserToUserClient);
  }

  UserClient _firebaseUserToUserClient(User user) {
    var value = user.getIdTokenResult(true);
    value.then((value) => {print(value.claims)});
    return UserClient(uid: user.uid);
  }
}
