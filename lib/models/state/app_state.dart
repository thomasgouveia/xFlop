import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';

class AppState {
  //Données utiles
  bool isLoading;
  final DateTime today;
  int week;
  final int year;

  //Données relatives au cours
  List<Cours> cours;
  List<Day> days;

  //Exporter dans un objet settings
  String promo;
  String departement;
  String groupe;

  AppState({
    this.isLoading: true,
    this.today,
    this.week,
    this.year,
    this.promo = 'INFO2',
    this.departement = 'INFO',
    this.groupe = '3A',
    this.cours = const [],
  });
}
