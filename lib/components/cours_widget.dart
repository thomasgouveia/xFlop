import 'package:flop_edt_app/components/fade_in.dart';
import 'package:flop_edt_app/models/Cours.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;
  final double delay;
  const CoursWidget({Key key, this.cours, this.delay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(delay, _ui);
  }

  Widget get _ui => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cours.coursType == 'DS' ? Colors.red : hexToColor(cours.color),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 5.0),
              blurRadius: 10.0,
            )
          ],
        ),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                cours.module,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(cours.nomProf),
              Text(
                cours.salle,
                style: TextStyle(
                    fontWeight: cours.coursType == 'DS'
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
            ],
          ),
        ),
        height: 100,
      );
}
