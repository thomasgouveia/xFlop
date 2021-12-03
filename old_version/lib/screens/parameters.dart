import 'package:flop_edt_app/components/adaptative_switch.dart';
import 'package:flop_edt_app/components/error_widget.dart';
import 'package:flop_edt_app/components/parameters_item.dart';
import 'package:flop_edt_app/main.dart';
import 'package:flop_edt_app/models/groups.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/navigator/app_navigator.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Parameters extends StatefulWidget {
  final Preferences preferences;
  final Map profs;

  const Parameters({Key key, this.preferences, this.profs}) : super(key: key);

  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  String selectedPromo;
  Group selectedGroupe;
  bool isDark;
  bool isMono;
  bool isAnimated;
  bool isProf;
  String selectedProf;
  String selectedDep;
  MyTheme theme;

  String error = "";
  @override
  void initState() {
    super.initState();
    selectedPromo = widget.preferences.promo;
    selectedGroupe = GROUPES[selectedPromo]
        .where((groupe) => groupe.groupe == widget.preferences.group.groupe)
        .toList()[0];
    isDark = widget.preferences.isDarkMode;
    isMono = widget.preferences.isMono;
    isAnimated = widget.preferences.isAnimated;
    selectedProf = widget.preferences.prof;
    selectedDep = widget.preferences.profDep;
    isProf = widget.preferences.isProf;
    theme = MyTheme(isDark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.textColor,
          ),
          onPressed: () {
            if (selectedGroupe != null) {
              AppNavigator.toEDT(context);
            } else {
              setState(() {
                error = "Veuillez sélectionner un groupe.";
              });
            }
          },
        ),
        backgroundColor: theme.primary,
        elevation: 0.0,
        title: Text(
          'Paramètres',
          style: TextStyle(color: theme.textColor),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: <Widget>[
            error != ""
                ? MyErrorWidget(
                    text: error,
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            heading(text: 'Général'),
            ParametersItem(
              label: 'Mode professeur',
              textColor: theme.textColor,
              child: AdaptableSwitch(
                switchValue: isProf,
                valueChanged: (val) {
                  setState(() {
                    this.isProf = !this.isProf;
                    storage.saveBool('isprof', val);
                  });
                },
              ),
            ),
            this.isProf ? profsChooser() : studentChooser(),
            Divider(
              color: Colors.grey,
            ),
            heading(text: 'Affichage'),
            ParametersItem(
              label: 'Mode sombre',
              textColor: theme.textColor,
              child: AdaptableSwitch(
                switchValue: isDark,
                valueChanged: (val) {
                  setState(() {
                    this.isDark = !isDark;
                    theme = MyTheme(isDark);
                    storage.saveBool('dark', val);
                    FlutterStatusbarcolor.setStatusBarWhiteForeground(
                        isDark ? true : false);
                  });
                },
              ),
            ),
            ParametersItem(
              label: 'Animation d\'apparition',
              textColor: theme.textColor,
              child: AdaptableSwitch(
                switchValue: isAnimated,
                valueChanged: (val) {
                  setState(() {
                    this.isAnimated = val;
                    storage.saveBool('animate', val);
                  });
                },
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            heading(text: 'Données en cache'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
            ),
            ParametersItem(
              label: 'Vider le cache \n(réinitialise l\'application)',
              textColor: theme.textColor,
              child: RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  storage.removeAll();
                  RestartWidget.restartApp(context);
                },
              ),
            ),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cours monochrome (prochainement)',
                    style: TextStyle(color: theme.textColor)),
                AdaptableSwitch(
                  switchValue: isMono,
                  valueChanged: (val) {
                    setState(() {
                      this.isMono = val;
                      storage.saveBool('mono', val);
                    });
                  },
                ),
              ],
            ),
            */
          ],
        ),
      ),
    );
  }

  Widget heading({text}) => Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.textColor),
          ),
        ],
      );

  Column studentChooser() {
    return Column(
      children: <Widget>[
        buildDropdown(
            array: DEPARTEMENTS, valeur: selectedPromo, text: 'Promo :'),
        buildDropdownGroup(
          array: GROUPES[selectedPromo],
          valeur: selectedGroupe,
          text: 'Groupe: ',
        ),
      ],
    );
  }

  Widget profsChooser() {
    List<String> dep = widget.profs.keys.toList();
    List<dynamic> profs = widget.profs[selectedDep];
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Département :', style: TextStyle(color: theme.textColor)),
            Container(
              width: 70,
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: theme.primary,
                ),
                child: DropdownButton<dynamic>(
                  value: selectedDep,
                  style: TextStyle(color: theme.textColor),
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
                      storage.save('profdep', s);
                      storage.save('prof', selectedProf);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Professeur :', style: TextStyle(color: theme.textColor)),
            Container(
              width: 70,
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: theme.primary,
                ),
                child: DropdownButton<String>(
                  value: selectedProf,
                  style: TextStyle(color: theme.textColor),
                  items: profs.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (p) {
                    setState(() {
                      this.selectedProf = p;
                      storage.save('prof', p);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDropdown({List<String> array, String valeur, String text}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: theme.textColor),
          ),
          Container(
            width: 70,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: theme.primary,
              ),
              child: DropdownButton<String>(
                value: valeur,
                style: TextStyle(color: theme.textColor),
                items: array.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String s) {
                  setState(() {
                    this.selectedPromo = s;
                    this.selectedGroupe = null;
                    storage.save('promo', s);
                    storage.save('groupe', GROUPES[s][0].groupe);
                    storage.save('parent', GROUPES[s][0].parent);
                  });
                },
              ),
            ),
          ),
        ],
      );

  Widget buildDropdownGroup({List<Group> array, Group valeur, String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(color: theme.textColor),
        ),
        Container(
          width: 70,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: theme.primary,
            ),
            child: DropdownButton<Group>(
              value: valeur,
              style: TextStyle(color: theme.textColor),
              items: array.map((Group value) {
                return DropdownMenuItem<Group>(
                  value: value,
                  child: Text(value.groupe),
                );
              }).toList(),
              onChanged: (Group g) {
                setState(() {
                  this.selectedGroupe = g;
                  storage.save('groupe', g.groupe);
                  storage.save('parent', g.parent);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
