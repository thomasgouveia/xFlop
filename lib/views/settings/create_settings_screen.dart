import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/views/settings/components/student_selector.dart';
import 'package:flop_edt_app/views/settings/components/tutor_settings_selector.dart';
import 'package:flop_edt_app/views/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'components/etablissement_chooser.dart';

class CreateSettingsScreen extends StatefulWidget {
  @override
  _CreateSettingsScreenState createState() => _CreateSettingsScreenState();
}

class _CreateSettingsScreenState extends State<CreateSettingsScreen> {
  AppState state;

  ScrollController _scrollController = new ScrollController();
  bool isProfSelected;
  bool etablissementSelected;
  Settings settings;

  @override
  void initState() {
    super.initState();
    isProfSelected = false;
    etablissementSelected = false;
  }

  void handleSettingsReceived(dynamic value) {
    setState(() {
      settings = value;
    });
  }

  void saveSettings() => StateWidget.of(context).setSettings(settings);

  void handleSelect() {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    EtablissementSelector(
                      settings: state.settings,
                      onSelect: (value) {
                        setState(() {
                          settings = value;
                          etablissementSelected = true;
                        });
                        StateWidget.of(context).saveConfig(settings);
                        StateWidget.of(context).initData2();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
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
                SizedBox(
                  height: 10,
                ),
                _etablissementButton(theme),
                etablissementSelected || state.departments.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(IconData(57583, fontFamily: 'MaterialIcons'),
                                  color: theme.iconTheme.color),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Mode professeur',
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: isProfSelected,
                            onChanged: (bool newValue) {
                              setState(() {
                                isProfSelected = newValue;
                                _scrollController.animateTo(180.0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              });
                            },
                          )
                        ],
                      )
                    : Container(),
                etablissementSelected || state.departments.isNotEmpty
                    ? isProfSelected
                        ? TutorSettingsSelector(
                            onSelected: handleSettingsReceived,
                          )
                        : StudentSettingsSelector(
                            onSelected: handleSettingsReceived,
                          )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                _validateButton(theme),
                //_loginButton(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _etablissementButton(ThemeData theme) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.all(10),
          shadowColor: Color(0xFFFF6C00),
          elevation: 5,
          primary: Color(0xFFFF6C00),
        ),
        onPressed: handleSelect,
        child: Text(settings == null
            ? 'Etablissement'
            : settings.etablissement == null
                ? 'Etablissement'
                : settings.etablissement.nom),
      );

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
