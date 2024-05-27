import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/core/sql_service/base_crud_db.dart';
import 'package:skin_disease_backup/core/sql_service/network_database_service.dart';
import 'package:skin_disease_backup/features/student_register/data/model/auth_result.dart';
import 'package:skin_disease_backup/features/student_register/data/source/register_source.dart';
import 'package:skin_disease_backup/features/student_register/domain/entities/register_entities.dart';

import '../../../../core/sql_service/db_keys.dart';

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
      log("Response:${response}");
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
