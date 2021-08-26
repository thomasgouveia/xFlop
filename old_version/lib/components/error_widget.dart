import 'package:flutter/material.dart';

///[Widget] personalisé s'affichant lorsque qu'un utilisateur tente d'accéder à l'emploi du temps
///en n'ayant séléctionner aucun groupe.
///[text] est le texte afficher dans ce [Widget]
class MyErrorWidget extends StatelessWidget {
  final String text;

  const MyErrorWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 5.0),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _errorIcon,
            _errorText,
          ],
        ),
      ),
    );
  }

  Widget get _errorIcon => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Icon(
          Icons.warning,
          color: Colors.white,
          size: 40,
        ),
      );

  Widget get _errorText => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      );
}
