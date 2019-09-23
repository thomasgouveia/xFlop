//Crée la map correspond au jour de la semaine
import 'package:flop_edt_app/models/cours.dart';

Map<int, List<Cours>> setMap() => {
      1: new List<Cours>(),
      2: new List<Cours>(),
      3: new List<Cours>(),
      4: new List<Cours>(),
      5: new List<Cours>(),
    };

Map<int, Cours> setJourneyMap(bool isThursday) {
  if (isThursday) {
    return {
      0: null,
      1: null,
      2: null,
    };
  } else {
    return {
      0: null,
      1: null,
      2: null,
      3: null,
      4: null,
      5: null,
      6: null,
    };
  }
}
