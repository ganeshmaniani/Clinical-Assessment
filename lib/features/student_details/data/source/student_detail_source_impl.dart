import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class StudentDetailSourceImpl implements StudentDetailSource {
  final BaseCRUDDataBaseServices baseCRUDDataBaseServices;
  StudentDetailSourceImpl(this.baseCRUDDataBaseServices);
  @override
  Future<Either<Failure, StudentDetailModel>> getSingleStudentDetail(
      int id) async {
    try {
      List<Map<String, dynamic>> response = await baseCRUDDataBaseServices
          .getDataById(DBKeys.dbStudentTable, id, DBKeys.dbColumnId);
      log("SingleStudentStudent:${response.toString()}");
      if (response.isNotEmpty) {
        List<StudentDetailModel> studentDetailModel =
            response.map((data) => StudentDetailModel.fromJson(data)).toList();

        return Right(studentDetailModel.first);
      } else {
        return const Left(Failure("Student detail Not Found"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentDetailModel>>> getStudentList() async {
    try {
      List<Map<String, dynamic>> response =
          await baseCRUDDataBaseServices.getData(DBKeys.dbStudentTable);
      log(response.toString());
      List<StudentDetailModel> studentDetails =
          response.map((data) => StudentDetailModel.fromJson(data)).toList();
      log(studentDetails.toString());
      if (response.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final int currentUserId = prefs.getInt(DBKeys.dbColumnId) ?? -1;
        studentDetails = studentDetails
            .where((student) => student.id != currentUserId)
            .toList();
        return Right(studentDetails);
      } else {
        return const Left(Failure("No student details found"));
      }
    } catch (e) {
      return const Left(Failure("Failed to get student details"));
    }
  }
}
