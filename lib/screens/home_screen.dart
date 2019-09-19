import 'dart:async';

import 'package:flop_edt_app/components/custom_appbar.dart';
import 'package:flop_edt_app/components/edt_viewer.dart';
import 'package:flop_edt_app/models/Cours.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/start_screen.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flop_edt_app/utils/week_utils.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends StatefulWidget {
  @override
  _AppStateProviderState createState() => _AppStateProviderState();
}

class _AppStateProviderState extends State<AppStateProvider> {
  bool isLoading = true;

  DateTime todayDate;
  DateTime currentDate;
  int defaultWeek;
  int currentWeek;
  Preferences preferences;

  PageController _viewerController;
  List<int> nextWeeks;

  Map<int, Map<int, List<Cours>>> allWeeksCourses;

  //Booléen permettant de savoir si oui ou non la date calculée est un week end
  bool isWeekEnd;

  @override
  void initState() {
    super.initState();
    todayDate = DateTime.now();
    currentDate = todayDate;
    isWeekEnd = weekendTest(todayDate);
    defaultWeek =
        isWeekEnd ? Week.weekNumber(todayDate) + 1 : Week.weekNumber(todayDate);
    currentWeek =
        defaultWeek; //Current garde toujours la semaine active en mémoire
    nextWeeks = Week.calculateThreeNext(todayDate, defaultWeek);
    _viewerController = PageController(initialPage: currentDate.weekday - 1);
    if (this.mounted) {
      loadPreferences();
      loadAllWeeks();
    }
  }

  ///Change l'état de chargement
  setLoading(bool loading) => setState(() => this.isLoading = loading);

  ///Renvoi vrai si la date est un week end, faux sinon
  weekendTest(DateTime date) => date.weekday == 6 || date.weekday == 7;

  ///Charge les [Preferences] ou null si rien n'est trouvé.
  loadPreferences() async {
    String promo = await storage.read('promo');
    String groupe = await storage.read('groupe');
    //bool dark = await storage.readBool('dark');
    setState(() {
      preferences = groupe != null && promo != null
          ? Preferences(groupe: groupe, promo: promo, isDarkMode: false, isAnimated: true, isMono: false)
          : null;
    });
  }

  //Crée la map correspond au jour de la semaine
  Map<int, List<Cours>> setMap() => {
        1: new List<Cours>(),
        2: new List<Cours>(),
        3: new List<Cours>(),
        4: new List<Cours>(),
        5: new List<Cours>(),
      };

  loadAllWeeks() async {
    Map<int, Map<int, List<Cours>>> toSet = {};
    for (int i = 0; i < nextWeeks.length; i++) {
      toSet[nextWeeks[i]] = await initData(nextWeeks[i]);
    }
    setState(() {
      allWeeksCourses = toSet;
      this.isLoading = false;
    });
  }

  ///initialise la liste des cours
  Future<Map> initData(int week) async {
    Map weekMap = setMap();
    List<List<dynamic>> list = await fetchEDTData(
        week, week == 1 ? todayDate.year + 1 : todayDate.year);
    for (int i = 1; i < list.length; i++) {
      var sublist = list[i];
      Cours cours = Cours.fromCSV(sublist);
      switch (cours.indexInSemaine) {
        case 1:
          weekMap[1].add(cours);
          break;
        case 2:
          weekMap[2].add(cours);
          break;
        case 3:
          weekMap[3].add(cours);
          break;
        case 4:
          weekMap[4].add(cours);
          break;
        case 5:
          weekMap[5].add(cours);
          break;
      }
    }
    return weekMap;
  }

  ///Recalcule la date du jour en fonction d—u changement de vue
  _handleDayChanged(int index) => Timer(
      Duration(milliseconds: 200),
      () => setState(() {
            todayDate.weekday <= index
                ? todayDate = todayDate.add(Duration(days: 1))
                : todayDate = todayDate.subtract(Duration(days: 1));
          }));

  ///Fonction qui met à jour l'application lors d'un changement de semaine
  //! REVOIR LE CALCUL DES JOURS
  _handleWeekChanged(dynamic week) {
    _viewerController.animateToPage(
        week == currentWeek ? currentDate.weekday - 1 : 0,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 1));
    var wkNb = Week.weekNumber(todayDate);
    var diff = ((week < wkNb ? wkNb - week : week - wkNb) * 7);
    this.todayDate = week < wkNb
        ? todayDate.subtract(Duration(days: diff))
        : todayDate.add(Duration(days: diff));
    print(todayDate);
    setState(() {
      this.defaultWeek = week;
    });
  }

  ///Retourne la [Map] des cours indexés par leur apparation dans la journée
  Map _mapCourses(int index) {
    List<Cours> filteredCours = applyFilters(index);
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
  List<Cours> applyFilters(int index) {
    List<Cours> filtered = allWeeksCourses[index][todayDate.weekday]
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

  ///Construit l'interface en fonction de l'état de l'application
  Widget buildContent() {
    if (preferences == null) {
      return StartPage();
    } else if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: CustomAppBar(
            todayDate: todayDate, context: context, preferences: preferences),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              /*
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: WeekChooser(
                    weeks: nextWeeks,
                    valueChanged: _handleWeekChanged,
                  ),
                ),
              ),
              */
              Expanded(
                child: PageView.builder(
                  controller: _viewerController,
                  onPageChanged: _handleDayChanged,
                  itemCount: allWeeksCourses[defaultWeek].length,
                  itemBuilder: (context, int index) {
                    return EDTViewer(
                      coursesMap: _mapCourses(defaultWeek),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(allWeeksCourses);
    isWeekEnd = weekendTest(todayDate);
    currentDate = DateTime.now();
    if (this.isWeekEnd) {
      int day = todayDate.weekday == 6
          ? todayDate.day + 2
          : todayDate.weekday == 7 ? todayDate.day + 1 : todayDate.day;
      this.todayDate = DateTime(todayDate.year, todayDate.month, day);
    }
    return buildContent();
  }
}
