import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/preferences_cache/preferences.dart';

final appPreferencesProvider = StateProvider<AppPreferences>((ref) {
  return preferences;
});