import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/models/user_preferences.dart';


///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredINFO(int index, Map<int, Map<int, List<Cours>>> courses, DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo &&
          (cours.nomGroupe.toString() == preferences.groupe ||
              cours.nomGroupe.toString() == preferences.groupe[0].toString() ||
              cours.nomGroupe.toString() == "CE"))
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredGIM(int index, Map<int, Map<int, List<Cours>>> courses, DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo)
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredRT(int index, Map<int, Map<int, List<Cours>>> courses, DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo)
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredCS(int index, Map<int, Map<int, List<Cours>>> courses, DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo && (cours.nomGroupe == preferences.groupe ||
              cours.coursType == "CM"))
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}
