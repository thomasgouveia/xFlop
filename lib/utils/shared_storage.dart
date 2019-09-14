import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  dynamic read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

LocalStorage storage = LocalStorage();
