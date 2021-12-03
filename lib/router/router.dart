import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/edt/components/edt_chooser.dart';
import 'package:flop_edt_app/views/edt/components/week_selector.dart';
import 'package:flop_edt_app/views/loader/loading_screen.dart';
import 'package:flop_edt_app/views/settings/create_settings_screen.dart';
import 'package:flop_edt_app/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';

///Widget [Router] permettant de réaliser la navigation de l'application.
class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  ///State global de l'application
  AppState state;
  ThemeData theme;

  ///Les différentes vues de l'application
  List<Widget> _children = [ScheduleChooser(), SettingsScreen()];

  ///Vue courante affichée. De base, 0.
  int _selected = 0;

  ///Méthode appelée lorsque l'utilisateur clique sur un des liens dans la barre de navigation.
  ///Elle met à jour la vue appelée en fonction de l'index.
  void _onViewChanged(int index) => setState(() => _selected = index);

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    theme = Theme.of(context);
    //Booléen permettant de savoir s'il existe des paramètres ou s'il faut les créés.
    bool isQuerySettings = (state.settings == null ||
            state.settings.etablissement == null ||
            (state.settings.groupe == null && state.settings.tutor == null)) &&
        !state.isLoading;

    if (isQuerySettings) {
      return CreateSettingsScreen();
    } else {
      return state.isLoading
          ? LoadingScreen()
          : Scaffold(
              body: _buildContent,
              bottomNavigationBar: _buildNavigationBar,
            );
    }
  }

  ///Construit le contenu des vues
  Widget get _buildContent {
    return Stack(
      children: <Widget>[
        _children[_selected],
        _selected == 0 && !state.isLoading
            ? Positioned(
                bottom: 0,
                child: WeekSelector(),
              )
            : Container(),
      ],
    );
  }

  ///Construit la barre de navigation.
  Widget get _buildNavigationBar {
    if (!state.isLoading || _selected == 1) {
      return BottomNavigationBar(
        onTap: _onViewChanged,
        currentIndex: _selected,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: theme.primaryColorLight,
        unselectedItemColor: !(theme.iconTheme.color == Colors.white)
            ? Color(0xFF383838)
            : theme.primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'EDT'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Paramètres')
        ],
      );
    }
    return null;
  }
}
