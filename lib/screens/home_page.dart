import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tobe_total/db.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // void runDB() async {
  //   var db = await DB.openDB();
  //   print('------  openDB  -------');
  //   print(await db.rawQuery("SELECT * FROM user"));
  // }

  @override
  Widget build(BuildContext context) {
    // runDB();
    return const Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}