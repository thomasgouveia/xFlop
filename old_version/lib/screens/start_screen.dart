import 'dart:io';

import 'package:flop_edt_app/components/adaptative_switch.dart';
import 'package:flop_edt_app/models/groups.dart';
import 'package:flop_edt_app/navigator/app_navigator.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  final bool isDarkMode;
  final Map profs;

  const StartPage({Key key, this.isDarkMode, this.profs}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedPromo = 'INFO1';
  Group selectedGroupe = GROUPES['INFO1'][0];
  String selectedDep = 'INFO';
  String selectedProf = 'PSE';

  final fontSize = 14.0;
  bool isProf = false;

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
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Mode professeur',
                    style: TextStyle(fontSize: fontSize),
                  ),
                  AdaptableSwitch(
                      switchValue: isProf,
                      valueChanged: (b) {
                        setState(() {
                          this.isProf = b;
                        });
                      }),
                ],
              ),
            ),
            isProf ? _profContent() : _studentContent(),
            _validationButton,
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Platform.isIOS ? Container() : Text('xFlop! $VERSION'),
        ),
      ],
    ));
  }

  Widget _profContent() {
    List<String> dep = widget.profs.keys.toList();
    List<dynamic> profs = widget.profs[selectedDep];
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DropdownButton<dynamic>(
            value: selectedDep,
            items: dep.map((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (dynamic s) {
              setState(() {
                this.selectedDep = s;
                this.selectedProf = widget.profs[s][1];
              });
            },
          ),
          DropdownButton<String>(
            value: selectedProf,
            items: profs.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (p) {
              setState(() {
                this.selectedProf = p;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _studentContent() => Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedPromo,
              items: DEPARTEMENTS.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String s) {
                setState(() {
                  this.selectedPromo = s;
                  this.selectedGroupe = GROUPES[s][0];
                });
              },
            ),
            DropdownButton<Group>(
              value: selectedGroupe,
              items: GROUPES[selectedPromo].map((Group value) {
                return DropdownMenuItem<Group>(
                  value: value,
                  child: Text(value.groupe),
                );
              }).toList(),
              onChanged: (Group g) {
                setState(() {
                  this.selectedGroupe = g;
                });
              },
            ),
          ],
        ),
      );

  Widget get headingLogo => Column(
        children: <Widget>[
          Image.asset(
            LOGO_ASSET_PATH,
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
            storage.save('groupe', selectedGroupe.groupe);
            storage.save('parent', selectedGroupe.parent);
            storage.save('prof', selectedProf);
            storage.save('profdep', selectedDep);
            storage.saveBool('isprof', isProf);
            storage.saveBool('dark', false);
            storage.saveBool('animate', true);
            storage.saveBool('mono', false);

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
