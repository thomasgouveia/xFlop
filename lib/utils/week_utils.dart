import 'package:intl/intl.dart';

class Week {
  ///Renvoi le numéro de semaine associé à la date du jour
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  static List<int> calculateThreeNext(DateTime date, int defaultWeek) {
    List<int> list = [defaultWeek];
    for (int i = 1; i <= 3; i++) {
      var week =
          date.month == 12 && date.day > 31 - 7 ? 0 : Week.weekNumber(date);
      list.add(week + i);
    }
    return list;
  }
}
