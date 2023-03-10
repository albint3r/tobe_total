import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../preferences_cache/preferences.dart';

// TODO CHANGE NAME TO THE CLASS FOR SOME MORE GENERIC FOR THEME SETTINGS
class IsDarkModeNotifier extends StateNotifier<bool> {
  IsDarkModeNotifier() : super(false) {
    _init();
  }

  ///  return the Dark theme mode
  get darkMode => ThemeMode.dark;

  ///  return the Light theme mode
  get lightMode => ThemeMode.light;

  /// initializes the theme mode based on the saved preference.
  Future _init() async {
    // Initialize the Theme Mode Client Preferences.
    // TODO HOW TO DO THIS WITH THE STATE ONLY?
    // The preference init when the app start. This value is passed here -> [true/false]
    state = preferences.getBoolPreference("darkMode");
  }

  /// Toggles the theme mode and save it to the preference.
  void toggle() {
    // Change state if the switch is off
    state = !state;
    // Save the Preferences of the client
    // TODO HOW TO DO THIS WITH THE STATE ONLY?
    // Add the changes to the preference cache
    preferences.setBoolPreference("darkMode", state);
  }

  /// returns the current theme mode based on the preference.
  ThemeMode showCurrentMode(bool isDark) => isDark ? darkMode : lightMode;

  ///  return the BottomNavigationBarThemeData with the given colors.
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
  /// return the FloatingActionButtonThemeData with the given color.
  FloatingActionButtonThemeData getFloatingActionBtn(Color backColor) {
    // Return an ActionButton Theme Data to Configure there aparience
    return FloatingActionButtonThemeData(
      elevation: 10,
      backgroundColor: backColor,
    );
  }

  /// returns the light theme
  ThemeData showLight() => ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            fixedSize: const Size.fromWidth(300),
            padding: const EdgeInsets.only(
              bottom: 15,
              top: 15,
              right: 30,
              left: 30,
            ),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Bebas',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              letterSpacing: .5,
            ),
          ),
        ),
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
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: .5,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: .5,
            ),
            // this is used for the kpis
            headline4: TextStyle(
              color: Colors.black,
              fontFamily: 'Anton',
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              // overflow: TextOverflow.ellipsis,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
              // overflow: TextOverflow.ellipsis,
            ),
            // body text
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontFamily: 'Bebas',
              fontStyle: FontStyle.italic,
              letterSpacing: .5,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 12.0, // app bar
            ) // app bar
            ),
      );

  // Show Dark Mode
  ThemeData showDark() => ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: const Size.fromWidth(300),
          padding: const EdgeInsets.only(
            bottom: 15,
            top: 15,
            right: 30,
            left: 30,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          textStyle: const TextStyle(
            fontFamily: 'Bebas',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: .5,
          ),
        ),
      ),
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
          letterSpacing: .5,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Bebas',
          fontStyle: FontStyle.italic,
          letterSpacing: .5,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontFamily: 'Anton',
          fontStyle: FontStyle.italic,
          fontSize: 20.0,
          // overflow: TextOverflow.ellipsis,
        ),
        // this letter is for subtitles after H1
        headline5: TextStyle(
          color: Colors.white,
          fontFamily: 'Bebas',
          fontStyle: FontStyle.italic,
          fontSize: 12.0,
          // overflow: TextOverflow.ellipsis,
        ),
        // body text
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Bebas',
          fontStyle: FontStyle.italic,
          letterSpacing: .5,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 12.0, // app bar
        ),
      ));
}
