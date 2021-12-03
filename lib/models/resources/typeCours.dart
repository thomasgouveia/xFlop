import 'dart:convert';

import 'package:http/http.dart';

class TypeCours {
  String name;
  int duration;

  TypeCours({this.name, this.duration});

  factory TypeCours.fromJSON(Map<String, dynamic> json) =>
      TypeCours(name: json['name'], duration: json['duration']);

  Map<String, dynamic> get toMap => {
        'name': this.name,
        'duration': this.duration,
      };

  ///Retourne une chaîne JSON de l'objet.
  String get toJSON => jsonEncode(this.toMap);

  @override
  String toString() {
    return this.toJSON;
  }

  ///Méthode statique créant une liste de [TypeCours] à partir d'une réponse HTTP.
  static Future<List<TypeCours>> createListFromResponse(
      Response response) async {
    var typeCours = jsonDecode(utf8.decode(response.bodyBytes));
    var res = <TypeCours>[];
    for (var typeC in typeCours) {
      res.add(TypeCours(
        name: typeC['name'],
        duration: typeC['duration'],
      ));
    }
    return res;
  }

  static int getDuration(List<TypeCours> typesCours, String type) {
    int duree = 0;
    typesCours.forEach((typeC) {
      if (typeC.name == type) {
        duree = typeC.duration;
      }
    });
    return duree;
  }
}
