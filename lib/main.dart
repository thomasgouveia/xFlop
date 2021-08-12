import 'package:flop_edt_app/router/router.dart' as Custom;
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  await DotEnv().load('.env');
  await initializeDateFormatting("fr_FR", null);
  runApp(StateWidget(child: XFlopApp()));
}

class XFlopApp extends StatefulWidget {
  @override
  _XFlopAppState createState() => _XFlopAppState();
}

class _XFlopAppState extends State<XFlopApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xFlop!',
      theme: AppTheme.darkTheme(),
      darkTheme: AppTheme.lightTheme(),
      // themeMode: ThemeMode.system,
      routes: {
        '/': (context) => Custom.Router(),
      },
    );
  }
}
