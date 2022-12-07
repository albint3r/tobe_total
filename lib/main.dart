// Imports
// System
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
// Flutter
import 'package:flutter/material.dart';
// SQL & SupaBase
import 'package:supabase_flutter/supabase_flutter.dart';
// Project Paths
import 'db.dart';
import 'my_app.dart';


void main() async {
  // This ensure the initialization of the DB
  WidgetsFlutterBinding.ensureInitialized();
  // Check if [Not] Exist yet [tobe_total.db]
  DataBaseTobeTotal.ifNotExistCreateInitialDataBaseInDevice();
  // Wait to connect with the local DataBase
  print(await DataBaseTobeTotal.getMyMovements());
  runApp(const MyApp());
}

