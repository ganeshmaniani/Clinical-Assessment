import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/domain/repository/home_repository.dart';

class StudentDetailUseCase {
  final HomeRepository homeRepository;
  StudentDetailUseCase(this.homeRepository);
  Future<Either<Failure, StudentDetailModel>> call() async {
    return await homeRepository.getStudentDetail();
  }
}
