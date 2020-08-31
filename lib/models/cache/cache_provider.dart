import 'package:shared_preferences/shared_preferences.dart';

///Classe représentant le cache de l'application.
///Elle contient des méthodes pour manipuler les objets en cache.
class CacheProvider {
  SharedPreferences storage;

  ///Permet d'instancier un objet de type [CacheProvider].
  static Future<CacheProvider> get instance async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return CacheProvider(prefs);
  }

  ///Constructeur par défaut de la classe
  CacheProvider(SharedPreferences prefs) {
    this.storage = prefs;
  }

  ///Ajoute une valeur en String au format JSON dans le cache (exemple : {"name": "Thomas"}).
  ///Prends en paramètre la clé [key] de type [String] (cette key devra être réutilisé afin de lire la valeur en cache)
  ///puis la valeur [value] de type [String] au format JSON.
  ///Cette méthode est asynchrone.
  Future addJSON(String key, String value) async {
    await this.storage.setString(key, value);
  }

  ///Retrouve la valeur associé à la [key] passé en paramètre.
  dynamic getValue(String key) {
    return this.storage.get(key);
  }
}
