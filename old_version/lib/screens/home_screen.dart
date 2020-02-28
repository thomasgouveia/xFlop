import 'dart:async';
import 'package:flop_edt_app/components/custom_appbar.dart';
import 'package:flop_edt_app/components/edt/landscape_view.dart';
import 'package:flop_edt_app/components/edt_viewer.dart';
import 'package:flop_edt_app/components/empty_day.dart';
import 'package:flop_edt_app/components/global/wrapper.dart';
import 'package:flop_edt_app/components/loading_widget.dart';
import 'package:flop_edt_app/components/no_connection_screen.dart';
import 'package:flop_edt_app/components/tutors/tutor_indicator.dart';
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
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

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
  Map<String, List<dynamic>> allTutors;

  //Booléen permettant de savoir si oui ou non la date calculée est un week end
  bool isWeekEnd;

  @override

  ///Initialise l'état initial au lancement de l'application.
  ///Calcule la date du jour à afficher en fonction de l'heure (si 19h dépassé alors on passe au jour d'après)
  ///Effectue le test de si on est un week end ou non
  ///Calcule le numéro de semaine correspondant à la date précèdemment calculé
  ///Calcule les numéros 3 semaines suivants celle actuelle
  ///Une fois le composant monté, récupère la liste des profs, puis charge les préférences (groupe, promo etc..),
  ///défini le thème, détermine le département, puis vérifie si l'utilisateur est connecté à internet pour pouvoir
  ///télécharger les données de l'emploi du temps.
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
      fetchProfs().then((_) => loadPreferences().then((_) {
            theme = MyTheme(preferences.isDarkMode ?? false);
            departement = preferences.promo.substring(
                0,
                preferences.promo == 'RT2A'
                    ? preferences.promo.length - 2
                    : preferences.promo.length - 1);
            if (isConnected) {
              loadAllWeeks();
            }
          }));
    }
  }

  ///Change l'état de chargement
  ///[loading] est de type [bool], prends soit true, soit false comme valeur.
  setLoading(bool loading) => setState(() => this.isLoading = loading);

  ///Renvoi vrai si la date est un week end, faux sinon
  ///retourne un [bool] en fonction de si la [DateTime] fournie est un jour de week end
  weekendTest(DateTime date) => date.weekday == 6 || date.weekday == 7;

  ///Charge les [Preferences] ou null si rien n'est trouvé.
  Future loadPreferences() async {
    String promo = await storage.read('promo');
    String groupe = await storage.read('groupe');
    String parent = await storage.read('parent');
    bool dark = await storage.readBool('dark');
    bool animate = await storage.readBool('animate');
    bool mono = await storage.readBool('mono');
    bool mProf = await storage.readBool('isprof');
    String prof = await storage.read('prof');
    String profDep = await storage.read('profdep');

    //Check connection status :
    bool isConnected = await ConnectionChecker.isConnected();
    setState(() {
      if (parent == null || promo == null || mProf == null) {
        storage.removeAll();
        this.preferences = null;
      } else {
        this.isConnected = isConnected;
        preferences = groupe != null && promo != null
            ? Preferences(
                group: Group(groupe: groupe, parent: parent),
                isProf: mProf,
                prof: prof,
                profDep: profDep,
                promo: promo,
                isDarkMode: dark ?? false,
                isAnimated: animate ?? true,
                isMono: mono ?? false)
            : null;
      }
    });
  }

  ///Télécharge toutes les semaines disponibles dans l'application, pour un département.
  ///
  loadAllWeeks() async {
    Map<int, Map<int, List<Cours>>> toSet = {};
    for (int i = 0; i < nextWeeks.length; i++) {
      var current = nextWeeks[i];
      setState(() {
        _currentLoading = current;
      });
      print(current);
      toSet[current] = await initData(current);
    }
    setState(() {
      courses = toSet;
      this.isLoading = false;
    });
  }

  Future fetchProfs() async {
    allTutors = {};
    ['INFO', 'RT', 'GIM', 'CS'].forEach((departement) async =>
        allTutors[departement] = await fetchProfsByDep(departement));
  }

  ///initialise la liste des cours pour la semaine donnée.
  Future<Map> initData(int week) async {
    Map weekMap = setMap();
    List<List<dynamic>> list = preferences.isProf
        ? await loadDataFromServerProf(week,
            week == 1 ? todayDate.year + 1 : todayDate.year, preferences.prof)
        : await loadDataFromServer(
            week, week == 1 ? todayDate.year + 1 : todayDate.year, departement);
    for (int i = 1; i < list.length; i++) {
      var sublist = list[i];
      Cours cours = Cours.fromCSV(sublist);
      cours.coursDep = cours.nomPromo == 'RT2A'
          ? cours.nomPromo.substring(0, cours.nomPromo.length - 2)
          : cours.nomPromo.substring(0, cours.nomPromo.length - 1);
      cours.dateDebut = DateTime(todayDate.year, todayDate.month, todayDate.day,
          cours.heure.hour, cours.heure.minute);
      cours.dateFin = cours.dateDebut
          .add(Duration(minutes: constraints[cours.coursDep][cours.coursType] ?? 90));
      weekMap[cours.indexInSemaine].add(cours);
    }
    return weekMap;
  }

  ///Recalcule la date du jour en fonction d—u changement de vue
  _handleDayChanged(int index) => Timer(
      Duration(milliseconds: 250),
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
  List<Cours> applyFilters(bool isGrid, int index, {DateTime day}) =>
      preferences.isProf
          ? filterProf(index, courses, isGrid ? day : todayDate, preferences)
          : filter(index, courses, isGrid ? day : todayDate, preferences);

  ///Construit l'interface en fonction de l'état de l'application
  Widget buildContent() {
    if (preferences == null && allTutors != null) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      return StartPage(
        profs: allTutors,
      );
    } else if (!isConnected) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(
          preferences.isDarkMode ? true : false);
      return NoConnection(
        theme: theme,
      );
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(
          preferences.isDarkMode ? true : false);
      return Scaffold(
        backgroundColor: theme.primary,
        appBar: CustomAppBar(
            todayDate: todayDate,
            context: context,
            preferences: preferences,
            profs: allTutors,
            theme: theme),
        body: isLoading
            ? LoadingWidget(
                semaine: _currentLoading,
                theme: theme,
              )
            : _staticBody,
      );
    }
  }

  ///Méthode qui contient les éléments de l'interface.
  Widget get _staticBody {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return WrapperWidget(
      left: 5,
      right: 5,
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
          TutorIndicator(preferences: preferences, color: theme.textColor),
          Expanded(
            child: PageView.builder(
                    controller: _viewerController,
                    onPageChanged: _handleDayChanged,
                    itemCount: courses[defaultWeek].length,
                    itemBuilder: (context, int index) {
                      List<Cours> l = applyFilters(false, defaultWeek);
                      return l.length == 0
                          ? EmptyDay(
                              theme: theme,
                            )
                          : EDTViewer(
                              listCourses: l,
                              promo: departement,
                              animate: preferences.isAnimated,
                              theme: theme,
                              isProf: preferences.isProf,
                              today: todayDate,
                            );
                    },
                  )
                  /*
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1500,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Row(
                            children: _generateGrid,
                          ),
                        ],
                      ),
                    ),
                  ),
                  */
          ),
        ],
      ),
    );
  }

  List<Widget> get _generateGrid {
    List<Widget> list = [];
    var monday = todayDate.weekday > 1
        ? todayDate.subtract(Duration(days: todayDate.weekday - 1))
        : todayDate;
    for (int i = 0; i < 5; i++) {
      list.add(
        Expanded(
          child: EDTViewer(
            listCourses: applyFilters(true, defaultWeek,
                day: monday.add(Duration(days: i))),
            primary: false,
            isHours: false,
            promo: departement,
            animate: preferences.isAnimated,
            theme: theme,
            isProf: preferences.isProf,
            today: monday.add(Duration(days: i)),
          ),
        ),
      );
    }
    return list;
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
