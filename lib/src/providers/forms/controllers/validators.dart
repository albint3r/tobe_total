import 'package:flutter_riverpod/flutter_riverpod.dart';

final formValidatorsProvider = Provider<FormValidators>((ref) {
  return FormValidators();
});

class FormValidators {
  bool isNotValidEmail(String? fieldValue) {
    // Return true if the user don't have a correct email
    if (fieldValue != null) {
      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return !emailRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  bool isNotValidName(String? fieldValue) {
    // Check if the name is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r"[a-zA-Z0-9_]{3,20}");
      return !nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  bool isNotValidInteger(String? fieldValue) {
    // Check if the Age is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r"[^-0-9\/]+");
      return nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }

  bool isNotMultipleOfFive(String? fieldValue) {
    // Check if the Age is validated
    if (fieldValue != null) {
      try{
        return int.parse(fieldValue) % 5 != 0;
      } catch(e) {
        print('[isMultipleOfFive error] -> $e');
        return true;
      }
    }
    return true;
  }

  bool isNotValidDouble(String? fieldValue) {
    // Check if the Age is validated
    if (fieldValue != null) {
      final nameRegExp = RegExp(r'^\d*\.\d*$');
      return !nameRegExp.hasMatch(fieldValue);
    }
    return false;
  }
}
