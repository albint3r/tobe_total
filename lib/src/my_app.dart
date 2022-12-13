// Imports
// Flutter
import 'package:flutter/material.dart';
// Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/preferences/preferences.dart';

// Routes
import 'package:tobe_total/src/routes/routes.dart';

// Controllers
import 'package:tobe_total/src/preferences/theme/settings_aparience.dart';

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
          ? '/'
          : 'sign_in',
      // initialRoute: ,
      debugShowCheckedModeBanner: false,
      routes: ref.watch(routesProvider).getScreens(context),
      theme: themeSettings.showLight(),
      darkTheme: themeSettings.showDark(),
      themeMode: themeSettings.showCurrentMode(isDark),
    );
  }
}
