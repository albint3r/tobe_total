import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferences = _AppPreferences();
// TODO -> [preferences] Change RAW preferences for the state in:
// main
// settings_apariences

class _AppPreferences {
  late SharedPreferences prefs;

  // Set the init state of the preferences
  Future<void> initPrefs() async =>
      prefs = await SharedPreferences.getInstance();

  Future<void> initExistUserProfile(bool existUserProfile) async =>
      setBoolPreference('existUserProfile', existUserProfile);

  // Check if the Bool preference exist if not return [False]
  bool getBoolPreference(String nameMode) => prefs.getBool(nameMode) ?? false;

  // Save the preferences of the preference.
  void setBoolPreference(String mode, bool state) => prefs.setBool(mode, state);
}

final appPreferencesProvider = Provider<_AppPreferences>((ref) {
  return preferences;
});
