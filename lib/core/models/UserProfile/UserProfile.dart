import 'package:flutter/cupertino.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/validators.dart';

enum EmailSignInFormType { signIn, register }

class UserProfile with ChangeNotifier, EmailAndPasswordValidators {
  UserProfile({
    @required this.auth,
    this.uid,
    this.firstName,
    this.lastName,
    this.dob,
    this.isAnonymous,
    this.signedInViaEmail,
    this.signedInviaGoogle,
    this.signedInViaFaceBook,
    this.photoUrl,
    this.username,
    this.mobileNumber,
    this.emailAddress,
    this.emailPassword,
    this.isMobileVerified,
    this.isEmailVerified,
    this.formType,
    this.isLoading,
    this.submitted,
    this.creationDate,
    this.lastSignInDate,
  });
  AuthenticationService auth;
  String uid;
  String firstName;
  String lastName;
  DateTime dob;
  bool isAnonymous;
  bool signedInViaEmail;
  bool signedInviaGoogle;
  bool signedInViaFaceBook;
  String photoUrl;
  String username;
  String mobileNumber;
  String emailAddress;
  String emailPassword;
  bool
      isMobileVerified; // verification ideally to be done every 6 month to ensure customer detail is up to date.
  bool isEmailVerified;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  DateTime creationDate;
  DateTime lastSignInDate;

  UserProfile.fromMap(Map<String, dynamic> map, String uid)
      : uid = map['uid'],
        firstName = map['firstname'],
        lastName = map['lastname'],
        dob = map['dob'],
        isAnonymous = map['isAnonymous'],
        signedInViaEmail = map['signedInViaEmail'],
        signedInviaGoogle = map['signedInviaGoogle'],
        signedInViaFaceBook = map['signedInViaFaceBook'],
        photoUrl = map['photoUrl'],
        username = map['username'],
        mobileNumber = map['mobileNumber'],
        emailAddress = map['emailAddress'],
        emailPassword = '',
        isMobileVerified = map['isMobileVerified'],
        isEmailVerified = map['isEmailVerified'];

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.logInUserWithEmailAndPassword(emailAddress, emailPassword);
      } else {
        await auth.createClientWithEmailAndPassword(
            emailAddress, emailPassword);
        // final currentuser = auth.getUser();
        // this.uid = currentuser.uid;
        //
        // print("uid: ${currentuser.uid}, $currentuser");
        // db.setUser(); // write to firebase

      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isNotEmpty(emailAddress) &&
        passwordValidator.isNotEmpty(emailPassword) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText =
        submitted && !passwordValidator.isNotEmpty(emailPassword);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isNotEmpty(emailAddress);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get nonEmptyText {
    bool showErrorText = submitted && !emailValidator.isNotEmpty(emailAddress);
    return showErrorText ? nonEmptyTextFieldErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      emailAddress: '',
      emailPassword: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateFirstName(String firstName) => updateWith(firstName: firstName);
  void updateLastName(String lastName) => updateWith(lastName: lastName);
  void updateUserName(String userName) => updateWith(username: userName);

  void updateMobileNumber(String mobileNumber) =>
      updateWith(mobileNumber: mobileNumber);

  void updateEmail(String email) => updateWith(emailAddress: emailAddress);

  void updatePassword(String password) =>
      updateWith(emailPassword: emailPassword);

  // setUser() {
  //   FirestoreService.instance.setData(
  //     path: APIPath.user(uid: uid),
  //     data: toMap(), // return a user object in Map format
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': emailAddress,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'mobileNumber': mobileNumber,
      'creationDate': creationDate,
      'lastSignInDate': lastSignInDate,
    };
  }

  UserProfile updateWith(
      {String uid,
      String firstName,
      String lastName,
      DateTime dob,
      // bool isVendor,
      bool isAnonymous,
      bool signedInViaEmail,
      bool signedInviaGoogle,
      bool signedInViaFaceBook,
      String photoUrl,
      String username,
      String mobileNumber,
      String emailAddress,
      String emailPassword,
      bool
          isMobileVerified, // verification ideally to be done every 6 month to ensure customer detail is up to date.
      bool isEmailVerified,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted,
      DateTime creationDate,
      DateTime lastSignInDate}) {
    return UserProfile(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      signedInViaEmail: signedInViaEmail ?? this.signedInViaEmail,
      signedInviaGoogle: signedInviaGoogle ?? this.signedInviaGoogle,
      signedInViaFaceBook: signedInViaFaceBook ?? this.signedInViaFaceBook,
      photoUrl: photoUrl ?? this.photoUrl,
      username: username ?? this.username,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      emailPassword: emailPassword ?? this.emailPassword,
      isMobileVerified: isMobileVerified ?? this.isMobileVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
      creationDate: creationDate ?? this.creationDate,
      lastSignInDate: lastSignInDate ?? this.lastSignInDate,
      // isVendor: isVendor ?? this.isVendor,
    );
  }
}
