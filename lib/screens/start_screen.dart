import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/home_screen.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedPromo = 'INFO1';
  String selectedGroupe = '1A';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
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
            ),
            Text(
              'Pour obtenir ton emploi du temps, merci de séléctionner ta promo et ton groupe ci-dessous',
              textAlign: TextAlign.center,
            ),
            Row(
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
            RaisedButton(
              onPressed: () {
                storage.save('promo', selectedPromo);
                storage.save('groupe', selectedGroupe);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              color: Colors.greenAccent,
              child: Text('Valider'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
    );
  }
}
