import 'package:flop_edt_app/components/cours_widget.dart';
import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';

class EDTViewer extends StatelessWidget {
  final List<Cours> listCourses;
  final String promo;
  final bool animate;
  final DateTime date;
  final MyTheme theme;
  final bool isProf;
  final DateTime today;

  const EDTViewer(
      {Key key,
      this.listCourses,
      this.promo,
      this.animate,
      this.date,
      this.isProf = false,
      this.theme,
      this.today})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: buildCourses(context),
    );
  }

  ///Construit la liste des cours de la journée
  ///Prends en compte la durée d'un cours, les heures de trous, les différentes heure en débuts de journée
  ///et la pause du midi.
  ///Diff est égal à -1 si les cours sont au mêmes moment
  List<Widget> buildCourses(BuildContext context) {
    List<Widget> grid = [];
    Cours previous;
    var delay = 1.0;
    for (int i = 0; i < listCourses.length; i++) {
      Cours cours = listCourses[i];
      if (previous == null) {
        previous = cours;
      }
      double height = (constraints[cours.coursDep][cours.coursType] + 10)
          .toDouble(); //On calcule la hauteur du container en fonction de la durée du cours
      var diff = cours == previous
          ? Duration(hours: cours.dateDebut.hour - 8)
          : cours.dateDebut.difference(previous.dateFin);
      delay += 0.4;
      Widget coursContainer = Container(
        height: height,
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.only(bottom: 2, top: 2),
        child: Row(
          children: <Widget>[
            diff.inHours == -1
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CoursWidget(
                          height: height,
                          today: today,
                          cours: cours,
                          delay: delay,
                          animate: animate,
                          isProf: isProf,
                          theme: theme,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        padding: const EdgeInsets.only(left: 25),
                        child: CoursWidget(
                          height: height,
                          today: today,
                          cours: previous,
                          isHour: false,
                          isProf: isProf,
                          delay: delay,
                          animate: animate,
                          theme: theme,
                        ),
                      ),
                    ],
                  )
                : Expanded(
                    child: CoursWidget(
                      height: height,
                      today: today,
                      cours: cours,
                      delay: delay,
                      animate: animate,
                      theme: theme,
                      isProf: isProf,
                    ),
                  )
          ],
        ),
      );
      Widget noCoursesSpacer = Padding(
        padding: EdgeInsets.only(
            top: diff.inHours == 0 || diff.inHours == -1
                ? 0.0
                : (diff.inMinutes * 90 / 90).toDouble()),
      );
      grid.add(noCoursesSpacer);
      grid.add(coursContainer);
      previous = cours;
    }
    return grid;
  }
}
