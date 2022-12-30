// Imports
import 'package:tobe_total/src/data_base/db.dart';
import 'package:tobe_total/src/providers/forms/sex/sex_provider.dart';

class Client extends LocalDataBase {
  Client() {
    _initState();
  }

  int id = 1;
  String name = '';
  String lastName = '';
  String email = '';
  bool sex = true;
  int age = -1;
  double weight = -1.0;
  double height = -1.0;
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
  int lesionArea = 0;
  int totalPull = 0;
  int totalPush = 0;
  int totalBend = 0;
  int totalSquat = 0;
  int goal = 0;

  bool noEquipment = true;
  bool dumbbells = false;
  bool kettlebells = false;
  bool bench = false;
  bool barbell = false;
  bool weightMachinesSelectorized = false;
  bool resistanceBandsCables = false;
  bool leggings = false;
  bool medicineBall = false;
  bool stabilityBall = false;
  bool ball = false;
  bool trx = false;
  bool raisedPlatformBox = false;
  bool box = false;
  bool rings = false;
  bool pullUpBar = false;
  bool parallelsBar = false;
  bool wall = false;
  bool pole = false;
  bool trineo = false;
  bool rope = false;
  bool wheel = false;
  bool assaultBike = false;


  Future<void> _initState() async {
    // Set the values in the DataBase in the User Object.
    if (await isAny('users')) {
      final List<Map<String, Object?>> response = await getAll('users');
      final Map<String, Object?> _user = response[0];
      name = _user['name'] as String;
      lastName = _user['last_name'] as String;
      email = _user['email'] as String;
      // if is 1 is true / 0 is false
      sex = _user['sex'] == null
          ? true
          : _user['sex'] == 1
              ? true
              : false;
      // if Age is Null it will -> 0
      age = _user['age'] == null ? 0 : _user['age'] as int;
      weight = _user['weight'] as double;
      height = _user['height'] as double;
      level = _user['level'] as int;
      timeToTrain = _user['time_to_train'] as int;
      monday = _user['monday'] as int == 1 ? true : false;
      tuesday = _user['tuesday'] as int == 1 ? true : false;
      wednesday = _user['wednesday'] as int == 1 ? true : false;
      thursday = _user['thursday'] as int == 1 ? true : false;
      friday = _user['friday'] as int == 1 ? true : false;
      saturday = _user['saturday'] as int == 1 ? true : false;
      sunday = _user['sunday'] as int == 1 ? true : false;
      haveLesion = _user['have_lesion'] as int == 1 ? true : false;
      lesionArea = _user['lesion_area'] as int;
      totalPull = _user['total_pull'] as int;
      totalPush = _user['total_push'] as int;
      totalBend = _user['total_bend'] as int;
      totalSquat = _user['total_squat'] as int;
      goal = _user['goal'] as int;
      // Equipment
      noEquipment = _user['no_equipment'] as int == 1 ? true : false;
      dumbbells = _user['dumbbells'] as int == 1 ? true : false;
      kettlebells = _user['kettlebells'] as int == 1 ? true : false;
      bench = _user['bench'] as int == 1 ? true : false;
      barbell = _user['barbell'] as int == 1 ? true : false;
      weightMachinesSelectorized =
          _user['weight_machines_selectorized'] as int == 1 ? true : false;
      resistanceBandsCables =
          _user['resistance_bands_cables'] as int == 1 ? true : false;
      leggings = _user['leggings'] as int == 1 ? true : false;
      medicineBall = _user['medicine_ball'] as int == 1 ? true : false;
      stabilityBall = _user['stability_ball'] as int == 1 ? true : false;
      ball = _user['ball'] as int == 1 ? true : false;
      trx = _user['trx'] as int == 1 ? true : false;
      raisedPlatformBox =
          _user['raised_platform_box'] as int == 1 ? true : false;
      box = _user['box'] as int == 1 ? true : false;
      rings = _user['rings'] as int == 1 ? true : false;
      pullUpBar = _user['pull_up_bar'] as int == 1 ? true : false;
      parallelsBar = _user['parallels_bar'] as int == 1 ? true : false;
      wall = _user['wall'] as int == 1 ? true : false;
      pole = _user['pole'] as int == 1 ? true : false;
      trineo = _user['trineo'] as int == 1 ? true : false;
      rope = _user['rope'] as int == 1 ? true : false;
      wheel = _user['wheel'] as int == 1 ? true : false;
      assaultBike = _user['assault_bike'] as int == 1 ? true : false;
    }
  }

  void setTrainingDaysInState(String dayName, bool value) {
    // From the [DayCheckBoxField] send the new state of the clicked button
    // in the select list form.
    print('func -> [setTrainingDaysInState]');
    dayName = dayName.toLowerCase();
    switch (dayName) {
      case 'monday':
        {
          monday = value;
          print(dayName);
          print(monday);
        }
        break;
      case 'tuesday':
        {
          tuesday = value;
          print(dayName);
          print(tuesday);
        }
        break;
      case 'wednesday':
        {
          wednesday = value;
          print(dayName);
          print(wednesday);
        }
        break;
      case 'thursday':
        {
          thursday = value;
          print(dayName);
          print(thursday);
        }
        break;
      case 'friday':
        {
          friday = value;
          print(dayName);
          print(friday);
        }
        break;
      case 'saturday':
        {
          saturday = value;
          print(dayName);
          print(saturday);
        }
        break;
      case 'sunday':
        {
          sunday = value;
          print(dayName);
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
          weight = double.parse(value);
        }
        break;
      case 'height':
        {
          height = double.parse(value);
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
    // Create a map of the data in the client.
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
      'goal': goal
    };
  }

  Future<Map<String, Object?>> trainingDayMap() async {
      String query = 'SELECT monday, tuesday, wednesday, thursday, friday, saturday, sunday FROM users WHERE id= 1';
      List<Map<String, Object?>> response = await rawQuery(query);
      return response[0];
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
    String query =
        'SELECT SUM(monday + tuesday + wednesday + thursday + friday + saturday) as total_training_days FROM users';
    return rawQuery(query);
  }

  Future<Map<String, Object?>> getEquipment() async {
    // Return a Dictionary with the Equipment of the Client
    String query ="SELECT no_equipment, dumbbells, kettlebells, bench, barbell, weight_machines_selectorized, resistance_bands_cables, leggings, medicine_ball, stability_ball, ball, trx, raised_platform_box, box, rings, pull_up_bar, parallels_bar, wall, pole, trineo, rope, wheel, assault_bike FROM users WHERE id = 1;";
    final response = await rawQuery(query);
    return response[0];
  }

  Future<List<Map<String, Object?>>> getTotaTrainingTime() async {
    String query = 'SELECT time_to_train FROM users WHERE id= 1';
    return rawQuery(query);
  }

  Future<void> updateUser(List selectedFields) async {
    // Update the information of the User
    print('------TO UPDATE USER INFORMATION--------');
    print(selectFieldsToUpdate(selectedFields));
    update('users', selectFieldsToUpdate(selectedFields));
  }

  Future<void> updateTrainingDaysToNoobs() async {
    // Update the training days for the noobs
    // This client would have 3 days only to train full body.
    update('users', {
      'monday': true,
      'tuesday': false,
      'wednesday': true,
      'thursday': false,
      'friday': true,
      'saturday': false,
      'sunday': false,
    });
  }

  Future<List<Map<String, Object?>>> getProfile() async {
    // Get the profile of the user.
    return getAll('users');
  }
}
