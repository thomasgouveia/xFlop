import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme() => ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    accentColor: Color(0xFF07023B),
    textTheme: TextTheme(
      headline4: TextStyle(color: Colors.black, fontSize: 26)
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
    )
  );

  static ThemeData darkTheme() => ThemeData(
    fontFamily: 'Poppins',
  );
}
