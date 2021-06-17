class ValidationMixin {
  String nameValidator(String value) {
    if (value.isNotEmpty && value.length > 4) {
      return null;
    }
    return "Field must be at least 4 characters";
  }

  String passcodeValidator(String value) {
    if (value.length > 5) {
      return null;
    }
    return "Password need to be at least 6 characters";
  }

  String numberNonNegativeValidator(String value) {
    final amount = double.tryParse(value) ?? 0;
    if (amount >= 0) {
      return null;
    }
    return "This is not a valid number. Please only enter numbers.";
  }

  String discountPercentValidator(String value) {
    double amount = double.tryParse(value);
    amount = amount / 100;
    if (amount > 0 && amount < 1) {
      return null;
    }
    return "Please only enter numbers. Eg enter 5 for 5% discount";
  }
}
