abstract class StringValidator {
  bool isNotEmpty(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isNotEmpty(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
  final String nonEmptyTextFieldErrorText = "Cannot be empty";
}

class PromoTextFormValidatory {}
