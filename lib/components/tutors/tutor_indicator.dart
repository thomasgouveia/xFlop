import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flutter/material.dart';

class TutorIndicator extends StatelessWidget {
  ///[TutorIndicator] est un [Widget] s'affichant lorsque le mode de l'application est professeur.
  ///Si c'est un étudiant, ce widget ne s'affiche pas.
  const TutorIndicator({
    Key key,
    @required this.preferences,
    @required this.color,
  }) : super(key: key);

  final Preferences preferences;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return preferences.isProf
        ? Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Vous êtes : ${preferences.prof}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          )
        : Container();
  }
}
