import 'package:flop_edt_app/models/Cours.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;

  const CoursWidget({Key key, this.cours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: hexToColor(cours.color),
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
            Text(cours.module, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            Text(cours.nomProf),
            Text(cours.salle),
          ],
        ),
      ),
      height: 100,
    );
  }
}
