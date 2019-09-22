import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/models/user_preferences.dart';

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredINFO(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo &&
          (cours.nomGroupe.toString() == preferences.group.groupe ||
              cours.nomGroupe.toString() == preferences.group.parent ||
              cours.coursType.toString() == "CM"))
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}

/*
///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredGIM(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) => cours.nomPromo == preferences.promo)
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}
*/

/*
///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredRT(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo &&
          (cours.nomGroupe.toString() == preferences.group.groupe ||
              cours.nomGroupe.toString() == preferences.group.parent ||
              cours.coursType == 'CM' || cours.coursType == 'Examen'))
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  filtered.forEach((cours) => print(cours.heure.toString()));
  return filtered;
}
*/

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
List<Cours> filteredCS(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo &&
          (cours.nomGroupe == preferences.group.groupe ||
              cours.coursType == "CM" || cours.coursType == 'Exam'))
      .toList();
  filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
  return filtered;
}
