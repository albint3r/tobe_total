// Imports
// System
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

// SQLite DataBase
import 'package:sqflite/sqflite.dart'; //Smart phones
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Linux & Windows

class LocalDataBase {
  static bool isDeviceSmartPhone() {
    // If the device is [Android] or [IOS] return True
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    }
    // Normally Desktop or Linux
    return false;
  }

  static Future<bool> existUserProfile() async {
    // Verify if exist a [user] in the [DataBase].
    // Also, this is a patch to solve the main form. This helps to add
    // the value to the [preferences_cache]. So, if you have problems check that area.
    var db = await LocalDataBase.openDB();
    List<Map<String, Object?>> response =
        await db.rawQuery('SELECT * FROM users');
    return response.isNotEmpty;
  }

  static void ifNotExistCreateInitialDataBaseInDevice() async {
    // If the Initial DataBase Don't exist it will created in the
    // client device. This [copy] the document inside the "assets/tobe_total.db"
    Directory deviceDocumentsPath = await getApplicationDocumentsDirectory();
    File file = File('${deviceDocumentsPath.path}/tobe_total.db');
    if (!await file.exists()) {
      // Get the file Location in the project to copy.
      ByteData dbLocation = await rootBundle.load('assets/tobe_total.db');
      // Write the project into a local DataBase
      await file.writeAsBytes(dbLocation.buffer
          .asUint8List(dbLocation.offsetInBytes, dbLocation.lengthInBytes));
      // check if Android copied correctly the Db
      await LocalDataBase.notCopiedInMobil();
      if (await LocalDataBase.notCopiedInMobil()) {
        print("The DB wasn't copied to the device.");
        /* TODO THIS IF STATEMENT WAS CREATE TO CREATE THE MISSING TABLES
        but after create this if statement the problem solves.
        apparently load the db before end the process helps to create the tables.
        If the problem persist in the future it will be good idea to
        create manually the tables and load all the [fitness_moves]*/
      }
      print('[Local] DataBase Copied to [device Documents] successfully');
    } else {
      print('Device already have the [tobe_total.db] installed');
    }
  }

  static Future<bool> notCopiedInMobil() async {
    // Check if Android create correctly copied the [LocalDataBase]
    // if this is correct it will trow a list with dict with all the tables.
    // Otherwise it will trow -> [{name: android_metadata}]
    // This is the expected -> [{name: fitness_moves}, {name: my_movements}, ... },
    // This just have one element or a empty list of tables.
    Database db = await LocalDataBase.openDB();
    List<Map> response = await db.rawQuery("SELECT name FROM sqlite_master");
    return response.length > 2;
  }

  static Future<Database> openDB() async {
    // Open the DataBase or Create if the user don't have it.
    // Check if the [device] is [NOT] a [smart phone].
    if (!isDeviceSmartPhone()) {
      // Initialize the [Windows] & [Linux] DataBase
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      print('Initialize on Windows || Linux DataBase');
    } else {
      print('Initialize Android || IOS DataBase');
    }
    // Get the document File Path location to use the DataBase.
    Directory deviceDocumentsPath = await getApplicationDocumentsDirectory();
    return await databaseFactory
        .openDatabase('${deviceDocumentsPath.path}/tobe_total.db');
  }

  // TODO THIS METHOD IS AN EXAMPLE OF HOW WORKS, BUT THIS MUST BE IMPLEMENTED
  // IN THE MODELS FOLDER WHIT THE STATE MACHINE.
  Future<List<Map<String, Object?>>> getAll(String tableName) async {
    var db = await openDB();
    return await db.rawQuery('SELECT * FROM $tableName');
  }

  Future<List<Map<String, Object?>>> rawQuery(String query) async {
    // This Method is used when the Model can make a query without special conditions.
    Database db = await openDB();
    return await db.rawQuery(query);
  }

  Future<List<Map<String, Object?>>> getFiltered(
      String tableName, String column, String condition) async {
    var db = await openDB();
    return await db
        .rawQuery('SELECT * FROM $tableName WHERE $column = $condition');
  }

  Future<bool> isAny(String tableName) async {
    // Return [true] if exist at least one value or more in the table.
    Database db = await openDB();
    List<Map<String, Object?>> response =
        await db.rawQuery('SELECT * FROM $tableName');
    return response.isNotEmpty;
  }

  String createColumnInsertQuery(Map<String, Object> columnsValues) {
    // Crate the format depending of the value to insert in SQLite
    List listQueries = [];
    for (var col in columnsValues.keys) {
      String columnQuery;
      var tempValue = columnsValues[col];

      if (tempValue is String) {
        columnQuery = " $col = '${columnsValues[col]}'";
      } else if (tempValue is bool) {
        columnQuery = ' $col = ${columnsValues[col].toString().toUpperCase()}';
      } else {
        columnQuery = " $col = ${columnsValues[col]}";
      }

      listQueries.add(columnQuery);
    }
    return listQueries.join(',');
  }

  Future<void> add(String tableName, String columns, String values) async {
    // Add Values to the table selected
    var db = await openDB();
    await db.rawQuery('INSERT INTO $tableName ($columns) VALUES ($values); SELECT last_insert_rowid();');
    print('----------NEW ROW ADDED--------------------');
    print('INSERT INTO $tableName ($columns) VALUES ($values);');
    print('ADD NEW VALUE TO DB');
  }

  Future<void> update(
      String tableName, Map<String, Object> columnsValues) async {
    var db = await openDB();
    String columnsQuery = createColumnInsertQuery(columnsValues);
    await db.rawQuery('UPDATE $tableName SET $columnsQuery WHERE id = 1;');
  }

  /// Returns a `Future` that contains a list of maps, where each map represents a row in a database table.
  /// The function executes a raw SQL `SELECT` statement using the `rawQuery()` method, which returns the last inserted row id.
  Future<List<Map<String, Object?>>> getLastId() async {
    return await rawQuery('SELECT last_insert_rowid()');
  }
}
