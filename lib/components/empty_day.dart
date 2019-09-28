import 'package:flop_edt_app/components/fade_in.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flutter/material.dart';

class EmptyDay extends StatelessWidget {
  final MyTheme theme;

  const EmptyDay({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(0.9, _ui);
  }

  Widget get _ui => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vous n\'avez pas cours aujourd\'hui. \n Quelle chance !',
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.textColor, fontSize: 16),
            ),
          ],
        ),
      );
}
