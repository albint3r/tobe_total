import 'package:flutter/material.dart';
import 'package:tobe_total/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppRoutes routes = AppRoutes(context: context);
    return MaterialApp(
        title: 'To be Total',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        routes: Routes.getScreens(context));
  }
}


