import 'dart:convert';

import 'package:http/http.dart';

///Classe modèle [Tutor] permettant de représenter un enseignant en stockant ses initiales ("AB"),
///son nom ("Smith") et son prénom ("John").
class Tutor {
  ///Les initiales du tuteur, de type [String]
  String initiales;

  ///Le prénom du tuteur, de type [String]
  String prenom;

  ///Le nom du tuteur, de type [String]
  String nom;

  ///L'adresse mail du tuteur, de type [String]
  String mail;

  ///Getter qui renvoi le [prenom] [nom] de l'enseignant.
  String get displayName => this.prenom + ' ' + this.nom;

  ///Getter qui renvoi les [initiales] de l'enseignant.
  String get displayInitiales => this.initiales;

  ///Getter qui renvoi le [mail] de l'enseignant.
  String get displayMail => this.mail;

  ///Constructeur de la classe [Tutor].
  Tutor({this.initiales, this.prenom, this.nom, this.mail});

  ///Instancie un objet de type [Tutor] depuis un [Map] de type JSON.
  /*
  factory Tutor.fromJSON(Map<String, dynamic> json) => Tutor(
        initiales: json['initiales'],
        prenom: json['prenom'],
        nom: json['nom'],
      );
      */
  factory Tutor.fromJSON(Map<String, dynamic> json) => Tutor(
        initiales: json['username'],
        prenom: json['first_name'],
        nom: json['last_name'],
        mail: json['email'],
      );

  ///Méthode statique qui crée une liste d'enseignants depuis une réponse HTTP.
  static List<Tutor> createListFromResponse(Response response) {
    var profs = jsonDecode(utf8.decode(response.bodyBytes));
    var result = <Tutor>[];
    profs.forEach((dynamic prof) => result.add(Tutor.fromJSON(prof)));
    return result;
  }

  ///Retoune une [Map] de l'objet [Tutor]
  Map<String, dynamic> get toMap => {
        'initiales': this.initiales,
        'prenom': this.prenom,
        'nom': this.nom,
        'email': this.mail,
      };

  ///Retourne l'objet [Tutor] sous format JSON.
  String get toJSON => jsonEncode(this.toMap);

  ///Méthode d'affichage de la classe [Tutor].
  @override
  String toString() {
    return this.displayName;
  }
}
