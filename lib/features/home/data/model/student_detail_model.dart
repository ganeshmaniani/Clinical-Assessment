import 'package:skin_disease_backup/core/sql_service/db_keys.dart';

class StudentDetailModel {
  int? id;
  String? studentName;
  String? studentAge;
  String? studentGender;
  String? studentSchool;
  StudentDetailModel(
      {this.id,
      this.studentName,
      this.studentAge,
      this.studentGender,
      this.studentSchool});
  StudentDetailModel.fromJson(Map<String, dynamic> json) {
    id = json[DBKeys.dbColumnId];
    studentName = json[DBKeys.dbStudentName];
    studentAge = json[DBKeys.dbStudentAge];
    studentGender = json[DBKeys.dbStudentGender];
    studentSchool = json[DBKeys.dbStudentSchool];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[DBKeys.dbColumnId] = id;
    data[DBKeys.dbStudentName] = studentName;
    data[DBKeys.dbStudentAge] = studentAge;
    data[DBKeys.dbStudentSchool];
    return data;
  }
}
