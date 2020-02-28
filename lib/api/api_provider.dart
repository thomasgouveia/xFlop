import 'package:flutter_dotenv/flutter_dotenv.dart';

///Classe permettant d'intéragir avec l'API.
///La clé d'API est chargée depuis le fichier d'environnement .env.
class APIProvider {

  ///Clé de l'API
  String _key;

  APIProvider() {
    this._key = DotEnv().env['API_KEY'];
  }

}