import 'package:flutter/material.dart';

class MyDateFormat {
  DateTime _time;
  DateFormatType _type;

  Map<int, String> _month = {
    1: 'janvier',
    2: 'février',
    3: 'mars',
    4: 'avril',
    5: 'mai',
    6: 'juin',
    7: 'juillet',
    8: 'août',
    9: 'septembre',
    10: 'octobre',
    11: 'novembre',
    12: 'décembre',
  };

  MyDateFormat(this._time, this._type);

  String get date => _format();

  String _format() {
    switch (_type) {
      case DateFormatType.DAY_MONTH_YEAR:
        return '${_time.day} ${_month[_time.month]} ${_time.year}';
        break;
      case DateFormatType.DATE_SLASHES:
        return _time.day.toString() +
            '/' +
            _time.month.toString() +
            '/' +
            _time.year.toString();
      case DateFormatType.DAY_SLASHES_MONTH:
        var day = _time.day < 10 ? '0${_time.day}' : '${_time.day}';
        var month = _time.month < 10 ? '0${_time.month}' : '${_time.month}';
        return day + '/' + month;
        break;
    }
  }
}

enum DateFormatType { DAY_MONTH_YEAR, DATE_SLASHES, DAY_SLASHES_MONTH }
