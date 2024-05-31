import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class SingleStudentDetailUseCase {
  final StudentDetailRepository studentDetailRepository;
  SingleStudentDetailUseCase(this.studentDetailRepository);
  Future<Either<Failure,StudentDetailModel>>call(int id)async{
    return await studentDetailRepository.getSingleStudentDetail(id);
  }
}
