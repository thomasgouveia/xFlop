import 'dart:convert';

import 'package:http/http.dart';

class Tutor {
  String initiales;
  String prenom;
  String nom;

  String get displayName => this.prenom + ' ' + this.nom;

  Tutor({this.initiales, this.prenom, this.nom});

  factory Tutor.fromJSON(Map<String, dynamic> json) => Tutor(
        initiales: json['initiales'],
        prenom: json['prenom'],
        nom: json['nom'],
      );

  static List<Tutor> createListFromResponse(Response response) {
    var profs = jsonDecode(response.body)['response'];
    var result = <Tutor>[];
    profs.forEach((dynamic prof) => result.add(Tutor.fromJSON(prof)));
    return result;
  }

  Map<String, dynamic> get toMap => {
        'initiales': this.initiales,
        'prenom': this.prenom,
        'nom': this.nom,
      };

  String get toJSON => jsonEncode(this.toMap);

  @override
  String toString() {
    return this.displayName;
  }
}
