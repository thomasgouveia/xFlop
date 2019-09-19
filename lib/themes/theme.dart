import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class MyTheme {

  Color primary;
  Color secondary;
  Color third;
  Color textColor;

  MyTheme(bool isDarkMode){
    this.primary = isDarkMode ? hexToColor('#121212') : Colors.white;
    this.secondary = isDarkMode ? hexToColor('#383838') : Colors.white;
  }
}