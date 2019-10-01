import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

const DAY_INDEX = ["Lun.", "Mar.", "Mer.", "Jeu.", "Ven.", "Sam.", "Dim."];

Future<List<List<dynamic>>> loadDataFromServer(
    int week, int year, String promo) async {
  List<List<dynamic>> listeCours = [];
  var dep = promo == 'APSI' ? 'INFO' : promo;
  var url =
      'https://flopedt.iut-blagnac.fr/edt/$dep/fetch_cours_pl/$year/$week/0';
  return http.get(url).then((response) {
    if (response.statusCode == 200) {
      listeCours = const CsvToListConverter().convert(response.body);
    }
    return listeCours;
  });
}

Future<List<List<dynamic>>> loadDataFromServerProf(
    int week, int year, String prof) async {
  List<List<dynamic>> listeCours = [];
  var url =
      'https://flopedt.iut-blagnac.fr/edt/INFO/fetch_tutor_courses/$year/$week/$prof';
  return http.get(url).then((response) {
    if (response.statusCode == 200) {
      listeCours = const CsvToListConverter().convert(response.body);
    }
    return listeCours;
  });
}

int getIndexSemaine(dynamic day) {
  switch (day) {
    case 'm':
      return 1;
      break;
    case 'tu':
      return 2;
    case 'w':
      return 3;
    case 'th':
      return 4;
    case 'f':
      return 5;
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

TimeOfDay getHoursOfCourses(var startTime) {
  var hour = startTime / 60;
  var min = startTime % 60;
  var time = TimeOfDay(hour: hour.toInt(), minute: min.toInt());
  return time;
}
