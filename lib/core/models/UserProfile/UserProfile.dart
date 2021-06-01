import 'package:flutter/cupertino.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/validators.dart';

enum EmailSignInFormType { signIn, register }

class UserProfile with ChangeNotifier, EmailAndPasswordValidators {
  UserProfile({
    @required this.auth,
    this.uid = "",
    this.firstName = "",
    this.lastName = "",
    DateTime dob,
    this.isAnonymous = true,
    this.signedInViaEmail = false,
    this.signedInviaGoogle = false,
    this.signedInViaFaceBook = false,
    this.photoUrl = "",
    this.username = "",
    this.mobileNumber = "",
    this.emailAddress = "",
    this.emailPassword = "",
    this.isMobileVerified = false,
    this.isEmailVerified = false,
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    DateTime creationDate,
    DateTime lastSignInDate,
  })  : dob = dob ?? DateTime.parse("1970-01-01"),
        creationDate = dob ?? DateTime.now(),
        lastSignInDate = dob ?? DateTime.now();

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
        emailAddress = map['email'],
        emailPassword = '',
        isMobileVerified = map['isMobileVerified'],
        isEmailVerified = map['isEmailVerified'];

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        print("attempt to sign user in");
        await auth.logInUserWithEmailAndPassword(emailAddress, emailPassword);
        print(auth.getUser());
        updateWith(uid: auth.getUser().uid);
      } else {
        print("attempt to create user login");
        await auth.createClientWithEmailAndPassword(
            emailAddress, emailPassword);
        updateWith(uid: auth.getUser().uid);
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

  // void updateEmail(String email) => updateWith(emailAddress: emailAddress);
  //
  // void updatePassword(String password) =>
  //     updateWith(emailPassword: emailPassword);

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

  void updateWith(
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
    print("pw is ==== ${this.emailPassword}");
    this.uid = uid ?? this.uid;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.dob = dob ?? this.dob;
    this.isAnonymous = isAnonymous ?? this.isAnonymous;
    this.signedInViaEmail = signedInViaEmail ?? this.signedInViaEmail;
    this.signedInviaGoogle = signedInviaGoogle ?? this.signedInviaGoogle;
    this.signedInViaFaceBook = signedInViaFaceBook ?? this.signedInViaFaceBook;
    this.photoUrl = photoUrl ?? this.photoUrl;
    this.username = username ?? this.username;
    this.mobileNumber = mobileNumber ?? this.mobileNumber;
    this.emailAddress = emailAddress ?? this.emailAddress;
    this.emailPassword = emailPassword ?? this.emailPassword;
    this.isMobileVerified = isMobileVerified ?? this.isMobileVerified;
    this.isEmailVerified = isEmailVerified ?? this.isEmailVerified;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.creationDate = creationDate ?? this.creationDate;
    this.lastSignInDate = lastSignInDate ?? this.lastSignInDate;
    notifyListeners();
  }
}
