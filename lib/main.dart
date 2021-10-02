import 'package:flop_edt_app/router/router.dart' as Custom;
import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flop_edt_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future main() async {
  //await DotEnv().load('.env');
  await initializeDateFormatting("fr_FR", null);
  runApp(StateWidget(child: XFlopApp()));
}

class XFlopApp extends StatefulWidget {
  @override
  _XFlopAppState createState() => _XFlopAppState();
}

class _XFlopAppState extends State<XFlopApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        themeProvider.getMode().then((value) {
          setState(() {
            themeProvider.themeMode = value;
          });
        });
        themeProvider.isDarkMode.then((value) {
          setState(() {
            value ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light) : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          });
        });
        return MaterialApp(
          color: Color(0xFF07023B),
          debugShowCheckedModeBanner: false,
          title: 'xFlop!',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeProvider.themeMode,
          routes: {
            '/': (context) => Custom.Router(),
          },
        );
      });
}
