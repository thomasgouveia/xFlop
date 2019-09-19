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

  void saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  dynamic readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  void removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void display() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getKeys());
  }
}

LocalStorage storage = LocalStorage();
