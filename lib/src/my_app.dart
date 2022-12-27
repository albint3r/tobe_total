// Imports
// Flutter
import 'package:flutter/material.dart';
// Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/theme/is_dark_mode_provider.dart';
import 'package:tobe_total/src/providers/preferences/preferences_provider.dart';
import 'package:tobe_total/src/providers/routes/routes_provider.dart';

class MyApp extends ConsumerWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = ref.watch(isDarkModeProviderNotifier);
    var existUserProfile = ref.watch(appPreferencesProvider);
    // this is to invoke methods of the [isDarkMode] Provider.
    final themeSettings = ref.watch(isDarkModeProviderNotifier.notifier);
    return MaterialApp(
      title: 'To be Total',
      // this would check if the user create already an account
      initialRoute: existUserProfile.getBoolPreference('existUserProfile')
          ? 'progress'
          : 'sign_in_and_update',
      // initialRoute: ,
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      routes: ref.watch(routesProvider).getScreens(context),
      theme: themeSettings.showLight(),
      darkTheme: themeSettings.showDark(),
      themeMode: themeSettings.showCurrentMode(isDark),
    );
  }
}
