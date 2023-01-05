import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/update_biometrics.dart';
import '../features/block_plan_manage/presentation/block_plan_screen.dart';
import '../features/configurate_athlete_profile/presentation/settings_menu_screen.dart';
import '../features/my_movements_manager/my_movements_screen.dart';
import '../features/progress/progress_screen.dart';
import '../features/sign_in_and_update//presentation/sign_in.dart';
import '../features/sign_in_and_update/presentation/update_athlete_goal.dart';
import '../features/sign_in_and_update/presentation/update_general_info.dart';
import '../features/sign_in_and_update/presentation/update_training_itinerary.dart';
import '../features/training_week_calendar/presentation/training_calendar_screen.dart';
import '../features/wod_plan_manage/presentation/wod_plan_screen.dart';
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
      ConstantsUrls.settingsMenu: (context) => const SettingsMenu(),
      ConstantsUrls.updateGeneralInformation: (context) => const UpdateGeneralInformation(),
      ConstantsUrls.updateBiometrics: (context) => const UpdateBiometrics(),
      ConstantsUrls.updateTrainingItinerary: (context) => const UpdateTrainingItinerary(),
      ConstantsUrls.updateAthleteGoal: (context) => const UpdateAthleteGoal(),
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

