// Imports
// Flutter
import 'package:flutter/material.dart';
// Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Routes
import 'package:tobe_total/src/routes/routes.dart';
// Controllers
import 'package:tobe_total/src/theme/controller.dart';


class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = ref.watch(isDarkModeProviderNotifier);
    final themeSettings = ref.watch(isDarkModeProviderNotifier.notifier);
    return MaterialApp(
      title: 'To be Total',
      initialRoute: 'sign_in',
      debugShowCheckedModeBanner: false,
      routes: Routes.getScreens(context),
      theme: themeSettings.showLight(),
      darkTheme: themeSettings.showDark(),
      themeMode: themeSettings.showCurrentMode(isDark),
    );
  }
}
