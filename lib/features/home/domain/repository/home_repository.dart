import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../features.dart';

abstract class HomeRepository {
  Future<Either<Failure, StudentDetailModel>> getStudentDetail();
  Future<Either<Failure, dynamic>> addDisease(DiseaseEntities diseaseEntities);
  Future<Either<Failure, dynamic>> updateDisease(
      DiseaseUpdateEntities diseaseUpdateEntities);
  Future<Either<Failure, void>> deleteStudent(int studentId);
}
