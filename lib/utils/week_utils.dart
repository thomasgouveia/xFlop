import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Week {
  ///Renvoi le numéro de semaine associé à la date du jour
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  ///Calcule la [List] des 3 prochaines semaine à partir de [defaultWeek] et [date]
  ///Prends en compte les changements d'année, et les weekend.
  static List<int> calculateThreeNext(DateTime date, int defaultWeek) {
    var current = date.weekday == 6 ? date.add(Duration(days: 2)) : date.weekday == 7 ? date.add(Duration(days: 1)) : date;
    List<int> list = [Jiffy(current).week];
    for (int i = 1; i <= 3; i++) {
      var tmp = current.add(Duration(days: 7));
      print(tmp);
      list.add(Jiffy(tmp).week == 53 ? 1 : Jiffy(tmp).week);
      current = tmp;
    }
    return list;
  }
}
