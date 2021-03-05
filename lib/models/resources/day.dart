import 'dart:convert';

import 'package:flop_edt_app/models/resources/course.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

///Classe modèle représentant les jours de cours.
///Chaque jour est composé d'une date (eg: 20 février 2020) ainsi que d'une liste de cours.
class Day {
  ///La date du jour de type [DateTime]
  final DateTime date;

  ///La liste de cours, de type [List<Cours>]
  final List<Cours> cours;

  ///Tableau statique permettant de stocker les labels des jours de la semaine (eg: 'Lun.')
  static const DAYS_LABEL = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.'];

  ///Constructeur de la classe [Day]
  Day({this.date, this.cours});

  ///Construit un objet [Day] à partir de données JSON, dans ce cas une [Map<String, dynamic>].
  factory Day.fromJSON(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json['date']),
        cours: <Cours>[],
      );

  ///Méthode statique permettant de créer une liste de jour à partir d'une réponse HTTP.
  static List<Day> createListFromResponse(Response response) {
    var dates = jsonDecode(response.body);
    var result = <Day>[];
    dates.forEach((dynamic date) => result.add(Day.fromJSON(date)));
    return result;
  }

  ///Méthode d'affichage de l'objet [Day].
  ///Possibilité de précisé si l'on souhaite afficher le jour avec son label, ou uniquement la date.
  ///(Exemple : 02/03 ou Lun. 02/03)
  @override
  String toString({withLabel: true}) {
    if (withLabel) {
      return DAYS_LABEL[date.weekday - 1] +
          ' ' +
          DateFormat('dd/MM').format(date);
    }
    return DateFormat('dd/MM').format(date);
  }

  static List<Day> getCompleteWeek({int year, week}) {
    int firstDayOfWeek =
        week * 7 - (DateTime(year).add(Duration(days: week * 7)).weekday - 1);
    return [0, 1, 2, 3, 4]
        .map((int nb) => Day(
            cours: [],
            date: DateTime(year).add(Duration(days: firstDayOfWeek + nb))))
        .toList();
  }
}
