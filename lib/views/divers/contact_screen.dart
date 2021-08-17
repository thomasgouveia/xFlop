import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              'Contact',
              style: theme.textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _emailTextfield(theme),
            _recipientTextfield(theme),
            _objectTextfield(theme),
            _textBodyTextfield(theme),
            _sendButton(theme)
          ],
        ),
      ),
    ));
  }

  Widget _emailTextfield(ThemeData theme) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Adresse e-mail',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un e-mail'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
          //   if (userController.text != "") {
          //     setState(() {
          //       userNoEmpty = true;
          //     });
          //   } else {
          //     setState(() {
          //       userNoEmpty = false;
          //     });
          //   }
          },
        ),
      );

  Widget _recipientTextfield(ThemeData theme) => Padding(
        padding:const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Destinataire',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un destinataire'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
          //   if (userController.text != "") {
          //     setState(() {
          //       userNoEmpty = true;
          //     });
          //   } else {
          //     setState(() {
          //       userNoEmpty = false;
          //     });
          //   }
          },
        ),
      );

  Widget _objectTextfield(ThemeData theme) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Objet',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un objet'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
          //   if (userController.text != "") {
          //     setState(() {
          //       userNoEmpty = true;
          //     });
          //   } else {
          //     setState(() {
          //       userNoEmpty = false;
          //     });
          //   }
           },
        ),
      );

  Widget _textBodyTextfield(ThemeData theme) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 30),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.accentColor, width: 2.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0)),
              labelText: 'Message',
              labelStyle: theme.textTheme.bodyText1,
              hintText: 'Entrez un message'),
          style: theme.textTheme.bodyText1,
          onChanged: (value) {
          //   if (userController.text != "") {
          //     setState(() {
          //       userNoEmpty = true;
          //     });
          //   } else {
          //     setState(() {
          //       userNoEmpty = false;
          //     });
          //   }
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
