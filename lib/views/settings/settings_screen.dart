import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/login/login_screen.dart';
import 'package:flop_edt_app/views/settings/components/student_selector.dart';
import 'package:flop_edt_app/views/settings/components/tutor_settings_selector.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppState state;

  Settings settings;

  void handleSelect() {
    var theme = Theme.of(context);
    if (state.settings.isTutor) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: theme.accentColor,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      TutorSettingsSelector(
                        onSelected: (value) {
                          settings.tutor = value.tutor;
                          settings.isTutor = true;
                          StateWidget.of(context).setSettings(settings);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ));
          });
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10),
              color: theme.accentColor,
              child: Column(
                children: <Widget>[
                  StudentSettingsSelector(
                    settings: state.settings,
                    onSelected: (value) {
                      settings.department = value.department;
                      settings.groupe = value.groupe;
                      settings.promo = value.promo;
                      settings.isTutor = false;
                      StateWidget.of(context).setSettings(settings);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    settings = state.settings;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Paramètres',
                  style: theme.textTheme.headline4.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mode professeur',
                          style: theme.textTheme.bodyText1,
                        ),
                        Switch.adaptive(
                          value: state.settings.isTutor,
                          onChanged: (bool newValue) {
                            setState(() {
                              settings.isTutor = newValue;
                              StateWidget.of(context).setSettings(settings);
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          settings.isTutor ? 'Enseignant :' : 'Groupe :',
                          style: theme.textTheme.bodyText1,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: Color(0xFFFF6C00),
                          onPressed: handleSelect,
                          child: settings.isTutor
                              ? Text(
                                  ' ${settings.tutor?.initiales ?? 'Aucun enseignant.'}',
                                  style: theme.textTheme.bodyText1
                                      .copyWith(color: Colors.white),
                                )
                              : Text(' ${settings.promo}-${settings.groupe}',
                                  style: theme.textTheme.bodyText1
                                      .copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _loginButton(theme),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Text(
                    //       'Mode sombre',
                    //       style: theme.textTheme.bodyText1,
                    //     ),
                    //     Switch.adaptive(value: ThemeMode == , onChanged: null)
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Text(
                    //       'Animation d\'apparition',
                    //       style: theme.textTheme.bodyText1,
                    //     ),
                    //     Switch.adaptive()
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: theme.accentColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.all(10),
          child: Text(
            'Se connecter',
            style: theme.textTheme.button,
          ),
        ),
      );
}
