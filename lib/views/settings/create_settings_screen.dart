import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/views/settings/components/student_selector.dart';
import 'package:flop_edt_app/views/settings/components/tutor_settings_selector.dart';
import 'package:flop_edt_app/views/login/login_screen.dart';
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
                Row(
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
                Text(
                  'Afin de configurer votre emploi du temps, veuillez sélectionner votre département, votre promotion ainsi que votre groupe. Si vous êtes un professeur, veuillez activer le mode professeur, puis sélectionner votre nom dans la liste. Ces informations seront modifiables à tout moment depuis les paramètres de l\'application.',
                  style: theme.textTheme.bodyText1,
                ),
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
                _loginButton(theme),
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
        child: ElevatedButton(
          style: theme.elevatedButtonTheme.style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Se connecter',
            style: theme.textTheme.button,
          ),
        ),
      );

  Widget _validateButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: theme.elevatedButtonTheme.style,
          onPressed: settings == null
              ? null
              : () {
                  saveSettings();
                },
          
          child: Text(
            'Valider',
            style: theme.textTheme.button,
          ),
        ),
      );
}
