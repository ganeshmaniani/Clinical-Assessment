import 'package:flutter/material.dart';

@immutable
class DBKeys {
  const DBKeys._();

  ///DataBase Name
  static const String dbName = 'clinical_db';

  ///DataBase Table Name
  static const String dbStudentTable = 'student_detail';

  ///DataBase Column Name For StudentTable
  static const String dbColumnId = 'id';
  static const String dbStudentName = 'student_name';
  static const String dbStudentAge = 'student_age';
  static const String dbStudentGender = 'student_gender';
  static const String dbStudentSchool = 'student_school';
}
