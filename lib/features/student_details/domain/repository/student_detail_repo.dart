import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/features/features.dart';

import '../../../../core/core.dart';

abstract class StudentDetailRepository {
  Future<Either<Failure, StudentDetailModel>> getSingleStudentDetail(int id);
  Future<Either<Failure, List<StudentDetailModel>>> getStudentList();
}
