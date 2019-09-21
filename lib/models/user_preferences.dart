import 'package:flop_edt_app/models/groups.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Group group;
  String promo;
  bool isDarkMode;
  bool isMono;
  bool isAnimated;


  Preferences(
      {this.group, this.promo, this.isDarkMode, this.isMono, this.isAnimated});

  factory Preferences.fromJSON(Map<String, dynamic> json) => Preferences(
      group: Group(groupe : json['groupe'], parent: json['parent']),
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
