import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  int id;
  String groupe;
  String promo;

  Preferences({this.groupe, this.promo});

  factory Preferences.fromJSON(Map<String, dynamic> json) =>
      Preferences(groupe: json['groupe'], promo: json['promo']);

  Map get toJSON => {'groupe': this.groupe, 'promo': this.promo};

  static Future<Preferences> getPreferencesFromSP() async {
    return await Preferences.fromJSON(storage.read('settings'));
  }
}
