import 'package:flop_edt_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme() => ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color(0xFF07023B),
    primaryColor: Color(0xFF07023B),
    primaryColorLight: Color(0xFF07023B),
    textTheme: TextTheme(
      headline4: TextStyle(color: Colors.black, fontSize: 24),
      bodyText1: TextStyle(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
    )
  );

  static ThemeData darkTheme() => ThemeData(
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    primaryColorLight: Colors.white,
    accentColor: ColorUtils.fromHex('#383838'),
    primaryColor: ColorUtils.fromHex('#121212'),
    scaffoldBackgroundColor: ColorUtils.fromHex('#121212'),
    textTheme: TextTheme(
      headline4: TextStyle(color: Colors.white, fontSize: 24),
      bodyText1: TextStyle(color: Colors.white),
    ),
  );
}
