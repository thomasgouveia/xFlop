import 'package:flop_edt_app/animations/fade_in.dart';
import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flutter/material.dart';

class CoursWidget extends StatelessWidget {
  final Cours cours;
  final bool isLunchTime;
  final double delay;
  final bool animate;
  final DateTime today;
  final bool isProf;
  final bool isHour;
  final double height;
  const CoursWidget(
      {Key key,
      this.cours,
      this.delay,
      this.animate,
      this.today,
      this.height,
      this.isProf = false,
      this.isHour = true,
      this.isLunchTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: animate ? FadeIn(delay, this._ui(context)) : _ui(context));
  }

  Widget _ui(BuildContext context) {
    var now = DateTime.now();
    bool isFinished = cours.dateEtHeureFin.isBefore(now);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => cours.displayInformations(context),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: isFinished ? 0.3 : 1, //! TEST
        child: Row(
          children: <Widget>[
            isHour
                ? coursHeure(MediaQuery.of(context).platformBrightness ==
                    Brightness.dark)
                : Container(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: cours.isExam ? Colors.red : cours.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                //margin: EdgeInsets.only(top: 2, bottom: 2, right: 10),
                height: height,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[coursInfo],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coursHeure(bool isDark) => Container(
        width: 50,
        height: cours.duration.toDouble(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              (cours.dateEtHeureDebut.minute == 0)
                  ? '${cours.dateEtHeureDebut.hour}h${cours.dateEtHeureDebut.minute}0'
                  : '${cours.dateEtHeureDebut.hour}h${cours.dateEtHeureDebut.minute}',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black),
            ),
            Text(
              (cours.dateEtHeureFin.minute == 0)
                  ? '${cours.dateEtHeureFin.hour}h${cours.dateEtHeureFin.minute}0'
                  : '${cours.dateEtHeureFin.hour}h${cours.dateEtHeureFin.minute}',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black),
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
              '${cours.type} ${cours.module}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: cours.textColor,
              ),
            ),
            Text(
              isProf ? '${cours.promo} - ${cours.groupe}' : cours.enseignant,
              style: TextStyle(color: cours.textColor),
            ),
            Text(
              cours.salle,
              style: TextStyle(
                color: cours.textColor,
                fontWeight: cours.isExam ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );

  Widget get coursType => Container(
        padding: EdgeInsets.only(left: 20),
        child: Center(
          child: Text(
            cours.type,
            style: TextStyle(fontSize: 18, color: cours.textColor),
          ),
        ),
      );
}
