// Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/data_base/db.dart';
import 'package:tobe_total/src/features/sign_in_and_update/controllers/sex_provider.dart';

class Client extends LocalDataBase {
  String name = '';
  String lastName = '';
  String email = '';
  int age = -1;
  int weight = -1;
  int height = -1;
  bool sex = true;

  void setFieldValueInState(String typeValue, String value) {
    // Set the values in the field form to their respective attributes
    // This helps to send the information to SQLite
    // We need to convert in lower case to avoid possible errors
    typeValue = typeValue.toLowerCase();
    switch (typeValue) {
      case 'name':
        {
          name = value.trim();
        }
        break;
      case 'last name':
        {
          lastName = value.trim();
        }
        break;
      case 'email':
        {
          email = value.toLowerCase().trim();
        }
        break;
      case 'age':
        {
          age = int.parse(value);
        }
        break;
      case 'weight':
        {
          weight = int.parse(value);
        }
        break;
      case 'height':
        {
          height = int.parse(value);
        }
        break;
    }
  }

  void setSex(Sex value) {
    if (value == Sex.male) {
      sex = true;
    } else {
      sex = false;
    }
    print(sex);
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

  Future<void> updateUser() async {
    // Update the information of the User
    update('users', {
      'name': name,
      'last_name': lastName,
      'email': email,
      'sex': sex,
      'age': age,
      'weight': weight,
      'height': height
    });
  }

  Future<List<Map<String, Object?>>> getProfile() async {
    // Get the profile of the user.
    return getAll('users');
  }
}

final clientProvider = Provider<Client>((ref) {
  return Client();
});

final futureClientProfileProvider =
    FutureProvider.autoDispose<Map<String, Object?>>((ref) async {
  // Return the User Profile Info
  final Client client = ref.watch(clientProvider);
  List<Map<String, Object?>> response = await client.getProfile();
  Map<String, Object?> clientProfile = response[0];
  return clientProfile;
});
