import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_keys.dart';

class DataBaseService {
  Future<Database> setDataBase() async {
    final dbPath = await getDatabasesPath();
    var path = join(dbPath, DBKeys.dbName);
    var database =
        await openDatabase(path, version: 1, onCreate: _createDataBase);
    return database;
  }

  Future<void> _createDataBase(Database db, int version) async {
    String registerStudentTable =
        "CREATE TABLE ${DBKeys.dbStudentTable}(${DBKeys.dbColumnId} INTEGER PRIMARY KEY,${DBKeys.dbStudentName} TEXT NOT NULL,${DBKeys.dbStudentAge} TEXT NOT NULL,${DBKeys.dbStudentGender} TEXT NOT NULL,${DBKeys.dbStudentSchool} TEXT NOT NULL)";
    String diseaseTable =
        "CREATE TABLE ${DBKeys.dbDiseaseTable}(${DBKeys.dbColumnId} INTEGER PRIMARY KEY,${DBKeys.dbStudentId} INTEGER NOT NULL,${DBKeys.dbDiseaseName} TEXT NOT NULL,${DBKeys.dbDiseaseScore} INTEGER NOT NULL,${DBKeys.dbDiseaseImage} BLOB NOT NULL)";
    await db.execute(registerStudentTable);
    await db.execute(diseaseTable);
  }
}
