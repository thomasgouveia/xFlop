import 'package:intl/intl.dart';

class DateUtils {
  ///Retourne un [DateTime] représentant la date d'ajourd'hui, à 00h01.
  static DateTime todayMidnight() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 0, 1);
  }

  ///Renvoi le numéro de semaine associé à la date du jour.
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  ///Compare deux dates et retourne vrai si ces deux dates sont le même jour, faux sinon.
  static bool isToday(DateTime date, DateTime toCompare) {
    return date.day == toCompare.day &&
        date.month == toCompare.month &&
        date.year == toCompare.year;
  }
}
