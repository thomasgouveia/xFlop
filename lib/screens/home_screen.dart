import 'dart:async';
import 'package:flop_edt_app/components/custom_appbar.dart';
import 'package:flop_edt_app/components/edt_viewer.dart';
import 'package:flop_edt_app/components/loading_widget.dart';
import 'package:flop_edt_app/components/no_connection_screen.dart';
import 'package:flop_edt_app/components/week_chooser.dart';
import 'package:flop_edt_app/filterer/filters.dart';
import 'package:flop_edt_app/models/cours.dart';
import 'package:flop_edt_app/models/groups.dart';
import 'package:flop_edt_app/models/user_preferences.dart';
import 'package:flop_edt_app/screens/start_screen.dart';
import 'package:flop_edt_app/themes/theme.dart';
import 'package:flop_edt_app/utils.dart';
import 'package:flop_edt_app/utils/connection_checker.dart';
import 'package:flop_edt_app/utils/constants.dart';
import 'package:flop_edt_app/utils/map_utils.dart';
import 'package:flop_edt_app/utils/shared_storage.dart';
import 'package:flop_edt_app/utils/week_utils.dart';
import 'package:flutter/material.dart';

class AppStateProvider extends StatefulWidget {
  @override
  _AppStateProviderState createState() => _AppStateProviderState();
}

class _AppStateProviderState extends State<AppStateProvider> {
  bool isLoading = true;
  bool isConnected;
  int _currentLoading; //For screen loading

  DateTime todayDate;
  DateTime currentDate;
  int defaultWeek;
  int currentWeek;
  Preferences preferences;
  MyTheme theme;
  String departement;

  PageController _viewerController;
  List<int> nextWeeks;

  Map<int, Map<int, List<Cours>>> courses;

  //Booléen permettant de savoir si oui ou non la date calculée est un week end
  bool isWeekEnd;

  @override
  void initState() {
    super.initState();
    todayDate = DateTime.now().hour >= 19
        ? DateTime.now().add(Duration(days: 1))
        : DateTime.now();
    currentDate = todayDate;
    isWeekEnd = weekendTest(todayDate);
    defaultWeek =
        isWeekEnd ? Week.weekNumber(todayDate) + 1 : Week.weekNumber(todayDate);
    currentWeek =
        defaultWeek; //Current garde toujours la semaine active en mémoire
    nextWeeks = Week.calculateThreeNext(todayDate, defaultWeek);
    if (this.mounted) {
      loadPreferences().then((_) {
        theme = MyTheme(preferences.isDarkMode);
        departement = preferences.promo.substring(
            0,
            preferences.promo == 'RT2A'
                ? preferences.promo.length - 2
                : preferences.promo.length - 1);
        if (isConnected) {
          loadAllWeeks();
        }
      });
    }
  }

  ///Change l'état de chargement
  setLoading(bool loading) => setState(() => this.isLoading = loading);

  ///Renvoi vrai si la date est un week end, faux sinon
  weekendTest(DateTime date) => date.weekday == 6 || date.weekday == 7;

  ///Charge les [Preferences] ou null si rien n'est trouvé.
  Future loadPreferences() async {
    String promo = await storage.read('promo');
    String groupe = await storage.read('groupe');
    String parent = await storage.read('parent');
    bool dark = await storage.readBool('dark');
    bool animate = await storage.readBool('animate');
    bool mono = await storage.readBool('mono');

    //Check connection status :
    bool isConnected = await ConnectionChecker.isConnected();
    setState(() {
      if (parent == null || promo == null) {
        storage.removeAll();
        this.preferences = null;
      } else {
        this.isConnected = isConnected;
        preferences = groupe != null && promo != null
            ? Preferences(
                group: Group(groupe: groupe, parent: parent),
                promo: promo,
                isDarkMode: dark ?? false,
                isAnimated: animate ?? true,
                isMono: mono ?? false)
            : null;
      }
    });
  }

  ///Charge toutes les semaines disponibles dans l'application
  loadAllWeeks() async {
    Map<int, Map<int, List<Cours>>> toSet = {};
    for (int i = 0; i < nextWeeks.length; i++) {
      setState(() {
        _currentLoading = nextWeeks[i];
      });
      toSet[nextWeeks[i]] = await initData(nextWeeks[i]);
    }
    setState(() {
      courses = toSet;
      this.isLoading = false;
    });
  }

  ///initialise la liste des cours
  Future<Map> initData(int week) async {
    Map weekMap = setMap();
    List<List<dynamic>> list = await loadDataFromServer(
        week, week == 1 ? todayDate.year + 1 : todayDate.year, departement);
    for (int i = 1; i < list.length; i++) {
      var sublist = list[i];
      Cours cours = Cours.fromCSV(sublist);
      cours.dateDebut = DateTime(todayDate.year, todayDate.month, todayDate.day,
          cours.heure.hour, cours.heure.minute);
      cours.dateFin = cours.dateDebut
          .add(Duration(minutes: constraints[departement][cours.coursType]));
      weekMap[cours.indexInSemaine].add(cours);
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
  _handleWeekChanged(dynamic week) {
    var weekNumber = defaultWeek;
    bool isNewWeekBeforeActual = week < weekNumber;
    bool isSameWeek = week == weekNumber;
    var diff = ((isSameWeek
            ? 0
            : isNewWeekBeforeActual ? weekNumber - week : week - weekNumber) *
        7);
    currentDate = isNewWeekBeforeActual
        ? currentDate.subtract(Duration(days: diff))
        : currentDate.add(Duration(days: diff));
    setState(() {
      this.todayDate = currentDate;
      this.defaultWeek = week;
    });
  }

  ///Applique les filtres utilisateurs sur la liste de cours (évite de fetch à chaque changement)
  List<Cours> applyFilters(int index) =>
      filter(index, courses, todayDate, preferences);

  ///Construit l'interface en fonction de l'état de l'application
  Widget buildContent() {
    if (preferences == null) {
      return StartPage();
    } else if (!isConnected) {
      return NoConnection(
        theme: theme,
      );
    } else {
      return Scaffold(
        backgroundColor: theme.primary,
        appBar: CustomAppBar(
            todayDate: todayDate, context: context, preferences: preferences),
        body: isLoading
            ? LoadingWidget(
                semaine: _currentLoading,
                theme: theme,
              )
            : Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: WeekChooser(
                          theme: theme,
                          weeks: nextWeeks,
                          valueChanged: _handleWeekChanged,
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _viewerController,
                        onPageChanged: _handleDayChanged,
                        itemCount: courses[defaultWeek].length,
                        itemBuilder: (context, int index) {
                          return EDTViewer(
                            listCourses: applyFilters(defaultWeek),
                            promo: departement,
                            animate: preferences.isAnimated,
                            theme: theme,
                            today: todayDate,
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
    _viewerController = PageController(initialPage: todayDate.weekday - 1);
    currentDate = todayDate;
    isWeekEnd = weekendTest(todayDate);
    if (this.isWeekEnd) {
      this.todayDate = todayDate.weekday == 6
          ? todayDate.add(Duration(days: 2))
          : todayDate.weekday == 7
              ? todayDate.add(Duration(days: 1))
              : this.todayDate;
    }
    return buildContent();
  }
}
