import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class StudentDeleteUseCase implements UseCase<void, int> {
  final HomeRepository homeRepository;

  StudentDeleteUseCase(this.homeRepository);

  @override
  Future<Either<Failure, void>> call(int studentId) async {
    return await homeRepository.deleteStudent(studentId);
  }
}
