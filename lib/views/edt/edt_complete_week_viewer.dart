import 'package:flop_edt_app/animations/fade_in.dart';
import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Image.asset(Constants.logoPath),
        centerTitle: false,
        title: Text(
          'xFlop!',
          style: theme.textTheme.headline4,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.view_column,
              color: theme.accentIconTheme.color,
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
                    children: _buildGrid(theme),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildGrid(ThemeData theme) {
    var days = state.days;
    var res = <Widget>[];
    var deviceSize = MediaQuery.of(context).size;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    days.forEach((Day day) {
      var container = Container(
        width: deviceSize.width / days.length,
        height: (dayEnd - dayStart).toDouble(),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: theme.selectedRowColor,
              style: BorderStyle.solid),
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: -30,
              left: 20,
              child: Text(
                day.toString(withLabel: false),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w600),
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
    bool isFinished = elem.dateEtHeureFin.isBefore(DateTime.now());
    var textColor = isFinished ? Colors.white : elem.textColor;
    return Positioned(
      top: (elem.startTimeFromMidnight - dayStart) * 1.toDouble(),
      child: FadeIn(
        0.3,
        Container(
          width: deviceSize.width / days.length,
          height: elem.duration.toDouble(),
          color: isFinished
              ? elem.backgroundColor.withOpacity(0.5)
              : elem.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                elem.module,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: fontSize),
              ),
              Text(
                state.settings.isTutor
                    ? elem.groupe + ' - ' + elem.promo
                    : elem.enseignant.initiales,
                style: TextStyle(color: textColor, fontSize: profFontSize),
              ),
              Text(
                elem.salle,
                style: TextStyle(color: textColor, fontSize: roomFontSize),
              )
            ],
          ),
        ),
      ),
    );
  }
}
