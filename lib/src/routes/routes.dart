import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/homepage/home_page.dart';
import 'package:flutter/material.dart';
import '../features/sign_in/presentation/sign_in.dart';

class Routes {
  Map<String, Widget Function(BuildContext)> getScreens(
      BuildContext context) {
    /// Return a Map with all the Routes Screens Location.
    /// Parameters:
    /// ------------
    /// BuildContext context:
    /// Is responsible to bind the context with the Screen.
    return {
      'home': (context) => const HomePage(),
      'sign_in':(context) => const SignIn(),
    };
  }

  navigateTo(BuildContext context, [String urlRoute = '/']) {
    // Enable to navigate between screens.
    Navigator.pushNamed(context, urlRoute);
  }

}

final routesProvider = Provider<Routes>((ref) {
  return Routes();
});
