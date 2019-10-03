import 'package:flop_edt_app/components/fade_in.dart';
import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;
  final bool isLunchTime;
  final double delay;
  final bool animate;
  final MyTheme theme;
  final DateTime today;
  final bool isProf;
  final bool isHour;
  final double height;
  const CoursWidget(
      {Key key,
      this.cours,
      this.delay,
      this.animate,
      this.theme,
      this.today,
      this.height,
      this.isProf = false,
      this.isHour = true,
      this.isLunchTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animate ? FadeIn(delay, _ui) : _ui;
  }

  Widget get _ui {
    bool isFinished = false;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: isFinished ? 0.3 : 1, //! TEST
      child: Row(
        children: <Widget>[
          isHour ? coursHeure : Container(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: cours.isExam ? Colors.red : hexToColor(cours.color),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 2, bottom: 2, right: 10),
              height: height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    isProf ? Container() : coursType,
                    coursInfo
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get coursHeure => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              (cours.dateDebut.minute == 0)
                  ? '${cours.dateDebut.hour}h${cours.dateDebut.minute}0'
                  : '${cours.dateDebut.hour}h${cours.dateDebut.minute}',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: theme.textColor),
            ),
            Text(
              (cours.dateFin.minute == 0)
                  ? '${cours.dateFin.hour}h${cours.dateFin.minute}0'
                  : '${cours.dateFin.hour}h${cours.dateFin.minute}',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: theme.textColor),
            ),
          ],
        ),
      );

  Widget get coursInfo => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              isProf ? '${cours.coursType} ${cours.module}' : cours.module,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: hexToColor(cours.textColor)),
            ),
            Text(
              isProf ? '${cours.nomPromo} - ${cours.nomGroupe}' : cours.nomProf,
              style: TextStyle(color: hexToColor(cours.textColor)),
            ),
            Text(
              cours.salle,
              style: TextStyle(
                  color: hexToColor(cours.textColor),
                  fontWeight: cours.coursType == 'DS'
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      );

  Widget get coursType => Container(
        width: 100,
        padding: EdgeInsets.only(left: 20),
        child: Center(
          child: Text(
            cours.coursType,
            style: TextStyle(fontSize: 18, color: hexToColor(cours.textColor)),
          ),
        ),
      );
}
