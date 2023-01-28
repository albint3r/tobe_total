// Imports
import 'package:tobe_total/src/providers/forms/sex/sex_provider.dart';
import '../data/db.dart';

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
      // TODO I not sure if this is the best way to solve this bug
      // may be is better to create a method to manage this.
      haveLesion = _user['have_lesion'] != null ? true : false;
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

  void setEquipment(String equipmentName, bool isSelectedEquip) {
    switch (equipmentName) {
      case ('No Equipment'):
        {
          noEquipment = isSelectedEquip;
        }
        break;
      case ('Dumbbells'):
        {
          dumbbells = isSelectedEquip;
        }
        break;
      case ('Kettlebells'):
        {
          kettlebells = isSelectedEquip;
        }
        break;
      case ('Bench'):
        {
          bench = isSelectedEquip;
        }
        break;
      case ('Barbell'):
        {
          barbell = isSelectedEquip;
        }
        break;
      case ('Weight Machines Selectorized'):
        {
          weightMachinesSelectorized = isSelectedEquip;
        }
        break;
      case ('Resistance Bands Cables'):
        {
          resistanceBandsCables = isSelectedEquip;
        }
        break;
      case ('Leggings'):
        {
          leggings = isSelectedEquip;
        }
        break;
      case ('Medicine Ball'):
        {
          medicineBall = isSelectedEquip;
        }
        break;
      case ('Stability BallProvider'):
        {
          stabilityBall = isSelectedEquip;
        }
        break;
      case ('Ball'):
        {
          ball = isSelectedEquip;
        }
        break;
      case ('TRX'):
        {
          trx = isSelectedEquip;
        }
        break;
      case ('Raised Platform Box'):
        {
          raisedPlatformBox = isSelectedEquip;
        }
        break;
      case ('Box'):
        {
          box = isSelectedEquip;
        }
        break;
      case ('Rings'):
        {
          rings = isSelectedEquip;
        }
        break;
      case ('Pull-Up Bar'):
        {
          pullUpBar = isSelectedEquip;
        }
        break;
      case ('Parallels Bar'):
        {
          parallelsBar = isSelectedEquip;
        }
        break;
      case ('Wall'):
        {
          wall = isSelectedEquip;
        }
        break;
      case ('Pole'):
        {
          pole = isSelectedEquip;
        }
        break;
      case ('Trineo'):
        {
          trineo = isSelectedEquip;
        }
        break;
      case ('Rope'):
        {
          rope = isSelectedEquip;
        }
        break;
      case ('Wheel'):
        {
          wheel = isSelectedEquip;
        }
        break;
      case ('Assault Bike'):
        {
          assaultBike = isSelectedEquip;
        }
        break;
    }
  }

  Map<String, bool> equipmentParseToDataBase() {
    return {
      'dumbbells': dumbbells,
      'kettlebells': kettlebells,
      'bench': bench,
      'barbell': barbell,
      'weight_machines_selectorized': weightMachinesSelectorized,
      'resistance_bands_cables': resistanceBandsCables,
      'leggings': leggings,
      'medicine_ball': medicineBall,
      'stability_ball': stabilityBall,
      'trx': trx,
      'raised_platform_box': raisedPlatformBox,
      'box': box,
      'rings': rings,
      'pull_up_bar': pullUpBar,
      'parallels_bar': parallelsBar,
      'wall': wall,
      'pole': pole,
      'trineo': trineo,
      'rope': rope,
      'wheel': wheel,
      'assault_bike': assaultBike,
    };
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

  /// Set the level field in the client's state
  void setLevelFieldInState(int indexLevel) {
    // The reason this get only the value of the leve is because
    // another method of the provider [levelManagerProvider] manage the parse.
    level = indexLevel;
    print('level  $level-------------------');
  }

  /// Set the goal field in the client's state
  void setGoalFieldInState(int indexGoal) {
    // The reason this get only the value of the leve is because
    // another method of the provider [levelManagerProvider] manage the parse.
    goal = indexGoal;
  }

  /// Set the value of the specified field in the client's state
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

  /// Set the client's sex in the state
  void setSex(Sex value) {
    if (value == Sex.male) {
      sex = true;
    } else {
      sex = false;
    }
  }

  /// Return a map of the client's data
  Map<String, Object> toMap() {
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

  /// Select the fields that should be updated in the database
  Map<String, Object> selectFieldsToUpdate(List selectedFields) {
    // Select just the values that would be updated
    // The field name must be exactly.
    final copiedClientMap = toMap();
    Map<String, Object> resultSelectedFields = {};
    print('-----------------------------------');
    print('Next Information Would be Update:');
    print('-----------------------------------');
    for (var field in selectedFields) {
      // Extract the value inside the field
      print('To Update -> $field');
      resultSelectedFields[field] = copiedClientMap[field]!;
    }
    print('-----------------------------------');
    return resultSelectedFields;
  }

  /// Check if a user already exists in the database
  Future<bool> isUserExist() async {
    return await isAny('users');
  }

  /// Create a new user in the SQLite database
  Future<void> createNewUser() async {
    add('users', 'name, last_name, email', "'$name', '$lastName', '$email'");
  }

  /// Create a new user in the SQLite database
  Future<void> updateInitStats() async {
    print('updateInitStats-----------------');
    Map<String, Object> columnsValues = {
      'age': age,
      'weight': weight,
      'height': height,
      'time_to_train': timeToTrain,
      'monday': monday ? 1: 0,
      'tuesday': tuesday ? 1: 0,
      'wednesday': wednesday ? 1: 0,
      'thursday': thursday ? 1: 0,
      'friday': friday ? 1: 0,
      'saturday': saturday ? 1: 0,
      'sunday': sunday ? 1: 0,
      'no_equipment': noEquipment ? 1: 0,
      'dumbbells': dumbbells ? 1: 0,
      'kettlebells': kettlebells ? 1: 0,
      'bench': bench ? 1: 0,
      'barbell': barbell ? 1: 0,
      'weight_machines_selectorized': weightMachinesSelectorized ? 1: 0,
      'resistance_bands_cables': resistanceBandsCables ? 1: 0,
      'leggings': leggings ? 1: 0,
      'medicine_ball': medicineBall ? 1: 0,
      'stability_ball': stabilityBall ? 1: 0,
      'ball': ball ? 1: 0,
      'trx': trx ? 1: 0,
      'raised_platform_box': raisedPlatformBox ? 1: 0,
      'box': box ? 1: 0,
      'rings': rings ? 1: 0,
      'pull_up_bar': pullUpBar ? 1: 0,
      'parallels_bar': parallelsBar ? 1: 0,
      'wall': wall ? 1: 0,
      'pole': pole ? 1: 0,
      'trineo': trineo ? 1: 0,
      'rope': rope ? 1: 0,
      'wheel': wheel ? 1: 0,
      'assault_bike': assaultBike ? 1: 0,
      'level': level
    };
    update('users', columnsValues, 1);
  }

  /// Return a map of the client's selected training days
  Future<Map<String, Object?>> trainingDayMap() async {
    String query =
        'SELECT monday, tuesday, wednesday, thursday, friday, saturday, sunday FROM users WHERE id= 1';
    List<Map<String, Object?>> response = await rawQuery(query);
    return response[0];
  }

  /// Return the total training days desired by the client
  Future<List<Map<String, Object?>>> getTotalTrainingDays() async {
    // Return a list with a Map with ONE VALUE. This is the goal of the client
    // of the total days he wants to train.
    String query =
        'SELECT SUM(monday + tuesday + wednesday + thursday + friday + saturday + sunday) as total_training_days FROM users';
    return rawQuery(query);
  }

  /// Return the equipments of the client
  Future<Map<String, Object?>> getEquipment() async {
    // Return a Dictionary with the Equipment of the Client
    String query =
        "SELECT no_equipment, dumbbells, kettlebells, bench, barbell, weight_machines_selectorized, resistance_bands_cables, leggings, medicine_ball, stability_ball, ball, trx, raised_platform_box, box, rings, pull_up_bar, parallels_bar, wall, pole, trineo, rope, wheel, assault_bike FROM users WHERE id = 1;";
    final response = await rawQuery(query);
    return response[0];
  }

  /// Return if exists a profile or not
  Future<bool> existProfile() async {
    return isAny('users');
  }

  /// Return the total training time desired by the client
  Future<List<Map<String, Object?>>> getTotaTrainingTime() async {
    String query = 'SELECT time_to_train FROM users WHERE id= 1';
    return rawQuery(query);
  }

  /// Update the user information
  Future<void> updateUser(List selectedFields) async {
    update('users', selectFieldsToUpdate(selectedFields), 1);
  }

  Future<void> updateUserEquipment() async {
    update('users', equipmentParseToDataBase(), 1);
  }

  /// Update the training days for the noobs
  Future<void> updateTrainingDaysToNoobs() async {
    // This client would have 3 days only to train full body.
    update(
        'users',
        {
          'monday': true,
          'tuesday': false,
          'wednesday': true,
          'thursday': false,
          'friday': true,
          'saturday': false,
          'sunday': false,
        },
        1);
  }

  // Get the profile of the user.
  Future<List<Map<String, Object?>>> getProfile() async {
    // This will be used in the controller, and only would select
    // the first user (or row). Because the only user in the DB is the
    // owner of the device.
    return getAll('users');
  }
}
