import 'package:flop_edt_app/animations/fade_in.dart';
import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/loader/loading_screen.dart';
import 'package:flutter/material.dart';

class ScheduleCompleteWeek extends StatefulWidget {
  @override
  _ScheduleCompleteWeekState createState() => _ScheduleCompleteWeekState();
}

class _ScheduleCompleteWeekState extends State<ScheduleCompleteWeek> {
  AppState state;

  @override
  void initState() {
    super.initState();
  }

  var dayStart = 8 * 60;
  var dayEnd = 18 * 60 + 45;

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        centerTitle: false,
        title: Text(
          'xFlop!',
          style: theme.textTheme.headline4,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.view_column,
              color: Colors.black,
            ),
            onPressed: () => StateWidget.of(context).switchDisplayMode(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: state.isLoading
            ? LoadingScreen()
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: _buildGrid,
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> get _buildGrid {
    var days = state.days;
    var res = <Widget>[];
    var deviceSize = MediaQuery.of(context).size;
    days.forEach((Day day) {
      var container = Container(
        width: deviceSize.width / days.length,
        height: (dayEnd - dayStart).toDouble(),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black26, style: BorderStyle.solid)),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: -30,
              left: 20,
              child: Text(
                day.toString(withLabel: false),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            for (var elem in day.cours) _buildCourse(elem, deviceSize, days),
          ],
        ),
      );
      res.add(container);
    });
    return res;
  }

  Positioned _buildCourse(Cours elem, Size deviceSize, List<Day> days) {
    var fontSize = 13.0;
    var profFontSize = 12.0;
    var roomFontSize = 11.0;
    return Positioned(
      top: (elem.startTimeFromMidnight - dayStart) * 1.toDouble(),
      child: FadeIn(
        0.3,
        Container(
          width: deviceSize.width / days.length,
          height: elem.duration.toDouble(),
          color: elem.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                elem.module,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: elem.textColor,
                    fontSize: fontSize),
              ),
              Text(
                elem.enseignant,
                style: TextStyle(color: elem.textColor, fontSize: profFontSize),
              ),
              Text(
                elem.salle,
                style: TextStyle(color: elem.textColor, fontSize: roomFontSize),
              )
            ],
          ),
        ),
      ),
    );
  }
}
