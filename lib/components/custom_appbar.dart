import 'package:flop_edt_app/components/about_dialog.dart';
import 'package:flop_edt_app/components/day_text_widget.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/navigator/app_navigator.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flop_edt_app/utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key key,
    @required this.theme,
    @required this.todayDate,
    @required this.context,
    @required this.preferences,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final DateTime todayDate;
  final BuildContext context;
  final MyTheme theme;
  final Preferences preferences;

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  static const MENU_SETTINGS_VALUE = "settings";
  static const MENU_ABOUT_VALUE = "about";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _leading,
      backgroundColor: Colors.grey[900],
      title: _title,
      centerTitle: false,
      actions: <Widget>[
        DayTextWidget(todayDate: widget.todayDate),
        _menu,
      ],
    );
  }

  ///Construit le menu [PopMenuButton]
  Widget get _menu => Theme(
        data: Theme.of(context).copyWith(
          cardColor: widget.theme.primary,
        ),
        child: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          initialValue: '',
          offset: Offset(0, 100),
          itemBuilder: (context) => [
            _menuItem('Paramètres', MENU_SETTINGS_VALUE, Icons.settings),
            _menuItem('À propos', MENU_ABOUT_VALUE, Icons.info_outline),
          ],
          onSelected: _handleMenuClicked,
        ),
      );

  ///Crée un menu item avec comme valeur [value], icone [icon]
  ///text affiché [text]
  Widget _menuItem(String text, String value, IconData icon) => PopupMenuItem(
        value: value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: widget.theme.textColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child:
                  Text(text, style: TextStyle(color: widget.theme.textColor)),
            ),
          ],
        ),
      );

  ///Retourne le [Text] titre
  Widget get _title => Text(
        'xFlop!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      );

  ///Retourne le logo de l'application
  Widget get _leading => SizedBox(
        child: Center(
          child: Image.asset(
            LOGO_ASSET_PATH,
            width: 45,
            fit: BoxFit.contain,
          ),
        ),
      );

  _handleMenuClicked(String value) {
    switch (value) {
      case MENU_SETTINGS_VALUE:
        AppNavigator.toParameters(context, widget.preferences);
        break;
      case MENU_ABOUT_VALUE:
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            buttonText: "Fermer",
          ),
        );
        break;
    }
  }
}
