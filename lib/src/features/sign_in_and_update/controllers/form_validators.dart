class FormValidators {
  static bool isNotValidEmail(String? fieldValue) {
    // Return true if the user don't have a correct email
    if (fieldValue != null) {
      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return !emailRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  static bool isNotValidName(String? fieldValue) {
    // Check if the name is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r"[A-Z][a-z0-9_]{3,20}");
      return !nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  static bool isNotValidInteger(String? fieldValue) {
    // Check if the Age is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r"[0-9]{1,2}");
      return !nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }
}
