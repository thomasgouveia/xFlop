import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppState state;

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    print(state.settings);
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Mode professeur'),
                        Switch.adaptive(
                          value: state.settings.isTutor,
                          onChanged: (bool newValue) {
                            setState(() {
                              state.settings.isTutor = newValue;
                              StateWidget.of(context).initData();
                              state.cache.addJSON('settings', state.settings.toJSON);
                            });
                          },
                        )
                      ],
                    ),
                    state.settings.isTutor
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Vous êtes :'),
                              DropdownButton<Tutor>(
                                hint: Text("Professeurs"),
                                value: state.settings.tutor,
                                onChanged: (Tutor value) {
                                  setState(() {
                                    state.settings.tutor = value;
                                    state.settings.saveConfiguration();
                                    StateWidget.of(context).initData();
                                  });
                                },
                                items: state.profs.map((Tutor user) {
                                  return DropdownMenuItem<Tutor>(
                                    value: user,
                                    child: Text('${user.displayName}'),
                                  );
                                }).toList(),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Mode sombre'),
                        Switch.adaptive(value: false, onChanged: null)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Animation d\'apparition'),
                        Switch.adaptive(value: false, onChanged: null)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
