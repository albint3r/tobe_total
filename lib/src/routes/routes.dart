import 'package:flutter/material.dart';
import 'package:tobe_total/src/screens/forms/update_biometrics.dart';
import '../screens/block_plan_screen.dart';
import '../screens/forms/update_athlete_level.dart';
import '../screens/forms/update_equipment.dart';
import '../screens/settings_menu_screen.dart';
import '../screens/my_movements_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/forms/sign_in.dart';
import '../screens/forms/update_athlete_goal.dart';
import '../screens/forms/update_general_info.dart';
import '../screens/forms/update_training_itinerary.dart';
import '../screens/training_calendar_screen.dart';
import '../screens/training_timer_screen.dart';
import '../screens/wod_plan_screen.dart';
import 'const_url.dart';

class Routes {
  /// Return a Map with all the Routes Screens Location.
  ///
  /// The map key is the route name, and the value is a function that returns
  /// a widget.
  ///
  /// [context] is responsible to bind the context with the screen.

  Map<String, Widget Function(BuildContext)> getScreens(BuildContext context) {
    return {
      ConstantsUrls.progress: (context) => const Progress(),
      ConstantsUrls.signIn: (context) => const SignIn(),
      ConstantsUrls.trainingPlan: (context) => const TrainingCalendarScreen(),
      ConstantsUrls.wodPlan: (context) => const WODPlanScreen(),
      ConstantsUrls.blockPlan: (context) => const BlockPlanScreen(),
      ConstantsUrls.myMoves: (context) => const MyMovementsScreen(),
      ConstantsUrls.trainingTimer: (context) => const TrainingTimerScreen(),
      ConstantsUrls.settingsMenu: (context) => const SettingsMenu(),
      ConstantsUrls.updateGeneralInformation: (context) => const UpdateGeneralInformation(),
      ConstantsUrls.updateBiometrics: (context) => const UpdateBiometrics(),
      ConstantsUrls.updateTrainingItinerary: (context) => const UpdateTrainingItinerary(),
      ConstantsUrls.updateAthleteGoal: (context) => const UpdateAthleteGoal(),
      ConstantsUrls.updateEquipment: (context) => const UpdateAthletEquipment(),
      ConstantsUrls.updateLevel: (context) => const UpdateAthleteLevel(),
    };
  }

  /// Navigate to the specified route.
  ///
  /// [context] is responsible to bind the context with the screen.
  ///
  /// If [urlRoute] is not provided, the default route '/' is used.
  navigateTo(BuildContext context, [String urlRoute = '/']) {
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
  /// Return the screen route of the specified index in the Bottom Bar Nav
  String getScreenOfIndex(int index) {
    return ConstantsUrls.getScreenOfIndex(index);
  }
}

