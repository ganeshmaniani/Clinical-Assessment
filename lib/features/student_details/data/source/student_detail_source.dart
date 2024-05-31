import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

abstract class StudentDetailSource {
  Future<Either<Failure, StudentDetailModel>> getSingleStudentDetail(int id);
  Future<Either<Failure, List<StudentDetailModel>>> getStudentList();
}
