import 'package:flop_edt_app/components/adaptative_switch.dart';
import 'package:flop_edt_app/components/error_widget.dart';
import 'package:flop_edt_app/models/groups.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/navigator/app_navigator.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flutter/material.dart';

class Parameters extends StatefulWidget {
  final Preferences preferences;

  const Parameters({Key key, this.preferences}) : super(key: key);

  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  String selectedPromo;
  Group selectedGroupe;
  bool isDark;
  bool isMono;
  bool isAnimated;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
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
        backgroundColor: Colors.grey[900],
        title: Text('Paramètres de l\'application'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: <Widget>[
            error != "" ? MyErrorWidget(text: error,) : Container(),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              children: <Widget>[
                Text(
                  'Général',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            buildDropdown(
                array: DEPARTEMENTS, valeur: selectedPromo, text: 'Promo :'),
            buildDropdownGroup(
              array: GROUPES[selectedPromo],
              valeur: selectedGroupe,
              text: 'Groupe: ',
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Affichage',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Mode sombre'),
                AdaptableSwitch(
                  switchValue: isDark,
                  valueChanged: (val) {
                    setState(() {
                      this.isDark = val;
                      storage.saveBool('dark', val);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cours monochrome (prochainement)'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Animation d\'apparition'),
                AdaptableSwitch(
                  switchValue: isAnimated,
                  valueChanged: (val) {
                    setState(() {
                      this.isAnimated = val;
                      storage.saveBool('animate', val);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({List<String> array, String valeur, String text}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text),
          Container(
            width: 70,
            child: DropdownButton<String>(
              value: valeur,
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
        ],
      );

  Widget buildDropdownGroup({List<Group> array, Group valeur, String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text),
        Container(
          width: 70,
          child: DropdownButton<Group>(
            value: valeur,
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
      ],
    );
  }
}
