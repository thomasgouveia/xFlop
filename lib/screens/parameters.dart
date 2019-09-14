import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/home_screen.dart';
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
  String promo;
  String groupe;

  @override
  void initState() {
    super.initState();
    promo = widget.preferences.promo;
    groupe = widget.preferences.groupe;
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
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainPage())),
        ),
        backgroundColor: Colors.grey[900],
        title: Text('Paramètres de l\'application'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: <Widget>[
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
              array: PROMOS,
              valeur: promo,
              mode: 'promo',
              text: 'Promotion : ',
            ),
            buildDropdown(
              array: GROUPES,
              valeur: groupe,
              mode: 'groupe',
              text: 'Groupe : ',
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
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(
          {List<String> array, String valeur, String mode, String text}) =>
      Row(
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
                  mode == 'promo' ? this.promo = s : this.groupe = s;
                  storage.save(mode, s);
                });
              },
            ),
          ),
        ],
      );
}
