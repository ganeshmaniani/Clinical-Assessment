import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class StudentDetailUseCase {
  final HomeRepository homeRepository;
  StudentDetailUseCase(this.homeRepository);
  Future<Either<Failure, StudentDetailModel>> call() async {
    return await homeRepository.getStudentDetail();
  }
}
