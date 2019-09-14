import 'package:flop_edt_app/models/Cours.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;
  final bool animate;
  const CoursWidget({Key key, this.cours, this.animate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(
          Duration(milliseconds: 500), Tween(begin: 130.0, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: 500),
      duration: tween.duration,
      tween: tween,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(animation["translateX"], 0), child: child),
      ),
      child: _ui(),
    );
  }

  Container _ui() {
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
            Text(
              cours.module,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(cours.nomProf),
            Text(cours.salle),
          ],
        ),
      ),
      height: 100,
    );
  }
}
