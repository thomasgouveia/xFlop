import 'package:flop_edt_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      XFlopApp(),
    );

class XFlopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xFlop!',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'xFlop!'),
    );
  }
}
