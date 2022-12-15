import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../features/configurate_athlete_profile/presentation/settings_menu.dart';
import '../features/sign_in/presentation/sign_in.dart';
import '../features/progress/progress.dart';
import '../features/sign_in/presentation/update_athlete_profile.dart';
import 'const_url.dart';

class Routes {
  Map<String, Widget Function(BuildContext)> getScreens(BuildContext context) {
    /// Return a Map with all the Routes Screens Location.
    /// Parameters:
    /// ------------
    /// BuildContext context:
    /// Is responsible to bind the context with the Screen.
    return {
      ConstantsUrls.progress: (context) => const Progress(),
      ConstantsUrls.signIn: (context) => const SignIn(),
      ConstantsUrls.settingsMenu: (context) => const SettingsMenu(),
      ConstantsUrls.updateAthleteProfile: (context) => const UpdateAthleteProfile(),
    };
  }

  navigateTo(BuildContext context, [String urlRoute = '/']) {
    // Enable to navigate between screens.

    Map<String, Widget Function(BuildContext)> screens = getScreens(context);
    var screen = screens[urlRoute];
    Widget endPoint = screen!(context);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => endPoint,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  String getScreenOfIndex(int index) {
    return ConstantsUrls.getScreenOfIndex(index);
  }
}

final routesProvider = Provider<Routes>((ref) {
  return Routes();
});
