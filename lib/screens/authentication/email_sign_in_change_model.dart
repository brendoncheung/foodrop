import 'package:flutter/foundation.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';

import 'validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel(
      {@required this.auth,
      this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false,
      this.preferredName = "",
      this.fullName = "",
      this.phoneNumber = ""});
  final AuthenticationService auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  String fullName;
  String preferredName;
  String phoneNumber;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.logInUserWithEmailAndPassword(email, password);
      } else {
        await auth.createClientWithEmailAndPassword(email, password);
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

  void updateFullName(String fullName) => updateWith(fullName: fullName);

  void updatePreferredName(String preferredName) =>
      updateWith(preferredName: preferredName);

  void updatePhoneNumber(String phoneNumber) =>
      updateWith(phoneNumber: phoneNumber);

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted,
      String fullName,
      String preferredName,
      String phoneNumber}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    this.fullName = fullName ?? this.fullName;
    this.preferredName = preferredName ?? this.preferredName;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    notifyListeners();
  }
}
