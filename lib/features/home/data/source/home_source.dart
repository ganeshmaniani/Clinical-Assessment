import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';

import '../../../../core/errors/failure.dart';

abstract class HomeSource {
  Future<Either<Failure, StudentDetailModel>> getStudentDetail();
}
