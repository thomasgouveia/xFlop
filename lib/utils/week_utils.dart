import 'package:intl/intl.dart';

class Week {
  ///Renvoi le numéro de semaine associé à la date du jour
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  ///Calcule la [List] des 3 prochaines semaine à partir de [defaultWeek] et [date]
  ///Prends en compte les changements d'année, et les weekend.
  static List<int> calculateThreeNext(DateTime date, int defaultWeek) {
    List<int> list = [defaultWeek];
    for (int i = 1; i <= 3; i++) {
      var week = date.month == 12 && date.day > 31 - 7
          ? 0
          : date.weekday == 6 || date.weekday == 7
              ? Week.weekNumber(date) + 1
              : Week.weekNumber(date);
      list.add(week + i);
    }
    return list;
  }
}
