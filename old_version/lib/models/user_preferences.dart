import 'package:flop_edt_app/models/groups.dart';

///Classe qui modélise les préférences utilisateurs
class Preferences {
  Group group;
  String promo;
  String prof;
  String profDep;
  bool isDarkMode;
  bool isMono;
  bool isAnimated;
  bool isProf;

  Preferences(
      {this.group,
      this.promo,
      this.isDarkMode,
      this.isMono,
      this.isAnimated,
      this.prof,
      this.profDep,
      this.isProf});

  factory Preferences.fromJSON(Map<String, dynamic> json) => Preferences(
      group: Group(groupe: json['groupe'], parent: json['parent']),
      promo: json['promo'],
      isDarkMode: json['isDarkMode'],
      isMono: json['isMono'],
      isAnimated: json['isAnimated']);

  Map get toJSON => {
        'groupe': this.group.groupe,
        'parent': this.group.parent,
        'promo': this.promo,
        'isDarkMode': this.isDarkMode,
        'isMono': this.isMono,
        'isAnimated': this.isAnimated,
      };
}
