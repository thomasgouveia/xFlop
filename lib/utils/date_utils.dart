import 'package:intl/intl.dart';

class DateUtils {
  ///Retourne un [DateTime] représentant la date d'ajourd'hui, à 00h01.
  static DateTime todayMidnight() {
    var now = DateTime.now();
    if (now.hour >= 19) {
      now = now.add(Duration(days: 1));
    }
    var date = DateTime(now.year, now.month, now.day, 0, 1);
    //On teste si on est un weekend (Samedi ou dimanche)
    var isWeekEnd = date.weekday == 6 || date.weekday == 7;
    if (isWeekEnd) {
      //Si on est samedi, on ajoute 2jours pour arriver à Lundi, sinon 1 seul car cela
      //signifie que l'on est dimanche.
      date = date.add(Duration(days: date.weekday == 6 ? 2 : 1));
    }
    return date;
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

  ///Calcule les prochaines semaines à venir.
  ///Récupère le lundi de la date actuelle, puis lui ajoute 7 pour trouver le lundi de la semaine suivante.
  static List<int> calculateWeeks(DateTime today, {int nbWeeks: 5}) {
    var res = <int>[DateUtils.weekNumber(today)];
    DateTime monday = today.subtract(Duration(days: today.weekday - 1));
    DateTime calculated;
    for (int i = 0; i < nbWeeks; i++) {
      calculated = monday.add(Duration(days: 7));
      monday = calculated;
      res.add(DateUtils.weekNumber(calculated));
    }
    return res;
  }
}
