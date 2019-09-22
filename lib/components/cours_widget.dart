import 'package:flop_edt_app/components/fade_in.dart';
import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;
  final double delay;
  final bool animate;
  const CoursWidget({Key key, this.cours, this.delay, this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animate ? FadeIn(delay, _ui) : _ui;
  }

  Widget get _ui => Row(
        children: <Widget>[
          coursHeure,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: cours.isExam ? Colors.red : hexToColor(cours.color),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2.0, 5.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              margin: EdgeInsets.only(top: 5, bottom: 5),
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[coursType, coursInfo],
                ),
              ),
            ),
          ),
        ],
      );

  Widget get coursHeure => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              (cours.dateDebut.minute == 0)
                  ? '${cours.dateDebut.hour}h${cours.dateDebut.minute}0'
                  : '${cours.dateDebut.hour}h${cours.dateDebut.minute}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              (cours.dateFin.minute == 0)
                  ? '${cours.dateFin.hour}h${cours.dateFin.minute}0'
                  : '${cours.dateFin.hour}h${cours.dateFin.minute}',
              style: TextStyle(fontWeight: FontWeight.bold),
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
              cours.module,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: hexToColor(cours.textColor)),
            ),
            Text(
              cours.nomProf,
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
