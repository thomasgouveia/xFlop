import 'package:flop_edt_app/main.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  final MyTheme theme;

  const NoConnection({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.primary,
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              size: 100,
              color: theme.textColor,
            ),
            Text('Il semble que vous ne soyez pas connecté à internet..',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: theme.textColor)),
            Text(
              'Veuillez relancer l\'application lorsque vous serez de nouveau connecté.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.textColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RaisedButton(
                child: Icon(Icons.repeat, color: theme.textColor),
                onPressed: () => RestartWidget.restartApp(context),
                color: Colors.green,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
