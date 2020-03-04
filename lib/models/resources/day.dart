import 'dart:convert';

import 'package:flop_edt_app/models/resources/course.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Day {
  final DateTime date;
  final List<Cours> cours;

  static const DAYS_LABEL = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.'];

  Day({this.date, this.cours});

  factory Day.fromJSON(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json['date']),
        cours: <Cours>[],
      );

  static List<Day> createListFromResponse(Response response) {
    var dates = jsonDecode(response.body)['response'];
    var result = <Day>[];
    dates.forEach((dynamic date) => result.add(Day.fromJSON(date)));
    return result;
  }

  @override
  String toString({withLabel: true}) {
    if (withLabel) {
      return DAYS_LABEL[date.weekday - 1] +
          ' ' +
          DateFormat('dd/MM').format(date);
    }
    return DateFormat('dd/MM').format(date);
  }
}
