import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/edt/components/cours_widget.dart';
import 'package:flutter/material.dart';

class ScheduleViewer extends StatefulWidget {
  @override
  _ScheduleViewerState createState() => _ScheduleViewerState();
}

class _ScheduleViewerState extends State<ScheduleViewer> {
  AppState state;

  final controller = PageController(
    initialPage: 0,
  );

  int _currentDayIndex;

  @override
  void initState() {
    super.initState();
    _currentDayIndex = 0;
  }

  void moveToCurrentDay() {
    controller.animateToPage(
      state.today.weekday - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var dayStart = 8 * 60;
    var dayEnd = 18 * 60 + 45;
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        centerTitle: false,
        title: Text(
          'xFlop!',
          style: theme.textTheme.headline4,
        ),
        actions: <Widget>[
          Center(
            child: Text(
              state.days[_currentDayIndex].toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.apps,
              color: Colors.black,
            ),
            onPressed: () => StateWidget.of(context).switchDisplayMode(),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int newIndex) =>
                  setState(() => _currentDayIndex = newIndex),
              controller: controller,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: state.days
                  .map(
                    (Day day) => Container(
                      height: (dayEnd - dayStart).toDouble() + 10,
                      width: deviceSize.width,
                      child: Stack(
                        children: day.cours
                            .map(
                              (Cours c) => Positioned(
                                  top: (c.startTimeFromMidnight - dayStart) *
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
