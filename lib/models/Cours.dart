import 'package:flop_edt_app/utils.dart';
import 'package:flutter/material.dart';

class Cours {
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
  DateTime dateDebut;
  DateTime dateFin;
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
      this.textColor,
      this.indexInSemaine,
      this.startTime,
      this.heure,
      this.dateDebut,
      this.dateFin});

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
        color: csv[9],
      );

  bool get isExam =>
      this.coursType == 'DS' ||
      this.coursType == 'Examen' ||
      this.coursType == 'Exam' ||
      this.coursType == 'CTRL' ||
      this.coursType == 'CTRLP';
}
