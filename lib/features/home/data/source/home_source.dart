import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_entities.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_update_entities.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeSource {
  Future<Either<Failure, StudentDetailModel>> getStudentDetail();
  Future<Either<Failure, dynamic>> addDisease(DiseaseEntities diseaseEntities);
  Future<Either<Failure, dynamic>> updateDisease(
      DiseaseUpdateEntities diseaseUpdateEntities);
  Future<Either<Failure, void>> deleteStudent(int studentId);
}
