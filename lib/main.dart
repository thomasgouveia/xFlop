import 'package:flop_edt_app/state_manager/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
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
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        body: Center(
          child: Text('Refactor.'),
        ),
      ),
    );
  }
}
