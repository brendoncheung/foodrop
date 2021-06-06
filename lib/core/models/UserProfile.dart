import 'package:flutter/cupertino.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/screens/authentication/validators.dart';

enum EmailSignInFormType { signIn, register, update }

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
    DateTime mobileVerificationDate,
    DateTime emailVerificationDate,
    this.isLoading = false,
    this.submitted = false,
    DateTime creationDate,
    DateTime lastSignInDate,
    this.hasBusiness = false,
    this.formType = EmailSignInFormType.signIn,
  })  : dob = dob ?? DateTime.parse("1970-01-01"),
        creationDate = creationDate ?? DateTime.now(),
        mobileVerificationDate =
            mobileVerificationDate ?? DateTime.parse("1970-01-01"),
        emailVerificationDate =
            emailVerificationDate ?? DateTime.parse("1970-01-01"),
        lastSignInDate = lastSignInDate ?? DateTime.now();

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
  DateTime
      mobileVerificationDate; // verification ideally to be done every 6 month to ensure customer detail is up to date.
  DateTime emailVerificationDate;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  DateTime creationDate;
  DateTime lastSignInDate;
  bool hasBusiness;

  UserProfile.fromMap(Map<String, dynamic> map, String uid)
      : uid = map['uid'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        dob = map['dob'],
        isAnonymous = map['isAnonymous'],
        photoUrl = map['photoUrl'],
        username = map['username'],
        mobileNumber = map['mobileNumber'],
        emailAddress = map['email'],
        emailPassword = '',
        hasBusiness = map['hasBusiness'];
  // mobileVerificationDate = map['mobileVerificationDate'],
  // emailVerificationDate = map['emailVerificationDate'];
  //TODO: fixx issue retrieving datetype object

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        print("attempt to sign user in");
        await auth.logInUserWithEmailAndPassword(emailAddress, emailPassword);
        // print(auth.getUser());
        // print(auth.getUser().email);
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
    switch (formType) {
      case EmailSignInFormType.signIn:
        {
          return 'Sign in';
        }
        break;
      case EmailSignInFormType.register:
        {
          return 'Create an account';
        }
        break;
      default:
        {
          return 'Update Profile';
        }
    }
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
      'mobileVerificationDate': mobileVerificationDate,
      'emailVerificationDate': emailVerificationDate,
      'hasBusiness': hasBusiness
    };
  }

  void updateWith({
    String uid,
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
    DateTime mobileVerificationDate,
    DateTime emailVerificationDate,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
    DateTime creationDate,
    DateTime lastSignInDate,
    bool hasBusiness,
  }) {
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
    this.mobileVerificationDate =
        mobileVerificationDate ?? this.mobileVerificationDate;
    this.emailVerificationDate =
        emailVerificationDate ?? this.emailVerificationDate;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.creationDate = creationDate ?? this.creationDate;
    this.lastSignInDate = lastSignInDate ?? this.lastSignInDate;
    this.hasBusiness = hasBusiness ?? this.hasBusiness;
    notifyListeners();
  }
}
