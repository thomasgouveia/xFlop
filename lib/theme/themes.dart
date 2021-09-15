import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

///Classe représentant les deux thèmes (Clair et Sombre) de l'application.
class AppTheme {
  ///Retourne le theme clair de l'application.
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color(0xFF07023B),
        primaryColor: Color(0xFF07023B),
        primaryColorLight: Color(0xFF07023B),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: ColorUtils.fromHex('#07023B'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
            shadowColor: Color(0xFF07023B),
            elevation: 7.5,
          ),
        ),
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.black, fontSize: 24),
          headline3: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          bodyText1: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.white, fontSize: 16),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        accentIconTheme: IconThemeData(color: Colors.black54),
        iconTheme: IconThemeData(color: Colors.black),
        selectedRowColor: Colors.black12,
      );

  ///Retourne le thème sombre de l'application.
  static ThemeData darkTheme() => ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        primaryColorLight: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: ColorUtils.fromHex('#383838'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
            shadowColor: Color(0xFF404040),
            elevation: 5,
          ),
        ),
        accentColor: ColorUtils.fromHex('#383838'),
        primaryColor: ColorUtils.fromHex('#121212'),
        scaffoldBackgroundColor: ColorUtils.fromHex('#121212'),
        accentIconTheme: IconThemeData(color: Colors.white54),
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.white, fontSize: 24),
          headline3: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          bodyText1: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        selectedRowColor: Colors.white12,
      );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    Settings settings;
    Settings.getConfiguration().then((value) => settings = value);
    themeMode = settings == null
        ? ThemeMode.system
        : settings.darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
    return settings == null
        ? ThemeMode.system == ThemeMode.dark
        : settings.darkMode;
  }

  ThemeMode getMode() {
    Settings settings;
    Settings.getConfiguration().then((value) => settings = value);
    themeMode = settings == null
        ? ThemeMode.system
        : settings.darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
    return themeMode;
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
