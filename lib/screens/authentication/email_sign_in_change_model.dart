import 'package:flutter/foundation.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/services/api_path.dart';
import 'package:foodrop/core/services/firestore_service.dart';

import 'validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.uid = '',
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
    this.userName = "",
    this.firstName = "",
    this.lastName = "",
    this.mobileNumber = "",
    this.creationDate = DateTime.utc(1969, 7, 20, 20, 18, 04),
  });
  final AuthenticationService auth;
  String email;
  String uid;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  String firstName;
  String lastName;
  String userName;
  String mobileNumber;
  DateTime creationDate;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.logInUserWithEmailAndPassword(email, password);
      } else {
        await auth.createClientWithEmailAndPassword(email, password);
        print("This line is executed to save user info");
        final currentuser = auth.getUser();
        uid = currentuser.uid;
        setUser();
        print("upload succcessful");
        print("uid: ${currentuser.uid}, $currentuser");
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
    return emailValidator.isNotEmpty(email) &&
        passwordValidator.isNotEmpty(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isNotEmpty(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isNotEmpty(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get nonEmptyText {
    bool showErrorText = submitted && !emailValidator.isNotEmpty(email);
    return showErrorText ? nonEmptyTextFieldErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateFirstName(String firstName) => updateWith(firstName: firstName);
  void updateLastName(String lastName) => updateWith(lastName: lastName);
  void updateUserName(String userName) => updateWith(userName: userName);

  void updateMobileNumber(String mobileNumber) =>
      updateWith(phoneNumber: mobileNumber);

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith(
      {String uid,
      String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted,
      String firstName,
      String lastName,
      String userName,
      String phoneNumber}) {
    this.uid = uid ?? this.uid;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.userName = userName ?? this.userName;
    this.mobileNumber = phoneNumber ?? this.mobileNumber;
    notifyListeners();
  }

  setUser() {
    FirestoreService.instance.setData(
      path: APIPath.user(uid: uid),
      data: toMap(), // return a user object in Map format
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'mobileNumber': mobileNumber,
    };
  }
}
