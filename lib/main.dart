import 'package:flop_edt_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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


