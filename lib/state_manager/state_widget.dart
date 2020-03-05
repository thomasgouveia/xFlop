import 'package:flop_edt_app/api/api_provider.dart';
import 'package:flop_edt_app/models/cache/cache_provider.dart';
import 'package:flop_edt_app/models/resources/course.dart';
import 'package:flop_edt_app/models/resources/day.dart';
import 'package:flop_edt_app/models/resources/promotion.dart';
import 'package:flop_edt_app/models/resources/tutor.dart';
import 'package:flop_edt_app/models/state/app_state.dart';
import 'package:flop_edt_app/models/state/settings.dart';
import 'package:flop_edt_app/utils/date_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Widget permettant de gérer le state global de l'application
///Lorsque son state sera modifié, il répercutera les changements au sein de chacun de ses enfants.
class StateWidget extends StatefulWidget {
  final AppState state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_StateDataWidget>())
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  ///On stocke le state global dans un objet de type AppState
  AppState state;

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      var todayMidnight = DateUtils.todayMidnight();
      state = AppState(
        isLoading: true,
        today: todayMidnight,
        year: todayMidnight.year,
        week: DateUtils.weekNumber(todayMidnight),
      );
      this.initData();
    }
  }

  void initData() async {
    APIProvider api = APIProvider();
    CacheProvider cache = await CacheProvider.instance;
    Settings settings = await Settings.getConfiguration();

    //Chargement des données obligatoires
    var departments = await api.getDepartments();
    var map = <String, List<Promotion>>{};
    var mapProfs = <String, List<Tutor>>{};
    for (var dep in departments) {
      //On exclue RESA des départements
      if (dep != 'RESA') {
        var promos = await api.getPromotions(department: dep);
        var profs = await api.getTutorsOfDepartment(dep: dep);
        map[dep] = promos;
        mapProfs[dep] = profs;
      }
    }
    //On ajoute dans l'état
    setState(() {
      state.departments = departments;
      state.promos = map;
      state.cache = cache;
      state.profs = mapProfs;
      state.settings = settings;
    });

    if (settings == null) {
      setState(() {
        state.isLoading = false;
      });
      return;
    } else {
      createData();
    }
  }

  void createData() async {
    APIProvider api = APIProvider();
    var settings = state.settings;
    setState(() {
      state.isLoading = true;
    });
    var courses = [];
    if (settings.isTutor) {
      ///Récupération des cours de la semaine
      courses = await api.getCoursesOfProf(
        year: state.year,
        department: settings.department,
        prof: settings.tutor?.initiales,
        week: state.week,
      );
    } else {
      ///Récupération des cours de la semaine
      courses = await api.getCourses(
        year: state.year,
        department: settings.department,
        group: settings.groupe,
        promo: settings.promo,
        week: state.week,
      );
    }

    ///Récupération des jours de la semaine
    var days = await api.getCompleteWeek(
      year: state.year,
      week: state.week,
    );

    ///On map les cours en fonction de leur jour
    days.forEach((day) => this._mapCoursesToDays(day, courses));
    setState(() {
      state.cours = courses;
      state.days = days;
      state.isLoading = false;
    });
  }

  // Tutor findTutor(Settings settings, List<Tutor> profs) {
  //   Tutor parsed = settings.tutor;
  //   if (parsed == null) return null;
  //   var results = profs
  //       .where((Tutor element) => element.initiales == parsed.initiales)
  //       .toList();
  //   return results.length != 0 ? results[0] : null;
  // }

  void switchDisplayMode() {
    setState(() {
      state.settings.isGridDisplay = !state.settings.isGridDisplay;
      state.settings.saveConfiguration();
    });
  }

  void setSettings(Settings settings) {
    setState(() {
      state.settings = settings;
      createData();
      state.settings.saveConfiguration();
    });
  }

  ///Map les cours dans le jour ou ils se déroulent.
  void _mapCoursesToDays(Day day, List<Cours> courses) {
    courses.forEach((Cours cours) {
      if (DateUtils.isToday(day.date, cours.dateEtHeureDebut))
        day.cours.add(cours);
    });
    day.cours.sort((Cours c1, Cours c2) =>
        c1.dateEtHeureDebut.compareTo(c2.dateEtHeureDebut));
  }

  @override
  Widget build(BuildContext context) {
    return _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}
