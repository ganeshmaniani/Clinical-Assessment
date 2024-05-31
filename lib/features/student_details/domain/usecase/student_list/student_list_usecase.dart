import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class StudentListUseCase {
  final StudentDetailRepository studentDetailRepository;
  StudentListUseCase(this.studentDetailRepository);
  Future<Either<Failure, List<StudentDetailModel>>> call() async {
    return await studentDetailRepository.getStudentList();
  }
}
