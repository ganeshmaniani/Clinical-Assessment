import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/core/sql_service/db_keys.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source.dart';

import '../../../../core/sql_service/base_crud_db.dart';

class HomeSourceImpl implements HomeSource {
  final BaseCRUDDataBaseServices baseCRUDDataBaseServices;
  HomeSourceImpl(this.baseCRUDDataBaseServices);
  @override
  Future<Either<Failure, StudentDetailModel>> getStudentDetail() async {
    try {
      List<Map<String, dynamic>> response =
          await baseCRUDDataBaseServices.getData(DBKeys.dbStudentTable);
      log(response.toString());
      List<StudentDetailModel> studentDetails =
          response.map((data) => StudentDetailModel.fromJson(data)).toList();
      log(studentDetails.first.toString());
      if (response.isNotEmpty) {
        return Right(studentDetails.first);
      } else {
        return const Left(Failure("No student details found"));
      }
    } catch (e) {
      return const Left(Failure("Failed to get student details"));
    }
  }
}
