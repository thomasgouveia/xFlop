import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/theme/changeThemeButtonWidget.dart';
import 'package:flop_edt_app/views/divers/about_screen.dart';
import 'package:flop_edt_app/views/divers/contact_screen.dart';
import 'package:flop_edt_app/views/loader/loading_screen.dart';
import 'package:flop_edt_app/views/login/login_screen.dart';
import 'package:flop_edt_app/views/settings/components/student_selector.dart';
import 'package:flop_edt_app/views/settings/components/tutor_settings_selector.dart';
import 'package:flutter/material.dart';

import 'components/etablissement_chooser.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppState state;

  Settings settings;

  void handleSelectEtablissement() {
    var theme = Theme.of(context);
    state = StateWidget.of(context).state;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: theme.scaffoldBackgroundColor,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    EtablissementSelector(
                      settings: state.settings,
                      onSelect: (value) {
                        setState(() {
                          settings = value;
                          //etablissementSelected = true;
                        });
                        //state.settings.saveConfiguration();
                        StateWidget.of(context).saveConfig(settings);
                        StateWidget.of(context).initData2();
                        setState(() {
                          state.isLoading = true;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ));
        });
  }

  void handleSelect() {
    var theme = Theme.of(context);
    if (state.settings.isTutor) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: theme.scaffoldBackgroundColor,
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
              color: theme.scaffoldBackgroundColor,
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Affichage',
                          style: theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              IconData(63116, fontFamily: 'MaterialIcons'),
                              color: theme.iconTheme.color,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Mode sombre',
                              style: theme.textTheme.bodyText1,
                            ),
                          ],
                        ),
                        ChangeThemeButtonWidget(),
                      ],
                    ),
                    
                    /* === Animation Switch === */
                    
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Row(
                    //       children: [
                    //         Icon(IconData(57478, fontFamily: 'MaterialIcons'),
                    //             color: theme.iconTheme.color),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'Animation d\'apparition',
                    //           style: theme.textTheme.bodyText1,
                    //         ),
                    //       ],
                    //     ),
                    //     Switch.adaptive()
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Emploi du temps',
                          style: theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(IconData(983697, fontFamily: 'MaterialIcons'),
                                color: theme.iconTheme.color),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Établissement',
                              style: theme.textTheme.bodyText1,
                            )
                          ],
                        ),
                        _etablissementButton(theme),
                      ],
                    ),
                    Row(
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
                        Row(
                          children: [
                            Icon(
                                settings.isTutor
                                    ? IconData(62753,
                                        fontFamily: 'MaterialIcons')
                                    : IconData(58091,
                                        fontFamily: 'MaterialIcons'),
                                color: theme.iconTheme.color),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              settings.isTutor ? 'Enseignant :' : 'Groupe :',
                              style: theme.textTheme.bodyText1,
                            )
                          ],
                        ),
                        _userButton(theme),
                      ],
                    ),
                    _loginButton(theme),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Divers',
                          style: theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    _contactButton(theme),
                    _faqButton(theme),
                    _aboutButton(theme),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userButton(ThemeData theme) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.all(10),
          shadowColor: Color(0xFFFF6C00),
          elevation: 5,
          primary: Color(0xFFFF6C00),
        ),
        onPressed: handleSelect,
        child: settings.isTutor
            ? Text(
                ' ${settings.tutor?.initiales ?? 'Aucun enseignant.'}',
                style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
              )
            : Text(' ${settings.promo}-${settings.groupe}',
                style: theme.textTheme.bodyText1.copyWith(color: Colors.white)),
      );

  Widget _loginButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          icon: Icon(IconData(63626, fontFamily: 'MaterialIcons')),
          label: Text(
            'Se connecter',
            style: theme.textTheme.button,
          ),
        ),
      );

  Widget _contactButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
            );
          },
          icon: Icon(IconData(63083, fontFamily: 'MaterialIcons')),
          label: Text(
            'Contact',
            style: theme.textTheme.button,
          ),
        ),
      );

  Widget _faqButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          icon: Icon(IconData(63081, fontFamily: 'MaterialIcons')),
          label: Text(
            'FAQ',
            style: theme.textTheme.button,
          ),
        ),
      );

  Widget _aboutButton(ThemeData theme) => Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: theme.elevatedButtonTheme.style,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutScreen()),
            );
          },
          icon: Icon(IconData(0xf816, fontFamily: 'MaterialIcons')),
          label: Text(
            'À propos',
            style: theme.textTheme.button,
          ),
        ),
      );

  Widget _etablissementButton(ThemeData theme) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.all(10),
          shadowColor: Color(0xFFFF6C00),
          elevation: 5,
          primary: Color(0xFFFF6C00),
        ),
        onPressed: handleSelectEtablissement,
        child: Text(' ${settings.etablissement.nom}',
            style: theme.textTheme.bodyText1.copyWith(color: Colors.white)),
      );
}
