import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/views/edt/components/edt_chooser.dart';
import 'package:flop_edt_app/views/edt/components/week_selector.dart';
import 'package:flop_edt_app/views/settings/create_settings_screen.dart';
import 'package:flop_edt_app/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  AppState state;

  List<Widget> _children = [ScheduleChooser(), SettingsScreen()];
  int _selected = 0;

  void _onViewChanged(int index) => setState(() => _selected = index);

  @override
  Widget build(BuildContext context) {
    state = StateWidget.of(context).state;
    var theme = Theme.of(context);
    bool isQuerySettings = state.settings == null && !state.isLoading;
    return isQuerySettings
        ? CreateSettingsScreen()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                _children[_selected],
                _selected == 0 && !state.isLoading
                    ? Positioned(
                        bottom: 0,
                        child: WeekSelector(),
                      )
                    : Container(),
              ],
            ),
            bottomNavigationBar: !state.isLoading
                ? BottomNavigationBar(
                    onTap: _onViewChanged,
                    currentIndex: _selected,
                    backgroundColor: theme.scaffoldBackgroundColor,
                    selectedItemColor: theme.primaryColorLight,
                    unselectedItemColor: theme.accentColor,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.event), title: Text('EDT')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), title: Text('Paramètres'))
                    ],
                  )
                : null,
          );
  }
}
