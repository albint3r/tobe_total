class ConstantsUrls {
  // static String home = '/';
  static String signIn = 'sign_in';
  static String progress = 'progress';
  static String trainingPlan = 'training_plan';
  static String myMoves = 'my_moves';
  static String settingsMenu = 'settings_menu';
  static String updateAthleteProfile = 'update_athlete_profile';

  static String getScreenOfIndex(int index) {
    // This returns the [routName] depending of the index of the [Nav Menu]
    Map<int, String> menuRoutes = {
      0: progress,
      1: trainingPlan,
      2: myMoves,
      3: settingsMenu
    };
    return menuRoutes[index]!;
  }
}
