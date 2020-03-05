import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/settings/components/student_selector.dart';
import 'package:flop_edt_app/views/settings/components/tutor_settings_selector.dart';
import 'package:flutter/material.dart';

class CreateSettingsScreen extends StatefulWidget {
  @override
  _CreateSettingsScreenState createState() => _CreateSettingsScreenState();
}

class _CreateSettingsScreenState extends State<CreateSettingsScreen> {
  AppState state;

  bool isProfSelected;
  Settings settings;

  @override
  void initState() {
    super.initState();
    isProfSelected = false;
  }

  void handleSettingsReceived(dynamic value) {
    setState(() {
      settings = value;
    });
  }

  void saveSettings() => StateWidget.of(context).setSettings(settings);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'xFlop!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                    'Afin de configurer votre emploi du temps, veuillez sélectionner votre département, votre promotion ainsi que votre groupe. Si vous êtes un professeur, veuillez activer le mode professeur, puis sélectionner votre nom dans la liste. Ces informations seront modifiables à tout moment depuis les paramètres de l\'application.'),
                isProfSelected
                    ? TutorSettingsSelector(
                        onSelected: handleSettingsReceived,
                      )
                    : StudentSettingsSelector(
                        onSelected: handleSettingsReceived,
                      ),
                SizedBox(
                  height: 10,
                ),
                _validateButton(theme),
                _changeModeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeModeButton() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: FlatButton(
          onPressed: () => setState(() => isProfSelected = !isProfSelected),
          child: Text(
              isProfSelected ? 'Je suis un étudiant' : 'Je suis un enseignant'),
        ),
      );

  Widget _validateButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: settings == null ? null : () {
            saveSettings();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.all(10),
          child: Text(
            'Valider',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          color: theme.accentColor,
        ),
      );
}
