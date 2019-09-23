import 'package:flop_edt_app/components/cours_widget.dart';
import 'package:flop_edt_app/components/default_cours.dart';
import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class EDTViewer extends StatelessWidget {
  final Map<int, Cours> coursesMap;
  final bool animate;
  final DateTime date;
  final MyTheme theme;

  const EDTViewer(
      {Key key, this.coursesMap, this.animate, this.date, this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: buildCourses(context),
    );
  }

  List<Widget> buildCourses(BuildContext context) {
    List<Widget> grid = [];
    Map<int, Cours> map = coursesMap;
    var delay = 1.0;
    map.forEach((index, cours) {
      delay += 0.6;
      grid.add(Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.only(bottom: 2, top: 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: (cours != null)
                  ? CoursWidget(
                      cours: cours,
                      delay: delay,
                      animate: animate,
                      theme: theme,
                    )
                  : (index == 3)
                      ? Container()
                      : DefaultCoursContainer(
                          delay: delay,
                          animate: animate,
                          theme: theme,
                        ), //Vide s'il n'y a pas de cours
            ),
          ],
        ),
      ));
    });
    return grid;
  }
}
