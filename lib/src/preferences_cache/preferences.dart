import 'package:shared_preferences/shared_preferences.dart';

final preferences = AppPreferences();

/// This class handles all the SharedPreferences related functionality
class AppPreferences {
  late SharedPreferences prefs;

  /// Initializes the SharedPreferences object
  Future<void> initPrefs() async =>
      prefs = await SharedPreferences.getInstance();

  /// Saves the user profile preferences
  Future<void> initExistUserProfile(bool existUserProfile) async =>
      setBoolPreference('existUserProfile', existUserProfile);

  /// Retrieves the value of the given preference,
  /// returns false if it does not exist
  bool getBoolPreference(String nameMode) => prefs.getBool(nameMode) ?? false;

  /// Saves the given preference with the given state
  void setBoolPreference(String mode, bool state) => prefs.setBool(mode, state);
}


