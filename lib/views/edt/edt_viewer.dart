import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/views/edt/components/cours_widget.dart';
import 'package:flop_edt_app/views/utils/no_courses.dart';
import 'package:flutter/material.dart';

class ScheduleViewer extends StatefulWidget {
  @override
  _ScheduleViewerState createState() => _ScheduleViewerState();
}

class _ScheduleViewerState extends State<ScheduleViewer> {
  AppState state;

  int _currentDayIndex;

  PageController controller;

  @override
  void initState() {
    super.initState();
    _currentDayIndex = 0;
    controller = PageController(
      initialPage: 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moveToCurrentDay();
    });
  }

  ///Déplace l'utilisateur sur la vue du jour actuel
  void moveToCurrentDay() {
    ///On vérifie que l'on est sur la même semaine pour amener l'utilisateur sur le bon jour,
    ///Sinon il va amener au jour pour chacune des semaines.
    if (state.currentWeek == state.week) {
      controller.jumpToPage(
        state.today.weekday - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    var deviceSize = MediaQuery.of(context).size;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Image.asset('assets/logo.png'),
        centerTitle: false,
        title: Text(
          'xFlop!',
          style: theme.textTheme.headline4,
        ),
        actions: <Widget>[
          Center(
            child: Text(
              state.days[_currentDayIndex].toString().toUpperCase(),
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.apps,
              color: theme.primaryIconTheme.color,
            ),
            onPressed: () => StateWidget.of(context).switchDisplayMode(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height:
                (Constants.DAY_END - Constants.DAY_START) * 1.toDouble() + 100,
            child: PageView(
              onPageChanged: (int newIndex) =>
                  setState(() => _currentDayIndex = newIndex),
              controller: controller,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: state.days
                  .map(
                    (Day day) => Container(
                      height:
                          (Constants.DAY_END - Constants.DAY_START).toDouble() +
                              10,
                      width: deviceSize.width,
                      child: Stack(
                        children: day.cours.length == 0
                            ? <Widget>[NoCourses()]
                            : day.cours
                                .map(
                                  (Cours c) => Positioned(
                                      top: (c.startTimeFromMidnight -
                                              Constants.DAY_START) *
                                          1.toDouble(),
                                      child: CoursWidget(
                                        animate: true,
                                        cours: c,
                                        delay: 0.3,
                                        isProf: state.settings.isTutor,
                                        height: c.duration.toDouble(),
                                      )),
                                )
                                .toList(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
