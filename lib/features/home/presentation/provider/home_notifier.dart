import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final StudentDetailUseCase _studentDetailUseCase;
  final AddDiseaseUseCase _diseaseUseCase;
  final UpdateDiseaseUseCase _updateDiseaseUseCase;
  final StudentDeleteUseCase _deleteStudentUseCase;
  HomeNotifier(
    this._studentDetailUseCase,
    this._diseaseUseCase,
    this._updateDiseaseUseCase,
    this._deleteStudentUseCase,
  ) : super(const HomeState.initial());
  Future<Either<Failure, StudentDetailModel>> getStudentDetail() async {
    state.copyWith(isLoading: true);
    final result = await _studentDetailUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> addDisease(
      DiseaseEntities diseaseEntities) async {
    state.copyWith(isLoading: true);
    final result = await _diseaseUseCase(diseaseEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> updateDisease(
      DiseaseUpdateEntities diseaseUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result = await _updateDiseaseUseCase(diseaseUpdateEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> deleteStudent(int studentId) async {
    state.copyWith(isLoading: true);
    final result = await _deleteStudentUseCase(studentId);
    state.copyWith(isLoading: false);
    return result;
  }
}
