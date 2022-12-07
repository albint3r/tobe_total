// Imports
// System
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
// SQLite DataBase
import 'package:sqflite/sqflite.dart'; //Smart phones
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Linux & Windows


abstract class DataBaseTobeTotal {

  static bool isDeviceSmartPhone() {
    // If the device is [Android] or [IOS] return True
    if(Platform.isAndroid || Platform.isIOS) {
      return true;
    }
    // Normally Desktop or Linux
    return false;
  }

  static void ifNotExistCreateInitialDataBaseInDevice() async {
    // If the Initial DataBase Don't exist it will created in the
    // client device. This [copy] the document inside the "assets/tobe_total.db"
    Directory deviceDocumentsPath = await getApplicationDocumentsDirectory();
    File file = File('${deviceDocumentsPath.path}/tobe_total.db');
    if (!await file.exists()) {
      ByteData dbLocation = await rootBundle.load('assets/tobe_total.db');
      await file.writeAsBytes(
              dbLocation.buffer.asUint8List(dbLocation.offsetInBytes,
              dbLocation.lengthInBytes)
      );
      print('[Local] DataBase Copied to [device Documents] successfully');
    } else {
      print('Device already have the [tobe_total.db] installed');
    }

  }

  static Future<Database> openDB() async {
    // Open the DataBase or Create if the user don't have it.
    // Check if the [device] is [NOT] a [smart phone].
    if(!isDeviceSmartPhone()) {
      // Initialize the [Windows] & [Linux] DataBase
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      print('Initialize the Windows || Linux DataBase');
    }
    // Get the document File Path location to use the DataBase.
    Directory deviceDocumentsPath = await getApplicationDocumentsDirectory();
    return await databaseFactory.openDatabase('${deviceDocumentsPath.path}/tobe_total.db');
  }

  // TODO THIS METHOD IS AN EXAMPLE OF HOW WORKS, BUT THIS MUST BE IMPLEMENTED
  // IN THE MODELS FOLDER WHIT THE STATE MACHINE.
  static dynamic getMyMovements() async {
    var db = await openDB();
    return await db.rawQuery('SELECT * FROM my_movements');
  }

}