import 'package:flop_edt_app/models/cache/cache_provider.dart';
import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/resources/etablissement.dart';
import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/settings.dart';

///Classe modèle [AppState] représentant le state global de l'application.
///C'est cette classe qui va stocker toutes les données importantes de l'application,
///telles que la date du jour, s'il y a un état de chargement, la liste des départements etc.
class AppState {
  //Données utiles
  bool isLoading;
  final DateTime today;
  int week;
  int currentWeek;
  final int year;
  List<Etablissement> etablissements;
  List<dynamic> departments;
  List<int> weeks;

  //Données relatives au cours
  List<Cours> cours;
  List<Day> days;

  //Données relatives aux profs
  Map<String, List<Tutor>> profs;

  //Groupes
  Map<String, List<Promotion>> promos;

  //Exporter dans un objet settings
  Settings settings;

  //Cache
  CacheProvider cache;

  AppState({
    this.isLoading: true,
    this.today,
    this.week,
    this.year,
    this.settings,
    this.cache,
    this.etablissements = const [],
    this.promos = const {},
    this.departments = const [],
    this.cours = const [],
    this.profs = const {},
    this.currentWeek,
    this.weeks = const [],
  });
}
