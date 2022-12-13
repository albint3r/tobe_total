// Imports
// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/preferences/preferences.dart';

// SQL & SupaBase
import 'data_base/db.dart'; // TODO find a way to use this in the [STATE Management]
// Project Paths
import 'my_app.dart';

void main() async {
  // This ensure the initialization of the DB
  WidgetsFlutterBinding.ensureInitialized();
  // Check if [Not] Exist yet [tobe_total.db]
  LocalDataBase.ifNotExistCreateInitialDataBaseInDevice();
  // Set the initial preference of the users.
  preferences.initPrefs();
  // Check in [SQLite] if the exit at least one [user]. And add the info th [preferences]
  preferences.initExistUserProfile(await LocalDataBase.existUserProfile());

  runApp(ProviderScope(
    child: MyApp(),
  ));
}
