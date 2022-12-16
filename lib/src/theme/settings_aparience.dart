import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/theme/pallete_colors.dart';
import '../preferences_cache/preferences.dart';

// TODO CHANGE NAME TO THE CLASS FOR SOME MORE GENERIC FOR THEME SETTINGS
class IsDarkModeNotifier extends StateNotifier<bool> {
  IsDarkModeNotifier() : super(false) {
    _init();
  }

  get darkMode => ThemeMode.dark;

  get lightMode => ThemeMode.light;

  Future _init() async {
    // Initialize the Theme Mode Client Preferences.
    // TODO HOW TO DO THIS WITH THE STATE ONLY?
    // The preference init when the app start. This value is passed here -> [true/false]
    state = preferences.getBoolPreference("darkMode");
  }

  void toggle() {
    // Change state if the switch is off
    state = !state;
    // Save the Preferences of the client
    // TODO HOW TO DO THIS WITH THE STATE ONLY?
    // Add the changes to the preference cache
    preferences.setBoolPreference("darkMode", state);
  }

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
      selectedItemColor: Palette.red,
      unselectedItemColor: unselectedItemColor,
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      selectedLabelStyle: const TextStyle(fontSize: 12),
    );
  }

  FloatingActionButtonThemeData getFloatingActionBtn(Color backColor) {
    // Return an ActionButton Theme Data to Configure there aparience
    return FloatingActionButtonThemeData(
      elevation: 10,
      backgroundColor: backColor,
    );
  }

  // Show Light Mode
  ThemeData showLight() => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Palette.red,
        ),
        bottomNavigationBarTheme: getBottomNavSettings(
          Palette.white,
          Palette.blueGrey,
        ),
        floatingActionButtonTheme: getFloatingActionBtn(Palette.red),
        scaffoldBackgroundColor: Palette.white,
        textTheme: TextTheme(
            headline1: TextStyle(
              color: Palette.red,
              fontSize: 30,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            headline3: TextStyle(
              color: Palette.black,
              fontSize: 18,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            // body text
            headline6: TextStyle(
              color: Palette.black,
              fontSize: 20.0,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            bodyText2: TextStyle(
              color: Palette.black,
              fontSize: 12.0,
            ) // app bar
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
              color: Colors.red,
              fontSize: 30,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            headline3: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            // body text
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ) // app bar
            ),
      );
}
