import 'package:flop_edt_app/components/day_text_widget.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/parameters.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key key,
    @required this.todayDate,
    @required this.context,
    @required this.preferences,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final DateTime todayDate;
  final BuildContext context;
  final Preferences preferences;

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      title: Text(
        'xFlop!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      centerTitle: false,
      actions: <Widget>[
        DayTextWidget(todayDate: widget.todayDate),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          initialValue: '',
          offset: Offset(0, 100),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: "settings",
              child: Text('Paramètres'),
            ),
            PopupMenuItem(
              value: "about",
              child: Text('À propos'),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'settings':
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Parameters(preferences: widget.preferences)));
                break;
              case 'about':
                break;
            }
          },
        ),
      ],
    );
  }
}
