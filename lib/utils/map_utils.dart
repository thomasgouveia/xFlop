//Crée la map correspond au jour de la semaine
import 'package:flop_edt_app/models/cours.dart';

///Initialise la [Map] avec des index
///correspondant aux jours de la semaine
///et comme valeur des listes de cours
Map<int, List<Cours>> setMap() => {
      1: new List<Cours>(),
      2: new List<Cours>(),
      3: new List<Cours>(),
      4: new List<Cours>(),
      5: new List<Cours>(),
    };

