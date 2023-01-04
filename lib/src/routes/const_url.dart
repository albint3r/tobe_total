class ConstantsUrls {
  // The ConstantsUrls class is a utility class that stores the screen routes
  // used in the application. It contains a series of constants that represent
  // the different screen routes and a method that returns the screen route
  // for a specific index.
  //
  // This class is used to provide a centralized access point to the screen
  // routes and to facilitate the updating and maintenance of the screen
  // routes in the application.

  // static String home = '/';
  static String signIn = 'sign_in_and_update';
  static String progress = 'progress';
  static String trainingPlan = 'training_plan';
  static String wodPlan = 'wod_plan';
  static String blockPlan = 'block_plan';
  static String myMoves = 'my_moves';
  static String settingsMenu = 'settings_menu';
  static String updateGeneralInformation = 'update_general_information';
  static String updateBiometrics = 'update_biometrics';
  static String updateTrainingItinerary = 'update_training_itinerary';
  static String updateAthleteGoal = 'update_athlete_goal';

  /// Return the screen route of the specified index.
  ///
  /// This returns the [routName] depending on the index of the [Nav Menu].
  static String getScreenOfIndex(int index) {
    Map<int, String> menuRoutes = {
      0: progress,
      1: trainingPlan,
      2: myMoves,
      3: settingsMenu
    };
    return menuRoutes[index]!;
  }
}
