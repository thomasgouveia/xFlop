import 'dart:async';

import 'package:flop_edt_app/components/day_text_widget.dart';
import 'package:flop_edt_app/components/edt_viewer.dart';
import 'package:flop_edt_app/models/Cours.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/parameters.dart';
import 'package:flop_edt_app/screens/start_screen.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flop_edt_app/utils/week_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = true;

  DateTime todayDate;
  int defaultWeek;
  Preferences preferences;

  PageController _viewerController;

  ///[Map] servant à stocker les cours en fonction du jour de la semaine
  Map<int, List<Cours>> coursMap = {
    1: new List<Cours>(),
    2: new List<Cours>(),
    3: new List<Cours>(),
    4: new List<Cours>(),
    5: new List<Cours>(),
  };

  bool
      isWeekEnd; //Booléen permettant de savoir si oui ou non la date calculée est un week end

  @override
  void initState() {
    super.initState();
    todayDate = DateTime.now();
    isWeekEnd = todayDate.weekday == 6 || todayDate.weekday == 7;
    defaultWeek =
        isWeekEnd ? Week.weekNumber(todayDate) + 1 : Week.weekNumber(todayDate);
    loadPreferences();
    initData();
  }

  ///Charge les [Preferences] ou null si rien n'est trouvé.
  loadPreferences() async {
    String promo = await storage.read('promo');
    String groupe = await storage.read('groupe');
    setState(() {
      preferences = groupe != null && promo != null
          ? Preferences(groupe: groupe, promo: promo)
          : null;
    });
  }

  ///initialise la liste des cours
  void initData() {
    fetchEDTData(this.defaultWeek, this.todayDate.year).then((list) {
      for (int i = 1; i < list.length; i++) {
        var sublist = list[i];
        Cours cours = Cours.fromCSV(sublist);
        switch (cours.indexInSemaine) {
          case 1:
            coursMap[1].add(cours);
            break;
          case 2:
            coursMap[2].add(cours);
            break;
          case 3:
            coursMap[3].add(cours);
            break;
          case 4:
            coursMap[4].add(cours);
            break;
          case 5:
            coursMap[5].add(cours);
            break;
        }
      }
      setState(() {
        this.isLoading = false;
      });
    });
  }

  ///Recalcule la date du jour en fonction du changement de vue
  _handleDayChanged(int index) => Timer(
      Duration(milliseconds: 200),
      () => setState(() => todayDate.weekday <= index
          ? todayDate = todayDate.add(Duration(days: 1))
          : todayDate = todayDate.subtract(Duration(days: 1))));

  ///Retourne la [Map] des cours indexés par leur apparation dans la journée
  Map _mapCourses() {
    List<Cours> filteredCours = applyFilters();
    //Défini les cours disponibles dans la journée
    Map map = {
      0: null, //8h
      1: null, //9h30
      2: null, //11h05
      3: null, //Pause dejeuner (null constant)
      4: null, //14h15
      5: null, //15h45
      6: null, //17h10
    };
    for (int i = 0; i < filteredCours.length; i++) {
      Cours cours = filteredCours[i];
      if (cours.index == 3) {
        map[3] = null; // Pause repas
      } else {
        map[cours.index] = filteredCours[i];
      }
    }
    return map;
  }

  ///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
  List<Cours> applyFilters() {
    List<Cours> filtered = coursMap[todayDate.weekday]
        .where((cours) =>
            cours.nomPromo == preferences.promo &&
            (cours.nomGroupe.toString() == preferences.groupe ||
                cours.nomGroupe.toString() ==
                    preferences.groupe[0].toString() ||
                cours.nomGroupe.toString() == "CE"))
        .toList();
    filtered.sort((c1, c2) => c1.startTime.compareTo(c2.startTime));
    return filtered;
  }

  Widget buildContent() {
    if (preferences == null) {
      return StartPage();
    } else {
      return Scaffold(
        appBar: AppBar(
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
            DayTextWidget(todayDate: todayDate),
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
                            Parameters(preferences: preferences)));
                    break;
                  case 'about':
                    break;
                }
              },
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _viewerController,
                  onPageChanged: _handleDayChanged,
                  itemCount: coursMap.length,
                  itemBuilder: (context, int index) {
                    return EDTViewer(
                      coursesMap: _mapCourses(),
                    );
                  },
                ),
              ),
      );
    }
  }

  Widget parameters() => Scaffold(
        appBar: AppBar(
          title: Text('Paramètres de l\'application'),
        ),
        body: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: preferences.promo,
              items: PROMOS.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String s) {
                setState(() {
                  this.preferences.promo = s;
                  storage.save('promo', s);
                });
              },
            ),
            DropdownButton<String>(
              value: preferences.groupe,
              items: GROUPES.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String s) {
                setState(() {
                  this.preferences.groupe = s;
                  storage.save('groupe', s);
                });
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    _viewerController = PageController(initialPage: todayDate.weekday - 1);
    if (this.isWeekEnd) {
      int day = todayDate.weekday == 6
          ? todayDate.day + 2
          : todayDate.weekday == 7 ? todayDate.day + 1 : todayDate.day;
      this.todayDate = DateTime(todayDate.year, todayDate.month, day);
    }
    return buildContent();
  }
}
