import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PasswordForgotScreen extends StatefulWidget {
  @override
  _PasswordForgotScreenState createState() => _PasswordForgotScreenState();
}

class _PasswordForgotScreenState extends State<PasswordForgotScreen> {
  AppState state;
  bool buttonActivated = false;
  TextEditingController emailController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Constants.logoPath,
                    width: 100,
                  ),
                  Text(
                    'xFlop!',
                    style: theme.textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Mot de passe oublié ?',
              style: theme.textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Un lien sera envoyé à l\'adresse suivante',
              style: theme.textTheme.headline4.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            _mailAdressTextfield(theme),
            _sendButton(theme)
          ],
        ),
      ),
    );
  }

  Widget _mailAdressTextfield(ThemeData theme) => Container(
        margin: EdgeInsets.all(15),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              labelText: 'Adresse e-mail',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un e-mail'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
            if (emailController.text.isValidEmail()) {
              setState(() {
                buttonActivated = true;
              });
            } else {
              setState(() {
                buttonActivated = false;
              });
            }
          },
        ),
      );

  Widget _sendButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: theme.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
          ),
          onPressed: (buttonActivated)
              ? null
              : () {
                  // == TODO ==
                  //
                  // emailSending();
                  //
                  // ==========
                },
          child: Text(
            'Envoyer',
            style: theme.textTheme.button,
          ),
        ),
      );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
