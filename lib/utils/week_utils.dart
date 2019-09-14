import 'package:intl/intl.dart';

class Week {
  ///Renvoi le numéro de semaine associé à la date du jour
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}
