import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flop_edt_app/screens/home_screen.dart';

///Classe modélisant les différentes routes de l'application
class AppNavigator {
  ///Redirige vers la page des paramètres
  static void toParameters(
          BuildContext context, Preferences preferences, Map profs) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Parameters(preferences: preferences, profs: profs,)));

  ///Redirige vers l'emploi du temps
  static void toEDT(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppStateProvider()));
}
