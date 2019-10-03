import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/models/user_preferences.dart';

///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
///[index] est ici le numéro de semaine
///[courses] est une [Map] contenant les cours
///[date] est la date du jour actuel, on récupère son indice dans la semaine entre 1(lundi) et 5(vendredi)
///[preferences] est un objet de type [Preferences] qui contient toutes les infos sur les groupes utilisateurs etc..
List<Cours> filter(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday]
      .where((cours) =>
          cours.nomPromo == preferences.promo &&
          (cours.nomGroupe == preferences.group.groupe ||
              cours.nomGroupe.toString() == preferences.group.parent ||
              cours.coursType.toString() == "CM" ||
              cours.coursType == 'DS' ||
              cours.coursType == 'CTRL' ||
              cours.coursType == 'CTRLP' ||
              cours.coursType == 'Exam' ||
              cours.coursType == 'Examen'))
      .toList();

  ///On trie grâce à la date
  filtered.sort((c1, c2) => c1.dateDebut.compareTo(c2.dateDebut));
  return filtered;
}

List<Cours> filterProf(int index, Map<int, Map<int, List<Cours>>> courses,
    DateTime date, Preferences preferences) {
  List<Cours> filtered = courses[index][date.weekday];
  ///On trie grâce à la date
  filtered.sort((c1, c2) => c1.dateDebut.compareTo(c2.dateDebut));
  return filtered;
}
