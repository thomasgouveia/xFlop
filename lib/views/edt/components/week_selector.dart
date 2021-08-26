import 'dart:async';

import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/date_utils.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class WeekSelector extends StatefulWidget {
  @override
  _WeekSelectorState createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<WeekSelector>
    with SingleTickerProviderStateMixin {
  AppState state;

  AnimationController _animationController;

  double minHeight;
  double maxHeight;
  bool isOpen;
  bool isBottomContentVisible;

  @override
  void initState() {
    super.initState();
    minHeight = 50;
    maxHeight = 120;
    isOpen = false;
    isBottomContentVisible = false;

    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _animationController.forward() : _animationController.reverse();
      isOpen
          ? Timer(
              Duration(milliseconds: 500),
              () => setState(() => isBottomContentVisible = isOpen),
            )
          : isBottomContentVisible = false;
    });
  }

  void onWeekChanged(int newWeek) {
    if (newWeek == state.week) {
      Flushbar(
        message: "Vous êtes déjà sur la semaine $newWeek.",
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.orangeAccent,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.orangeAccent,
      )..show(context);
    } else {
      setState(() {
        state.week = newWeek;
        StateWidget.of(context).createData();
        this.toggle();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: toggle,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: theme.accentColor,
          boxShadow: [
            BoxShadow(
              color: (theme.iconTheme.color == Colors.white)
                ? Colors.black38
                : theme.accentColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: isOpen ? maxHeight : minHeight,
        width: deviceSize.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              child: _buildHeader,
            ),
            AnimatedContainer(
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.easeInOut,
                height: isOpen ? 60 : 0,
                width: MediaQuery.of(context).size.width,
                child: Visibility(
                  visible: isBottomContentVisible,
                  child: Column(
                    children: <Widget>[
                      Container(height: 40, child: _buildWeeksChoices),
                      // SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: <Widget>[
                      //     Text(
                      //       'Informations sur la semaine',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 10),
                      // Expanded(
                      //   child: Container(
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 6,
                      //       itemBuilder: (context, int index) {
                      //         return GestureDetector(
                      //           onTap: () => print('Tapped'),
                      //           child: Container(
                      //             width: 180,
                      //             padding: EdgeInsets.all(10),
                      //             margin: EdgeInsets.symmetric(horizontal: 10),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(30),
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: <Widget>[
                      //                 Text('Général'),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  ///Construit la liste des semaines disponibles
  Widget get _buildWeeksChoices => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.weeks.length,
        itemBuilder: (BuildContext context, int index) {
          int week = state.weeks[index];
          bool isActiveWeek = state.week == week;
          return GestureDetector(
            onTap: () => onWeekChanged(week),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: isActiveWeek ? Color(0xFFFF6C00) : Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  'Semaine $week',
                  style: TextStyle(
                      color: isActiveWeek ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      );

  Widget get _buildHeader => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Semaine : ' + state.week.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          AnimatedIcon(
            progress: _animationController,
            icon: AnimatedIcons.menu_close,
            color: Colors.white,
          ),
        ],
      );
}
