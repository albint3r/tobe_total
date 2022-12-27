// Imports
import 'package:tobe_total/src/data_base/db.dart';
import 'package:tobe_total/src/providers/forms/sex/sex_provider.dart';

class Client extends LocalDataBase {
  int id = 1;
  String name = '';
  String lastName = '';
  String email = '';
  bool sex = true;
  int age = -1;
  int weight = -1;
  int height = -1;
  int level = 0;
  int timeToTrain = 0;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  bool haveLesion = false;
  int totalPull = 0;
  int totalPush = 0;
  int totalBend = 0;
  int totalSquat = 0;
  int goal = 0;

  void setTrainingDaysInState(String dayName, bool value) {
    dayName = dayName.toLowerCase();
    switch (dayName) {
      case 'monday':
        {
          monday = value;
          print(monday);
        }
        break;
      case 'tuesday':
        {
          tuesday = value;
          print(tuesday);
        }
        break;
      case 'wednesday':
        {
          wednesday = value;
          print(wednesday);
        }
        break;
      case 'thursday':
        {
          thursday = value;
          print(thursday);
        }
        break;
      case 'friday':
        {
          friday = value;
          print(friday);
        }
        break;
      case 'saturday':
        {
          saturday = value;
          print(saturday);
        }
        break;
      case 'sunday':
        {
          sunday = value;
          print(sunday);
        }
        break;
    }
  }

  void setLevelFieldInState(int indexLevel) {
    // Set the level state.
    /* The reason this get only the value of the leve is because
    another method of the provider [levelManagerProvider] manage the parse. */
    level = indexLevel;
  }

  void setGoalFieldInState(int indexGoal) {
    // Set the level state.
    /* The reason this get only the value of the leve is because
    another method of the provider [levelManagerProvider] manage the parse. */
    goal = indexGoal;
  }

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
      case 'time to train':
        {
          timeToTrain = int.parse(value);
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

  Map<String, Object> toMap() {
    // Create a map of the data in the cliente.
    return {
      'name': name,
      'last_name': lastName,
      'email': email,
      'sex': sex,
      'age': age,
      'weight': weight,
      'height': height,
      'level': level,
      'time_to_train': timeToTrain,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
      'goal':goal
    };
  }

  Map<String, Object> selectFieldsToUpdate(List selectedFields) {
    // Select just the values that would be updated
    // The field name must be exactly.
    final copiedClientMap = toMap();
    Map<String, Object> resultSelectedFields = {};
    for (var field in selectedFields) {
      // Extract the value inside the field
      print(field);
      resultSelectedFields[field] = copiedClientMap[field]!;
    }
    print('-----VALUES TO SUBMIT------');
    print(resultSelectedFields);
    return resultSelectedFields;
  }

  Future<List<Map<String, Object?>>> getTotalTrainingDays() async {
    // Return a list with a Map with ONE VALUE. This is the goal of the client
    // of the total days he wants to train.
    String query = 'SELECT SUM(monday + tuesday + wednesday + thursday + friday + saturday) as total_training_days FROM users';
    return rawQuery(query);
  }

  Future<void> updateUser(List selectedFields) async {
    // Update the information of the User
    print('------updateUser--------');
    print(selectFieldsToUpdate(selectedFields));
    update('users', selectFieldsToUpdate(selectedFields));
  }

  Future<List<Map<String, Object?>>> getProfile() async {
    // Get the profile of the user.
    return getAll('users');
  }

}
