import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class Cours {
  //32827,,PS,2B,INFO2,PSE,TP,B219,M,#fe16f4,#FFFFFF,m,1035 32826,,PS,2A,INFO2,PSE,TP,B102,M,#fe16f4,#FFFFFF,w,660 32825,,IO,3B,INFO2,PSE,TP,B103,M,#fe16f4,#FFFFFF,th,570
  var idCours;
  var nomProf;
  var nomGroupe;
  var nomPromo;
  var module;
  var coursType;
  var salle;
  var roomType;
  var indexInSemaine;
  var startTime;
  var color;
  var textColor;
  int index;
  TimeOfDay heure;

  Cours(
      {this.idCours,
      this.nomProf,
      this.nomGroupe,
      this.nomPromo,
      this.module,
      this.coursType,
      this.salle,
      this.roomType,
      this.color,
      this.index,
      this.textColor,
      this.indexInSemaine,
      this.startTime,
      this.heure});

  factory Cours.fromCSV(List<dynamic> csv) => Cours(
        idCours: csv[0],
        nomProf: csv[2],
        nomGroupe: csv[3],
        nomPromo: csv[4],
        module: csv[5],
        coursType: csv[6],
        salle: csv[7],
        roomType: csv[8],
        textColor: csv[10],
        heure: getHoursOfCourses(csv[12]),
        indexInSemaine: getIndexSemaine(csv[11]),
        startTime: csv[12],
        index: positionInJourney(csv[12]),
        color: csv[9],
      );
}