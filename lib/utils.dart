import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

List<String> dayIndex = [
  "Lun.",
  "Mar.",
  "Mer.",
  "Jeu.",
  "Ven.",
  "Sam.",
  "Dim."
];

const heures = [
  ["08h00", "09h25"],
  ["09h30", "10h55"],
  ["11h05", "12h30"],
  ["", ""],
  ["14h15", "15h40"],
  ["15h45", "17h10"],
  ["17h15", "18h40"]
];

Future<List<List<dynamic>>> fetchEDTData(int week, int year) async {
  List<List<dynamic>> listeCours = [];
  var url = 'https://flopedt.iut-blagnac.fr/edt/INFO/fetch_cours_pl/$year/$week/0';
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

int positionInJourney(dynamic startTime) {
  switch (startTime) {
    case 480:
      return 0;
      break;
    case 570:
      return 1;
      break;
    case 660:
      return 2;
      break;
    case 855:
      return 4;
      break;
    case 945:
      return 5;
      break;
    case 1035:
      return 6;
      break;
    default:
      return 3;
      break;
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
