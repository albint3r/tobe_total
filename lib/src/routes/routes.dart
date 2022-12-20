import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/sign_in_and_update/presentation/update_biometrics.dart';
import '../features/configurate_athlete_profile/presentation/settings_menu_screen.dart';
import '../features/sign_in_and_update//presentation/sign_in.dart';
import '../features/progress/progress.dart';
import '../features/sign_in_and_update/presentation/update_athlete_goal.dart';
import '../features/sign_in_and_update/presentation/update_general_info.dart';
import '../features/sign_in_and_update/presentation/update_training_itinerary.dart';
import '../features/training_plan_manage/presentation/training_plan_screen.dart';
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
      ConstantsUrls.trainingPlan: (context) => const TrainingPlanScreen(),
      ConstantsUrls.settingsMenu: (context) => const SettingsMenu(),
      ConstantsUrls.updateGeneralInformation: (context) => const UpdateGeneralInformation(),
      ConstantsUrls.updateBiometrics: (context) => const UpdateBiometrics(),
      ConstantsUrls.updateTrainingItinerary: (context) => const UpdateTrainingItinerary(),
      ConstantsUrls.updateAthleteGoal: (context) => const UpdateAthleteGoal(),
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

