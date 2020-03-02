import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

///Classe permettant d'intéragir avec l'API.
///La clé d'API est chargée depuis le fichier d'environnement .env.
class APIProvider {
  ///Clé de l'API
  String _key;

  ///Base de l'API
  String _apiBase;

  APIProvider() {
    this._key = DotEnv().env['API_KEY'];
    this._apiBase = DotEnv().env['API_BASE'];
  }

  String get _apiUrl => this._apiBase + this._key;

  ///Effectue une requête sur l'API afin de récupérer la liste des cours.
  ///[year] correspond à l'année
  ///[week] correspond au numéro de la semaine
  ///[promo] correspond à la promotion choisie (INFO2, INFO1...)
  ///[department] correspond au département (INFO, CS...)
  ///[group] correspond au groupe choisi (3A, 1A...)
  Future<List<Cours>> getCourses(
      {int year, week, String promo, department, group}) async {
    final url = _apiUrl +
        '&mode=courses&dep=$department&promo=$promo&year=$year&week=$week&group=$group';
    final response = await http.get(url);
    if (response.statusCode == 200)
      return Cours.createListFromResponse(response);
    return <Cours>[];
  }

  Future<List<Day>> getCompleteWeek({int year, week}) async {
    final url = _apiUrl + '&mode=week&week=$week&year=$year';
    final response = await http.get(url);
    if (response.statusCode == 200) return Day.createListFromResponse(response);
    return <Day>[];
  }
}
