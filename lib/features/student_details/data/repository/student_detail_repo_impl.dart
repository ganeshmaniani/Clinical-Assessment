import 'package:dartz/dartz.dart';

import 'package:skin_disease_backup/core/errors/failure.dart';

import '../../../features.dart';

class StudentDetailRepositoryImpl implements StudentDetailRepository {
  final StudentDetailSource studentDeatailSource;
  StudentDetailRepositoryImpl(this.studentDeatailSource);
  @override
  Future<Either<Failure, StudentDetailModel>> getSingleStudentDetail(
      int id) async {
    return await studentDeatailSource.getSingleStudentDetail(id);
  }

  @override
  Future<Either<Failure, List<StudentDetailModel>>> getStudentList() async {
    return await studentDeatailSource.getStudentList();
  }
}
