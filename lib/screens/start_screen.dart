import 'package:flop_edt_app/navigator/app_navigator.dart';
import 'package:flop_edt_app/screens/home_screen.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  final bool isDarkMode;

  const StartPage({Key key, this.isDarkMode}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedPromo = 'INFO1';
  String selectedGroupe = '1A';

  final fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: headingLogo,
            ),
            Text(
              'Pour obtenir ton emploi du temps, merci de séléctionner ta promo et ton groupe ci-dessous. \n\nTu pourras modifier tes préférences directement depuis les paramètres à l\'avenir.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedPromo,
                    items: PROMOS.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String s) {
                      setState(() {
                        this.selectedPromo = s;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedGroupe,
                    items: GROUPES.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String s) {
                      setState(() {
                        this.selectedGroupe = s;
                      });
                    },
                  ),
                ],
              ),
            ),
            _validationButton,
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Text('xFlop! $VERSION'),
        ),
      ],
    ));
  }

  Widget get headingLogo => Column(
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            width: 150,
            height: 150,
          ),
          Text(
            'Bienvenue sur xFlop!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      );

  ///Crée le bouton de validation de type [RaisedButton]
  Widget get _validationButton => Container(
        width: 200,
        child: RaisedButton(
          onPressed: () {
            storage.save('promo', selectedPromo);
            storage.save('groupe', selectedGroupe);
            storage.saveBool('dark', false);
            AppNavigator.toEDT(context);
          },
          padding: EdgeInsets.all(15),
          color: Colors.green,
          child: Text(
            'Valider',
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      );
}
