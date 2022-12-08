// Imports
// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// SQL & SupaBase
import 'db.dart'; // TODO find a way to use this in the [STATE Management]
// Project Paths
import 'my_app.dart';

void main() async {
  // This ensure the initialization of the DB
  WidgetsFlutterBinding.ensureInitialized();
  // Check if [Not] Exist yet [tobe_total.db]
  LocalDataBase.ifNotExistCreateInitialDataBaseInDevice();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
