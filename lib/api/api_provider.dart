import 'dart:convert';

import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

///Classe permettant d'intéragir avec l'API.
///La clé d'API est chargée depuis le fichier d'environnement .env.
class APIProvider {
  ///Clé de l'API
  String _key;

  ///Base de l'API
  String _apiBase;

  Map<String, String> _headers =
      Map.fromEntries([MapEntry("accept", "application/json")]);

  APIProvider() {
    /*
    this._key = DotEnv().env['API_KEY'];
    this._apiBase = DotEnv().env['API_BASE'];
    */
    _apiBase = "https://flopedt.iut-blagnac.fr/fr/api/";
  }

  //String get _apiUrl => this._apiBase + this._key;
  String get _apiUrl => this._apiBase;

  ///Effectue une requête sur l'API afin de récupérer la liste des cours.
  ///[year] correspond à l'année
  ///[week] correspond au numéro de la semaine
  ///[promo] correspond à la promotion choisie (INFO2, INFO1...)
  ///[department] correspond au département (INFO, CS...)
  ///[group] correspond au groupe choisi (3A, 1A...)
  Future<List<Cours>> getCourses(
      {int year, week, String promo, department, group}) async {
    /*
    final url = _apiUrl +
        '&mode=courses&dep=$department&promo=$promo&year=$year&week=$week&group=$group';
        */
    final url = _apiUrl +
        'fetch/scheduledcourses/?dept=$department&week=$week&year=$year&train_prog=$promo&group=$group';
    print(url);
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200)
      return Cours.createListFromResponse(response, year, week);
    return <Cours>[];
  }

  Future<List<dynamic>> getDepartments() async {
    /*
    final url = _apiUrl + '&mode=departments';
    */
    final url = _apiUrl + 'fetch/alldepts/';
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200)
      /*
    return jsonDecode(response.body)['response'];
    */
      return (jsonDecode(response.body))
          .map((dynamic obj) => (obj as Map<String, dynamic>)["abbrev"])
          .toList();
    return <dynamic>[];
  }

  Future<List<Cours>> getCoursesOfProf(
      {int year, week, String department, prof}) async {
    /*
    final url = _apiUrl +
        '&mode=courses&dep=$department&prof=$prof&year=$year&week=$week';
        */
    final url = _apiUrl +
        'fetch/tutorcourses/?tutor_name=$prof&year=$year&week=$week&dept=$department';
    print(url);
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200)
      return Cours.createListFromResponse(response, year, week);
    return <Cours>[];
  }

  Future<List<Day>> getCompleteWeek({int year, week}) async {
    return Day.getCompleteWeek(year: year, week: week);
    /*
    final url = _apiUrl + '&mode=week&week=$week&year=$year';
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200) return Day.createListFromResponse(response);
    return <Day>[];
    */
  }

  Future<List<Tutor>> getTutorsOfDepartment({String dep}) async {
    /*
    final url = _apiUrl + '&mode=profs&dep=$dep';
    */
    final url = _apiUrl + 'user/tutor/?dept=$dep';
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200)
      return Tutor.createListFromResponse(response);
    return <Tutor>[];
  }

  Future<List<Promotion>> getPromotions({String department}) async {
    /*
    final url = _apiUrl +
        '&mode=promo&dep=department';
        */
    final url = _apiUrl + 'base/trainingprogram/name/?dept=$department';
    final response = await http.get(url, headers: _headers);
    print(url);
    if (response.statusCode == 200) {
      //return (await Promotion.createListFromResponse(response));

      var res = jsonDecode(response.body);
      List<Promotion> promos = [];
      for (var promo in res) {
        promos.add(Promotion(
          department: department,
          name: promo['name'],
          promo: promo['abbrev'],
          groups:
              await getGroups(department: department, promo: promo['abbrev']),
        ));
      }
      return promos;
    }
    return <Promotion>[];
  }

  Future<List<String>> getGroups({String department, promo}) async {
    final url = _apiUrl + 'groups/groups/tree/?dept=$department';
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      List<String> groups = [];
      if (promo != null) {
        for (var prom in res) {
          if (prom['promo'] == promo) {
            if (prom['children'] == null) {
              groups.add(prom['name']);
            } else {
              for (var child in prom['children']) {
                if (child['children'] != null) {
                  for (var childSub in child['children']) {
                    if (childSub['children'] != null) {
                      for (var childSubSub in childSub['children']) {
                        if (childSubSub['children'] == null) {
                          groups.add(childSubSub['name']);
                        }
                      }
                    } else {
                      groups.add(childSub['name']);
                    }
                  }
                } else {
                  groups.add(child['name']);
                }
              }
            }
          }
        }
      } else {
        for (var group in res) {
          groups.add(group['name']);
        }
      }
      return groups;
    }
    return null;
  }
}
