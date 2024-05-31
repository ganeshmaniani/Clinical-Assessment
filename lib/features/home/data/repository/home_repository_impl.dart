import 'package:dartz/dartz.dart';
import 'package:skin_disease_backup/core/errors/failure.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/data/source/home_source.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_entities.dart';
import 'package:skin_disease_backup/features/home/domain/entities/disease_update_entities.dart';
import 'package:skin_disease_backup/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeSource homeSource;
  HomeRepositoryImpl(this.homeSource);
  @override
  Future<Either<Failure, StudentDetailModel>> getStudentDetail() async {
    return await homeSource.getStudentDetail();
  }

  @override
  Future<Either<Failure, dynamic>> addDisease(
      DiseaseEntities diseaseEntities) async {
    return await homeSource.addDisease(diseaseEntities);
  }

  @override
  Future<Either<Failure, dynamic>> updateDisease(
      DiseaseUpdateEntities diseaseUpdateEntities) async {
    return await homeSource.updateDisease(diseaseUpdateEntities);
  }

  @override
  Future<Either<Failure, void>> deleteStudent(int studentId) async {
    return await homeSource.deleteStudent(studentId);
  }
}
