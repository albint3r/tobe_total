// Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobe_total/src/data_base/db.dart';

class Client extends LocalDataBase {
  String name = '';
  String lastName = '';
  String email = '';

  void setFieldValueInState(String typeValue, String value) {
    // Set the values in the field form to their respective attributes
    // This helps to send the information to SQLite
    // We need to convert in lower case to avoid possible errors
    typeValue = typeValue.toLowerCase();
    switch (typeValue) {
      case 'name':
        {
          name = value;
        }
        break;
      case 'last name':
        {
          lastName = value;
        }
        break;
      case 'email':
        {
          email = value;
        }
        break;
    }
  }

  Future<bool> isUserExist() async {
    // Check if exist any user in the database
    return await isAny('users');
  }

  Future<void> createNewUser() async {
    // Create a new User in the SQLite
    add('users', 'name, last_name, email', "'$name', '$lastName', '$email'");
    // change the user status existences
  }
}

final clientProvider = Provider<Client>((ref) {
  return Client();
});
