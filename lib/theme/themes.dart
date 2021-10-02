import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Classe représentant les deux thèmes (Clair et Sombre) de l'application.
class AppTheme {
  ///Retourne le theme clair de l'application.
  static ThemeData lightTheme() => ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
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
        primaryIconTheme: IconThemeData(color: Colors.black54),
        iconTheme: IconThemeData(color: Colors.black),
        selectedRowColor: Colors.black12,
        toggleableActiveColor: Color(0xFF07023B),
        
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
        primaryColorDark: Color(0xFF383838),
        primaryIconTheme: IconThemeData(color: Colors.white54),
        primaryColor: Color(0xFF383838),
        scaffoldBackgroundColor: ColorUtils.fromHex('#121212'),
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.white, fontSize: 24),
          headline3: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          bodyText1: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        selectedRowColor: Colors.white12,
        toggleableActiveColor: Color(0xFFFF6C00),
      );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  Future<bool> get isDarkMode async {
    Settings settings = await Settings.getConfiguration();
    themeMode = settings == null
        ? ThemeMode.system
        : settings.darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
    return settings == null
        ? ThemeMode.system == ThemeMode.dark
        : settings.darkMode;
  }

  Future<ThemeMode> getMode() async {
    ThemeMode themeMode;
    Settings settings = await Settings.getConfiguration();
    themeMode = settings == null
        ? ThemeMode.system
        : settings.darkMode
            ? ThemeMode.dark
            : ThemeMode.light;

    return themeMode;
  }

  static void setMode(BuildContext context, bool isOn) {
    Settings settings;
    Settings.getConfiguration().then((value) {
      settings = value;
      settings.darkMode = isOn;
      StateWidget.of(context).saveConfig(settings);
    });
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    isOn ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light) : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    notifyListeners();
  }
}
