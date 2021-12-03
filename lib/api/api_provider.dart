import 'dart:convert';

import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/resources/etablissement.dart';
import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/settings.dart';
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
    */

    //this._apiBase = DotEnv().env['API_BASE'];
    this._apiBase = getapiUrl();
    //_apiBase = "";
  }

  String get _apiUrl => getapiUrl();
  String getapiUrl() {
    String url;
    getAPIBase().then((val) {
      url = val + "fr/api/";
      print("printage" + val);
    });
    print(url);
    return url;
  }

  ///Effectue une requête sur l'API afin de récupérer la liste des cours.
  ///[year] correspond à l'année
  ///[week] correspond au numéro de la semaine
  ///[promo] correspond à la promotion choisie (INFO2, INFO1...)
  ///[department] correspond au département (INFO, CS...)
  ///[group] correspond au groupe choisi (3A, 1A...)
  Future<List<Cours>> getCourses(
      {int year, week, String promo, department, group}) async {
    Settings settings = await Settings.getConfiguration();
    final url = settings.etablissement.url +
        "fr/api/" +
        'fetch/scheduledcourses/?week=$week&year=$year&work_copy=0&dept=$department&train_prog=$promo&group=$group&lineage=true';
    print(url);
    final response = await http.get(url);

    //Récupération des prof du département
    final urlTutor =
        settings.etablissement.url + "fr/api/" + 'user/tutor/?dept=$department';
    final responseTutors = await http.get(urlTutor, headers: _headers);

    //Récupération de la durée des cours
    final urlTypeCours =
        settings.etablissement.url + "fr/api/courses/type/?dept=$department";
    final responseTypeCours = await http.get(urlTypeCours, headers: _headers);

    if (response.statusCode == 200 &&
        responseTutors.statusCode == 200 &&
        responseTypeCours.statusCode == 200)
      return Cours.createListFromResponses(
          response, responseTutors, responseTypeCours, year, week);
    return <Cours>[];
  }

  Future<void> setEtablissements(Etablissement etablissement) async {
    Settings settings = await Settings.getConfiguration();
    settings.etablissement = etablissement;
  }

  Future<String> getAPIBase() async {
    Settings settings = await Settings.getConfiguration();
    return settings == null ? "" : settings.etablissement.url + "fr/api/";
  }

  Future<List<dynamic>> getEtablissements() async {
    final url = 'https://api.flopedt.org/clients/';
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200)
      return Etablissement.createListFromResponse(response);
    return <dynamic>[];
  }

  ///Effectue une requête sur l'API afin de récupérer la liste des départements.
  Future<List<dynamic>> getDepartments() async {
    /*
    final url = _apiUrl + '&mode=departments';
    */
    Settings settings = await Settings.getConfiguration();
    final url = settings.etablissement.url + "fr/api/" + 'fetch/alldepts/';
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

  ///Effectue une requête sur l'API afin de récupérer la liste des cours d'un prof selon un département.
  Future<List<Cours>> getCoursesOfProf(
      {int year, week, String department, prof}) async {
    /*
    final url = _apiUrl +
        '&mode=courses&dep=$department&prof=$prof&year=$year&week=$week';
        */

    Settings settings = await Settings.getConfiguration();
    final url = settings.etablissement.url +
        "fr/api/" +
        'fetch/scheduledcourses/?week=$week&year=$year&tutor_name=$prof&dept=$department&work_copy=0';
    print(url);
    final response = await http.get(url, headers: _headers);

    //Récupération de la durée des cours
    final urlTypeCours =
        settings.etablissement.url + "fr/api/courses/type/?dept=$department";
    final responseTypeCours = await http.get(urlTypeCours, headers: _headers);

    if (response.statusCode == 200 && responseTypeCours.statusCode == 200)
      return Cours.createListFromResponse(
          response, responseTypeCours, year, week);
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
    Settings settings = await Settings.getConfiguration();
    final url =
        settings.etablissement.url + "fr/api/" + 'user/tutor/?dept=$dep';
    print(url);
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
    Settings settings = await Settings.getConfiguration();
    final url = settings.etablissement.url +
        "fr/api/" +
        'base/trainingprogram/name/?dept=$department';
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
    Settings settings = await Settings.getConfiguration();
    final url = settings.etablissement.url +
        "fr/api/" +
        'groups/structural/tree/?dept=$department';
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
