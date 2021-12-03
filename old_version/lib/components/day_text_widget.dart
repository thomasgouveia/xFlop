import 'package:flop_edt_app/models/date_formatter.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class DayTextWidget extends StatelessWidget {
  const DayTextWidget({
    Key key,
    this.color,
    @required this.todayDate,
  }) : super(key: key);

  final DateTime todayDate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${DAY_INDEX[todayDate.weekday - 1]} ${MyDateFormat(todayDate, DateFormatType.DAY_SLASHES_MONTH).date}"
                .toUpperCase(),
            style: TextStyle(fontSize: 18, color: color),
          ),
        ],
      ),
    );
  }
}
