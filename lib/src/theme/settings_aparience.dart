import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../preferences/preferences.dart';

class IsDarkModeNotifier extends StateNotifier<bool> {
  IsDarkModeNotifier() : super(false) {
    _init();
  }

  get darkMode => ThemeMode.dark;

  get lightMode => ThemeMode.light;

  Future _init() async {
    // Initialize the Theme Mode Client Preferences.
    // TODO HOW TO DO THIS WITH THE STATE ONLY?
    state = preferences.getBoolPreference("darkMode");
  }

  void toggle() {
    // Change state if the switch is off
    state = !state;
    // Save the Preferences of the client
    setPreference(state);
  }

  // Save the preferences of the client.
  // TODO HOW TO DO THIS WITH THE STATE ONLY?
  void setPreference(bool state) => preferences.setBoolPreference("darkMode", state);

  // Show the Current Theme Mode Depending in the Switch On /Off
  ThemeMode showCurrentMode(bool isDark) => isDark ? darkMode : lightMode;

  BottomNavigationBarThemeData getBottomNavSettings(
    Color backgroundColor,
    Color unselectedItemColor,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: unselectedItemColor,
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      selectedLabelStyle: const TextStyle(fontSize: 12),
    );
  }

  FloatingActionButtonThemeData getFloatingActionBtn(Color backColor) {
    return FloatingActionButtonThemeData(
      elevation: 10,
      backgroundColor: backColor,
    );
  }

  // Show Light Mode
  ThemeData showLight() => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
        bottomNavigationBarTheme: getBottomNavSettings(
          Colors.white,
          Colors.blueGrey,
        ),
        floatingActionButtonTheme: getFloatingActionBtn(Colors.red),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.red,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          ),
          // body text
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ), // app bar
        ),
      );

  // Show Dark Mode
  ThemeData showDark() => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.black12,
        ),
        bottomNavigationBarTheme: getBottomNavSettings(
          Colors.black12,
          Colors.white38,
        ),
        floatingActionButtonTheme: getFloatingActionBtn(Colors.white),
        scaffoldBackgroundColor: Colors.white12,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
          // body text
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ), // app bar
        ),
      );
}

final isDarkModeProviderNotifier =
    StateNotifierProvider<IsDarkModeNotifier, bool>(
  (ref) => IsDarkModeNotifier(),
);
