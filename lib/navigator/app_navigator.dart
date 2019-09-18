import 'package:xFlop/models/user_preferences.dart';
import 'package:xFlop/screens/parameters.dart';
import 'package:flutter/material.dart';
import 'package:xFlop/screens/home_screen.dart';

///Classe modélisant les différentes routes de l'application
class AppNavigator {
  ///Redirige vers la page des paramètres
  static void toParameters(BuildContext context, Preferences preferences) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Parameters(preferences: preferences)));

  ///Redirige vers l'emploi du temps
  static void toEDT(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppStateProvider()));
}
