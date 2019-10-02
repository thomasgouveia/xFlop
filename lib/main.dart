import 'dart:convert';

import 'package:flop_edt_app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    RestartWidget(
      child: XFlopApp(),
    ),
  );
}

class XFlopApp extends StatefulWidget {
  @override
  _XFlopAppState createState() => _XFlopAppState();
}

class _XFlopAppState extends State<XFlopApp> {
  Map<String, List<dynamic>> allTutors = {};

  @override
  void initState() {
    super.initState();
    ['INFO', 'RT', 'GIM', 'CS'].forEach((departement) async =>
        allTutors[departement] = await fetchProfsByDep(departement));
  }

  ///Crée la liste des professeurs en fonction du département
  Future<List<dynamic>> fetchProfsByDep(String departement) async {
    List<dynamic> listeProfs = [];
    var url =
        'https://flopedt.iut-blagnac.fr/edt/$departement/fetch_all_tutors/';
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        listeProfs = json.decode(response.body) as List;
      }
      return listeProfs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xFlop!',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: AppStateProvider(profs: allTutors),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({this.child});

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => new _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = new UniqueKey();

  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: key,
      child: widget.child,
    );
  }
}
