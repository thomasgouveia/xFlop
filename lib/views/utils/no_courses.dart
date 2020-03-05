import 'package:flutter/material.dart';

class NoCourses extends StatelessWidget {
  final bool isWeekWithinCours;

  const NoCourses({Key key, this.isWeekWithinCours: false}) : super(key: key);

  String get _text => isWeekWithinCours
      ? 'Aucun cours cette semaine.'
      : 'Aucun cours aujourd\'hui';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_text),
    );
  }
}
