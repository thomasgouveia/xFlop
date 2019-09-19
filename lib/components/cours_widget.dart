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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 50,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                      child: Text(
                    cours.coursType,
                    style: TextStyle(
                        fontSize: 18, color: hexToColor(cours.textColor)),
                  ))),
              Expanded(
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
              ),
            ],
          ),
        ),
        height: 100,
      );
}
