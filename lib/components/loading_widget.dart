import 'package:flop_edt_app/themes/theme.dart';
import 'package:flutter/material.dart';

///[Widget] personalisé qui s'affiche lorsque l'état de l'application est
///en chargement.
class LoadingWidget extends StatelessWidget {
  final int semaine;
  final MyTheme theme;

  const LoadingWidget({Key key, this.semaine, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Récupération de la semaine $semaine',
              style: TextStyle(color: theme.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
