import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/core/sql_service/db_keys.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_entities.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_update_entities.dart';

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
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt(DBKeys.dbColumnId, studentDetails.first.id ?? 0);
        return Right(studentDetails.first);
      } else {
        return const Left(Failure("No student details found"));
      }
    } catch (e) {
      return const Left(Failure("Failed to get student details"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addDisease(
      DiseaseEntities diseaseEntities) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var studentId = prefs.getInt(DBKeys.dbColumnId);
    try {
      var data = {
        DBKeys.dbStudentId: studentId,
        DBKeys.dbDiseaseName: diseaseEntities.diseaseName,
        DBKeys.dbDiseaseScore: diseaseEntities.diseaseScore,
        DBKeys.dbDiseaseImage: diseaseEntities.diseaseImage ?? Uint8List(0),
      };
      log("RESPONSE FOR DISEASEDETAIL:${data.toString()}");
      if (studentId != null) {
        var response = await baseCRUDDataBaseServices.insertData(
            DBKeys.dbDiseaseTable, data);
        log("RESPONSE FOR:${response.toString()}");
        if (response != null) {
          return Right(response);
        } else {
          return const Left(Failure("Please choose correctly"));
        }
      } else {
        return const Left(Failure("UserId Not Found"));
      }
    } catch (e) {
      return Left(Failure("CatchError:${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateDisease(
      DiseaseUpdateEntities diseaseUpdateEntities) async {
    try {
      var data = {
        // DBKeys.dbColumnId: diseaseUpdateEntities.id,
        DBKeys.dbDiseaseName: diseaseUpdateEntities.diseaseName,
        DBKeys.dbDiseaseScore: diseaseUpdateEntities.diseaseScore,
        DBKeys.dbDiseaseImage:diseaseUpdateEntities.diseaseImage
      };
      log("Updating data for disease with ID: ${diseaseUpdateEntities.id}");

      log("RESPONSE FOR UPDATE DISEASEDETAIL:${data.toString()}");
      var response = await baseCRUDDataBaseServices.updateDataById(
        DBKeys.dbDiseaseTable,
        data,
        diseaseUpdateEntities.id,
      );
      if (response != null) {
        return Right(response);
      } else {
        return const Left(Failure("Please choose correctly"));
      }
    } catch (e) {
      return Left(Failure("CatchError:${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(int studentId) async {
    try {
      var response = await baseCRUDDataBaseServices.deleteDataById(
          DBKeys.dbStudentTable, studentId);
      if (response != null) {
        return const Right(null);
      } else {
        return const Left(Failure("Does not delete student"));
      }
    } catch (e) {
      return Left(Failure("CatchError:${e.toString()}"));
    }
  }
}
