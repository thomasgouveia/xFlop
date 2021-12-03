import 'dart:convert';

import 'package:flop_edt_app/models/cache/cache_provider.dart';
import 'package:flop_edt_app/models/resources/etablissement.dart';
import 'package:flop_edt_app/models/resources/tutor.dart';

class Settings {
  Etablissement etablissement;
  String promo;
  String department;
  String groupe;
  Tutor tutor;
  bool isGridDisplay;
  bool isTutor;
  bool isAnimation;
  bool darkMode;

  static Future<Settings> getConfiguration() async {
    var cache = await CacheProvider.instance;
    var value = cache.getValue('settings');
    if (value == null) return null;
    var cached = jsonDecode(value);
    return Settings.fromJSON(cached);
  }

  saveConfiguration() async {
    CacheProvider cache = await CacheProvider.instance;
    await cache.addJSON('settings', this.toJSON);
  }

  Settings({
    this.etablissement,
    this.promo,
    this.department,
    this.groupe,
    this.isTutor: false,
    this.tutor,
    this.isGridDisplay: false,
    this.isAnimation: true,
    this.darkMode: false,
  });

  factory Settings.fromJSON(Map<String, dynamic> json) => Settings(
        etablissement: json['etablissement'] == null
            ? null
            : Etablissement.fromJSON(json['etablissement']),
        department: json['department'],
        promo: json['promo'],
        groupe: json['groupe'],
        isTutor: json['isTutor'],
        isGridDisplay: json['isGridDisplay'],
        isAnimation: json['isAnimation'],
        darkMode: json['darkMode'] ?? false,
        tutor: json['tutor'] == null ? null : Tutor.fromJSON(json['tutor']),
      );

  Map<String, dynamic> get toMap => {
        'etablissement': this.etablissement?.toMap,
        'promo': this.promo,
        'department': this.department,
        'groupe': this.groupe,
        'isTutor': this.isTutor,
        'tutor': this.tutor?.toMap,
        'isGridDisplay': this.isGridDisplay,
        'isAnimation': this.isAnimation,
        'darkMode': this.darkMode,
      };

  String get toJSON => jsonEncode(this.toMap);

  @override
  String toString() {
    return this.toJSON;
  }
}
