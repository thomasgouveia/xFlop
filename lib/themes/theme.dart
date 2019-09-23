import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class MyTheme {

  Color primary;
  Color secondary;
  Color third;
  Color textColor;
  Color defaultCours;

  MyTheme(bool isDarkMode){
    this.primary = isDarkMode ? Colors.grey[900] : Colors.white;
    this.secondary = isDarkMode ? hexToColor('#383838') : Colors.grey[900];
    this.textColor = isDarkMode ? Colors.white : Colors.black;
    this.defaultCours = isDarkMode ? Colors.white30 : Colors.grey[100];
  }
}