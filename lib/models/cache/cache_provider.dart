import 'package:shared_preferences/shared_preferences.dart';

class CacheProvider {
  SharedPreferences storage;

  static Future<CacheProvider> get instance async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return CacheProvider(prefs);
  }

  CacheProvider(SharedPreferences prefs) {
    this.storage = prefs;
  }

  Future addJSON(String key, String value) async {
    await this.storage.setString(key, value);
  }

  dynamic getValue(String key) {
    return this.storage.get(key);
  }
}
