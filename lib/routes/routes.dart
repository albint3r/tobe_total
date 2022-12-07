import '../screens/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> getScreens(
      BuildContext context) {
    /// Return a Map with all the Routes Screens Location.
    /// Parameters:
    /// ------------
    /// BuildContext context:
    /// Is responsible to bind the context with the Screen.
    return {
      '/': (context) => const HomePage(),
    };
  }
}
