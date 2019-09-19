import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  String groupe;
  String promo;
  bool isDarkMode;
  bool isMono;
  bool isAnimated;

  Preferences(
      {this.groupe, this.promo, this.isDarkMode, this.isMono, this.isAnimated});

  factory Preferences.fromJSON(Map<String, dynamic> json) => Preferences(
      groupe: json['groupe'],
      promo: json['promo'],
      isDarkMode: json['isDarkMode'],
      isMono: json['isMono'],
      isAnimated: json['isAnimated']);

  Map get toJSON => {
        'groupe': this.groupe,
        'promo': this.promo,
        'isDarkMode': this.isDarkMode,
        'isMono': this.isMono,
        'isAnimated': this.isAnimated,
      };
}
