import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../features.dart'; 
class RegisterSourceImpl implements RegisterSource {
  final BaseCRUDDataBaseServices baseCRUDDataBaseServices;
  RegisterSourceImpl(this.baseCRUDDataBaseServices);
  @override
  Future<Either<Failure, AuthResult>> register(
      RegisterEntities registerEntities) async {
    try {
      Map<String, dynamic> data = {
        DBKeys.dbStudentName: registerEntities.studentName,
        DBKeys.dbStudentAge: registerEntities.studentAge,
        DBKeys.dbStudentGender: registerEntities.studentGender,
        DBKeys.dbStudentSchool: registerEntities.schoolName
      };
      var response = await baseCRUDDataBaseServices.insertData(
          DBKeys.dbStudentTable, data);
      log("Response:${data[DBKeys.dbStudentName]}");

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setInt(DBKeys.dbColumnId, data[DBKeys.dbColumnId]);
      await prefs.setString(DBKeys.dbStudentName, data[DBKeys.dbStudentName]);
      if (response != null) {
        return const Right(AuthResult.success);
      } else {
        return const Left(Failure("Please enter valid data"));
      }
    } catch (e) {
      log("StudentTableError:${e.toString()}");
      return const Left(Failure('Registration Failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> registerEdit(
      RegisterEditEntities registerEditEntities) async {
    try {
      var data = {
        DBKeys.dbColumnId: registerEditEntities.id,
        DBKeys.dbStudentName: registerEditEntities.studentName,
        DBKeys.dbStudentAge: registerEditEntities.studentAge,
        DBKeys.dbStudentGender: registerEditEntities.studentGender,
        DBKeys.dbStudentSchool: registerEditEntities.schoolName
      };
      log("Data:${data.toString()}");
      var response = await baseCRUDDataBaseServices.updateDataById(
          DBKeys.dbStudentTable, data, int.parse(registerEditEntities.id));

      if (response != null) {
        return const Right(AuthResult.success);
      } else {
        return const Left(Failure("Please enter valid data"));
      }
    } catch (e) {
      log("StudentTableError:${e.toString()}");
      return const Left(Failure('Registration Failed'));
    }
  }
}
