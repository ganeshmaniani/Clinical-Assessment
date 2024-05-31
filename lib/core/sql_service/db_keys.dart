import 'package:flutter/material.dart';

@immutable
class DBKeys {
  const DBKeys._();

  ///DataBase Name
  static const String dbName = 'clinical_db';

  ///DataBase Table Name
  static const String dbStudentTable = 'student_detail';
  static const String dbDiseaseTable = 'disease_detail';

  ///DataBase Column Name For StudentTable
  static const String dbColumnId = 'id';
  static const String dbStudentName = 'student_name';
  static const String dbStudentAge = 'student_age';
  static const String dbStudentGender = 'student_gender';
  static const String dbStudentSchool = 'student_school';

  ///DataBase Column Name For DiseaseTable
  static const String dbStudentId = 'student_id';
  static const String dbDiseaseName = 'disease_name';
  static const String dbDiseaseScore = 'disease_score';
  static const String dbDiseaseImage = "disease_image";
}
